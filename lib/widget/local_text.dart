import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalText extends Text {
  LocalText(String data,{TextStyle? style,int? maxLines,double? textScaleFactor,TextAlign? textAlign}) : super(
    data.tr,
    style: style,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLines,
    textScaleFactor:textScaleFactor,
    textAlign:textAlign
  );
}