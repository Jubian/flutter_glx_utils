import 'package:dio/dio.dart';

class GLXManger {
  static final GLXManger _singleton = GLXManger._internal();

  // 工厂构造函数，用于获取Config的唯一实例
  factory GLXManger() {
    return _singleton;
  }

  // 私有构造函数，避免外部实例化
  GLXManger._internal() {
    _initDio();
  }

  // 通用图片占位符
  String? netPlacehoder;

  late Dio dio;

  String baseUrl = '';

  int conectTimeout = 10000;

  int receiveTimeout = 10000;

  ///
  ///
  /// 完成DIO的基础配置
  ///

  void _initDio() {
    dio = Dio();
    // 设置本地代理，避免charles抓不到数据
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    //   client.findProxy = (url) {
    //     return 'PROXY 192.168.3.36:8888;DIRECT;';
    //     // 'PROXY 192.168.3.36:8888';
    //     // 本机
    //     // Api.DEBUT_TYPE == DebugType.release ? 'DIRECT' : 'PROXY 192.168.3.36:8888';
    //     // cc
    //     // Api.DEBUT_TYPE == DebugType.release ? 'DIRECT' : 'PROXY 192.168.3.146:8888';
    //     // zf
    //     // Api.DEBUT_TYPE == DebugType.release ? 'DIRECT' : 'PROXY 192.168.3.163:8888';
    //   };
    //   client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) {
    //       return true;
    //     };
    //   return null;
    // };
    //添加拦截器
    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //     print("请求之前");
    //   },
    //   onResponse: (response, handler) {
    //     print("响应之前");
    //   },
    //   onError: (error, handler) {
    //     print("错误之前");
    //   }
    // ));
  }


  // 确保_netPlacehoder不为空的方法
  void ensureNetPlacehoderIsSet() {
    assert(netPlacehoder != null, '请先设置通用图片占位符');
  }
}