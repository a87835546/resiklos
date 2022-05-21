import 'package:intl/intl.dart';

/*
* 关于时间工具
* @作者路很长
* @路很长的博客地址 https://blog.csdn.net/m0_37667770/article/details/80903890
* @路很长github https://github.com/luhenchang/flutter_study
*/
class DataUtils {
  // 工厂模式
  factory DataUtils() => _getInstance();

  static DataUtils get instance => _getInstance();
  static DataUtils? _instance;

  DataUtils._internal() {
    // 初始化
  }

  static DataUtils _getInstance() {
    if (_instance == null) {
      _instance = new DataUtils._internal();
    }
    return _instance!;
  }

  ///将时间格式转化为时间戳
  // String getTimeStap() {}

  ///1.获取从某一天开始到某一天结束的所有的中间日期，例如输入 startTime:2019:07:31 endTime:2019:08:31 就会返回所有的中间天数。
  ///startTime和endTime格式如下都可以
  ///使用:  List<String> mdata=DataUtils.instance.getTimeBettwenStartTimeAndEnd(startTime:"2019-07-11",endTime:"2019-08-29",format:"yyyy年MM月dd");
  ///结果:[2019年07月11, 2019年07月12, 2019年07月13, 2019年07月14, 2019年07月15, 2019年07月16, 2019年07月17, 2019年07月18, 2019年07月19, 2019年07月20, 2019年07月21, 2019年07月22, 2019年07月23, 2019年07月24, 2019年07月25, 2019年07月26, 2019年07月27, 2019年07月28, 2019年07月29, 2019年07月30, 2019年07月31, 2019年08月01, 2019年08月02, 2019年08月03, 2019年08月04, 2019年08月05, 2019年08月06, 2019年08月07, 2019年08月08, 2019年08月09, 2019年08月10, 2019年08月11, 2019年08月12, 2019年08月13, 2019年08月14, 2019年08月15, 2019年08月16, 2019年08月17, 2019年08月18, 2019年08月19, 2019年08月20, 2019年08月21, 2019年08月22, 2019年08月23, 2019年08月24, 2019年08月25, 2019年08月26, 2019年08月27, 2019年08月28, 2019年08月29]
  List<String> getTimeBettwenStartTimeAndEnd(
      {startTime: String, endTime: String, format: String}) {
    List<String> mDataList = [];
    //记录往后每一天的时间搓，用来和最后一天到做对比。这样就能知道什么时候停止了。
    int allTimeEnd = 0;
    //记录当前到个数(相当于天数)
    int currentFlag = 0;
    DateTime startData = DateTime.parse(startTime);
    DateTime endData = DateTime.parse(endTime);
    var mothFormatFlag = new DateFormat(format);
    while (endData.millisecondsSinceEpoch > allTimeEnd) {
      allTimeEnd =
          startData.millisecondsSinceEpoch + currentFlag * 24 * 60 * 60 * 1000;
      var dateTime = new DateTime.fromMillisecondsSinceEpoch(
          startData.millisecondsSinceEpoch + currentFlag * 24 * 60 * 60 * 1000);
      String nowMoth = mothFormatFlag.format(dateTime);
      mDataList.add(nowMoth);
      currentFlag++;
    }
    return mDataList;
  }

  ///传入starTime格式 2012-02-27 13:27:00 或者 "2012-02-27等....
  ///dayNumber：从startTime往后面多少天你需要输出
  ///formart:获取到的日期格式。"yyyy年MM月dd" "yyyy-MM-dd" "yyyy年" "yyyy年MM月" "yyyy年\nMM月dd" 等等
  ///使用：DataUtils.instance.getTimeStartTimeAndEnd(startTime:"2019-07-11",dayNumber:10,format:"yyyy年MM月dd");
  ///结果:[2019年07月11, 2019年07月12, 2019年07月13, 2019年07月14, 2019年07月15, 2019年07月16, 2019年07月17, 2019年07月18, 2019年07月19, 2019年07月20, 2019年07月21]
  List<String> getTimeStartTimeAndEnd(
      {startTime: String, dayNumber: int, format: String}) {
    List<String> mDataList = [];
    //记录往后每一天的时间搓，用来和最后一天到做对比。这样就能知道什么时候停止了。
    int allTimeEnd = 0;
    //记录当前到个数(相当于天数)
    int currentFlag = 0;
    DateTime startData = DateTime.parse(startTime);
    var mothFormatFlag = new DateFormat(format);
    while (dayNumber >= currentFlag) {
      var dateTime = new DateTime.fromMillisecondsSinceEpoch(
          startData.millisecondsSinceEpoch + currentFlag * 24 * 60 * 60 * 1000);
      String nowMoth = mothFormatFlag.format(dateTime);
      mDataList.add(nowMoth);
      currentFlag++;
    }
    return mDataList;
  }

  ///格式化时间戳
  ///timeSamp:毫秒值
  ///format:"yyyy年MM月dd hh:mm:ss" "yyy😄MM👌dd hh🙅MM🐶dd" "yyyy:MM:dd"......
  ///结果： 2019😄08👌04 02🙅08🐶02
  getFormartData({timeSamp: int, format: String}) {
    var dataFormat = new DateFormat(format);
    var dateTime = new DateTime.fromMillisecondsSinceEpoch(timeSamp);
    String formatResult = dataFormat.format(dateTime);
    print(formatResult);
  }

  ///获取某一个月的最后一天。
  ///我们能提供和知道的条件有:(当天的时间,)
  ///timeSamp:时间戳 单位（毫秒）
  ///format:想要的格式 "yyyy年MM月dd hh:mm:ss" "yyy😄MM👌dd hh🙅MM🐶dd" "yyyy:MM:dd"
  getEndMoth({timeSamp: int, format: String}) {
    var dataFormat = new DateFormat(format);
    var dateTime = new DateTime.fromMillisecondsSinceEpoch(timeSamp);
    print("年=" + dateTime.year.toString());
    print("月=" + dateTime.month.toString());
    var dataNextMonthData = new DateTime(dateTime.year, dateTime.month + 1, 1);
    int nextTimeSamp =
        dataNextMonthData.millisecondsSinceEpoch - 24 * 60 * 60 * 1000;
    //取得了下一个月1号码时间戳
    var dateTimeeee = new DateTime.fromMillisecondsSinceEpoch(nextTimeSamp);
    String formatResult = dataFormat.format(dateTimeeee);
    return formatResult;
  }

  ///获取某一个月的最后一天。
  ///我们能提供和知道的条件有:(当天的时间,)
  ///timeSamp:时间戳 单位（毫秒）
  ///format:想要的格式 "yyyy年MM月dd hh:mm:ss" "yyy😄MM👌dd hh🙅MM🐶dd" "yyyy:MM:dd"
  getEndMothFor({mothFormart: String, format: String}) {
    DateTime startData = DateTime.parse(mothFormart);
    var dataFormat = new DateFormat(format);
    var dateTime = new DateTime.fromMillisecondsSinceEpoch(
        startData.millisecondsSinceEpoch);
    print("年=" + dateTime.year.toString());
    print("月=" + dateTime.month.toString());
    var dataNextMonthData = new DateTime(dateTime.year, dateTime.month + 1, 1);
    int nextTimeSamp =
        dataNextMonthData.millisecondsSinceEpoch - 24 * 60 * 60 * 1000;
    //取得了下一个月1号码时间戳
    var dateTimeeee = new DateTime.fromMillisecondsSinceEpoch(nextTimeSamp);
    String formatResult = dataFormat.format(dateTimeeee);
    return formatResult;
  }
}

String addTimeZone(String time) {
  DateTime startData = DateTime.parse(time);
  DateFormat dataFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
  var dateTime =
      DateTime.fromMillisecondsSinceEpoch(startData.millisecondsSinceEpoch);
  int nextTimeSamp = dateTime.millisecondsSinceEpoch + 8 * 60 * 60 * 1000;
//取得了下一个月1号码时间戳
  var dateTimeeee = new DateTime.fromMillisecondsSinceEpoch(nextTimeSamp);
  String formatResult = dataFormat.format(dateTimeeee);
  return formatResult;
}
