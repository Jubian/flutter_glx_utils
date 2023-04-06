// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';

// class CustomToast {
//   late LoadingToast fToast;

//   CustomToast.show(String text) {
//     fToast = EasyLoading.show();
//     final context = Get.overlayContext;
//     if (context != null) {
//       fToast.init(context);
//       _showToast(text);
//     }
//   }

//   _showToast(String text) { 
//     Widget toast = Container(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//         decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12.0),
//         color: Colors.black87,
//         ),
//         child: Text(text,style: TextStyle(color: Colors.white),)
//     );


//     fToast.showToast(
//         child: toast,
//         gravity: ToastGravity.CENTER,
//         toastDuration: Duration(seconds: 2),
//     );
//   }
// }