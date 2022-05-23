import 'dart:async';

import 'package:event_bus/event_bus.dart';

class EventBusUtil {
  static final EventBus _eventBus = EventBus();

  //获取单例
  static EventBus getInstance() {
    return _eventBus;
  }

  //返回某事件的订阅者
  static StreamSubscription<T> listen<T extends Event>(
      Function(T event) onData) {
    //内部流属于广播模式，可以有多个订阅者
    return _eventBus.on<T>().listen(onData);
  }

  //发送事件
  static void fire<T extends Event>(T e) {
    _eventBus.fire(e);
  }
}

abstract class Event {}

/// 底部tabbar 切换事件
class TabBarChangeEvent extends Event {
  int index;
  TabBarChangeEvent(this.index);
}

class RefreshRpEvent extends Event {}
class RefreshDashboardEvent extends Event {}

class ChangeSegmentIndexEvent extends Event {
  int index;
  ChangeSegmentIndexEvent(this.index);
}