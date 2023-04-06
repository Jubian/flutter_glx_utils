//业务code成功
const codeResponseSuccess = 200;
//其他未知错误
const codeErrorUnknown = -1;

///
/// 设计Resource统一返回值
///
///
class Resource {
  int code;
  String? msg;
  dynamic data;

  ///
  /// 业务请求成功，服务端返回业务code值为codeResponseSuccess
  ///
  Resource.success(this.data, {this.code = codeResponseSuccess});

  ///
  /// 业务code不为success或者其他错误
  ///
  Resource.error(this.msg, this.code,{this.data});

  ///
  ///
  /// 业务流程是否正常
  ///
  bool isSuccess(){
    return code == codeResponseSuccess;
  }
} 