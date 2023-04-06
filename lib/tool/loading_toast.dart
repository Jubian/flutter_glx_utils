
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoadingToast {

  static showToast(String? text,{bool userInteractions = true, String? routingName,int? seconds, bool? dismissOnTap}) {
    if (text != null && text.isNotEmpty && (routingName == null || Get.routing.current == routingName)) {
      EasyLoading.instance.userInteractions = userInteractions;
      EasyLoading.showToast(
        text,
        duration: seconds != null ? Duration(seconds: seconds) : null,
        dismissOnTap: dismissOnTap
      );
    }
  }

  static show({bool userInteractions = false}) {
    EasyLoading.instance.userInteractions = userInteractions;
    EasyLoading.show();
  }

  static dismiss({bool animation = true}) {
    EasyLoading.dismiss(animation: animation);
  }
  
}