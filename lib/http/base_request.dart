

import 'package:dio/dio.dart';

class BaseRequest {
  BaseRequest();  // 构造函数
  final token = CancelToken();

  /// 是否空数据，可以用来判断是否需要展示空页面
  var showEmpty = false;

  cancelRequest() {
    token.cancel();
  }
}