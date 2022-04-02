import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:resiklos/sign_up_in/sign_request.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/utils/toast.dart';

import 'app_singleton.dart';

/// 网络请求异常信息类型
enum HttpManagerErrorType {
  /// token失效
  tokenExpired,

  /// 服务异常
  internalServerError,

  /// 需要登陆
  needLogin,

  /// 请求参数异常
  paramsError
}

class HttpManager {
  static const bool _debug = kDebugMode;

  static String baseUrl = _debug
      ? (AppSingleton.devMode == DevMode.local
          ? "https://localhost:9001/api/v1/"
          : (AppSingleton.devMode == DevMode.staging
              ? "https://staging.resiklos.app/api/v1/"
              : "https://api.resiklos.app/api/v1/"))
      : "https://api.resiklos.app/api/v1/";

  static final Dio _dio = Dio();

  static const int timeout = 1500;

  static List<CancelToken> _tokens = [];

  static _config() async {
    if(_dio.interceptors.isEmpty) {
      _dio.interceptors.add(HttpInterceptor());
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) {
          return true;
        };
      };
    }
  }

  static get(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, String>? params}) async {
    _config();
    Options options = Options(headers: headers, sendTimeout: timeout);
    options.contentType = ContentType.json.toString();
    Response response = await _dio.get(baseUrl + url,
        queryParameters: params, options: options);
    try {
      // log("$response");
      if (response.statusCode == 200) {
        if (response.data['code'] == 200) {
          return response.data;
        } else if (response.data['code'] == 500) {
          return HttpManagerErrorType.internalServerError;
        } else if (response.data['code'] == 511) {
          return HttpManagerErrorType.tokenExpired;
        } else {
          return response.data;
        }
      }
    } catch (error) {
      EasyLoading.dismiss();
      log("request error :${error.toString()}", stackTrace: StackTrace.current);
    } finally {
      EasyLoading.dismiss();
    }
  }

  static post(
      {required String url,
      Map<String, dynamic>? headers,
      required Map<String, dynamic> params}) async {
    _config();
    String _token = AppSingleton.userInfoModel?.token ?? "";
    if (headers == null) {
      headers = Map();
    }
    headers.putIfAbsent("token", () => _token);
    Options options = Options(headers: headers, sendTimeout: timeout);
    log("post request params $headers");
    CancelToken token = CancelToken();
    _tokens.add(token);
    Response response = await _dio.post(baseUrl + url,
        data: params, options: options, cancelToken: token);

    try {
      log("response data---->>>>>${response.data}");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.data;
      }
    } catch (error) {
      log("request error :${error.toString()}", stackTrace: StackTrace.current);
      EasyLoading.dismiss();
    } finally {
      log("finally ");
      EasyLoading.dismiss();
    }
    return Future.value(true);
  }

  static upload(
      {required String url,
      Map<String, dynamic>? headers,
      required FormData params}) async {
    Options options = Options(headers: headers, sendTimeout: timeout);
    log("post request params ${params.fields}");
    Map<String, dynamic> map = HashMap();
    map.putIfAbsent("file", () => params);
    Response response =
        await _dio.post(baseUrl + url, data: params, options: options);

    try {
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (error) {
      log("request error :${error.toString()}", stackTrace: StackTrace.current);
    } finally {
      log("finally ");
    }
    return Future.value(true);
  }

  static cancelRequest() {
    _tokens.forEach((element) {
      log('取消网络请求 ----->>>>>> $element');
    });
  }
}

class HttpInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // log("http interceptor request error response : ${err.response}");
    // log("http interceptor request error info : ${err.toString()}");
    EasyLoading.dismiss();
    // showErrorText("services has broken");
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    EasyLoading.dismiss();
    // log("http interceptor request  response : ${response.toString()}");
    if (response.data["code"] == 511) {
      log("token has expired");
      // showWarnToast("login has expired");
      // SignRequest.logout(context);
      NavigatorUtil.pushLogin();
      // showWarnToast("token has expired");
    } else if (response.data["code"] != 200) {
      // showWarnToast("login has expired");
    }
    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    showLoading();

    String token = AppSingleton.userInfoModel?.token ?? "";
    options.headers.putIfAbsent("token", () => token);
    options.receiveTimeout = 15 * 1000;
    options.connectTimeout = 15 * 1000;

    if (kIsWeb) {
      options.headers.putIfAbsent("Access-Control-Allow-Origin", () => "*");
      options.headers
          .putIfAbsent("Access-Control-Allow-Credentials", () => true);
    }
    // log("http interceptor request  options headers: ${options.headers}");
    // log("http interceptor request  options queryParameters: ${options.queryParameters}");
    log("http interceptor request  options path: ${options.path}");
    handler.next(options);
  }
}
