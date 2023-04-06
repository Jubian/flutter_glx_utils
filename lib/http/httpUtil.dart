// ignore_for_file: file_names

import 'package:flutter_glx_utils/glx_manager.dart';

import '/tool/loading_toast.dart';
import './resource.dart';
import 'package:dio/dio.dart';

const String glxMethodPost = 'post';

const String glxMethodGet = 'get';

class HttpUtil {
  ///
  /// get 请求
  ///
  ///
  static Future<Resource> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      bool loading = true,
      bool showMessage = false,
      bool showErrorMsg = true,
      int? connectTimeout,
      int? receiveTimeout,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      }) async {
    return _sendRequest(glxMethodGet, path,null, queryParameters,loading,showMessage,showErrorMsg,connectTimeout,receiveTimeout, options, cancelToken,onReceiveProgress);
  }

  ///
  /// post 请求
  ///
  ///
  static Future<Resource> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool loading = true,
    bool showMessage = false,
    bool showErrorMsg = true,
    int? connectTimeout,
    int? receiveTimeout,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _sendRequest(glxMethodPost, path, data,queryParameters, loading,showMessage,showErrorMsg,connectTimeout,receiveTimeout, options, cancelToken,onReceiveProgress);
  }

  ///
  ///统一发送请求预计返回值统一处理
  ///
  static Future<Resource> _sendRequest(
    String method,
    String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool loading,
    bool showMessage,
    bool showErrorMsg,
    int? connectTimeout,
    int? receiveTimeout,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  ) async {
    if (loading) LoadingToast.show();
    var dio = GLXManger().dio;
    dio.options.connectTimeout = Duration(milliseconds: connectTimeout ?? GLXManger().conectTimeout);
    dio.options.receiveTimeout = Duration(milliseconds: receiveTimeout ?? GLXManger().receiveTimeout);
    try {
      Response? rsp;
      if (method == glxMethodGet) {
        rsp = await dio.get(path, queryParameters: queryParameters,cancelToken: cancelToken);
      } else if (method == glxMethodPost) {
        rsp = await dio.post(path, data: data,queryParameters:queryParameters,cancelToken: cancelToken);
      }
      if (rsp == null)  return _unknowError(showErrorMsg);
      
      return _handleResponse(rsp,showMessage,showErrorMsg);
    } catch (err) {
      String error = _handleException(err);
      if (showErrorMsg) LoadingToast.showToast(error);
      return Resource.error(error, codeErrorUnknown);
    } finally {
      if (loading) LoadingToast.dismiss();
    }
  }

  static Resource _unknowError(bool isShow) {
    String error = '未知错误';
    if (isShow) LoadingToast.showToast(error);
    return Resource.error(error, codeErrorUnknown);
  }

   ///
  /// 统一处理解析数据
  ///
  static Resource _handleResponse(Response response, bool showMessage, bool showErrorMsg) {
    if (_isSuccess(response.statusCode)) {
      var data = response.data;
      var code = data['code'];
      
      String msg = data['msg'];
      if (code == codeResponseSuccess) {
        //这里尽量将业务中的code丢出去，方便开发中需要根据该code来进行一些特殊的处理
        if (showMessage) LoadingToast.showToast(msg);
        return Resource.success(data['data'],code: code);
      } else {
        if (showErrorMsg) LoadingToast.showToast(msg);
        return Resource.error(msg, code,data: data['data']);
      }
    } else {
      return _unknowError(showErrorMsg);
    }
  }

  ///状态码是否成功
  static bool _isSuccess(int? statusCode) {
    return (statusCode != null && statusCode == 200);
  }

  ///
  /// 统一处理异常-返回错误信息
  ///
  static String _handleException(ex) {
    if (ex is DioError) {
      switch (ex.type) {
        case DioErrorType.connectionTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          return '网络超时';
        case DioErrorType.unknown:
          return '网络异常';
        case DioErrorType.badResponse:
          // int? statusCode = ex.response?.statusCode;
          return '网络异常';
          // switch (statusCode) {
          //   case 400:
          //     return '请求语法错误';
          //   case 401:
          //     return '没有权限';
          //   case 403:
          //     return '服务器拒绝执行';
          //   case 404:
          //     return '请求资源部存在';
          //   case 405:
          //     return '请求方法被禁止';
          //   case 500:
          //     return '服务器内部错误';
          //   case 502:
          //     return '无效请求';
          //   case 503:
          //     return '服务器异常';
          //   default:
          //     return '网络异常';
          // }
        default:
          return '网络异常';
      }
    } else {
      return '网络异常';
    }
  }
}
