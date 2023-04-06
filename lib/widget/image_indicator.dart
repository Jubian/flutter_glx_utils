
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';


class ImageIndicator extends Decoration {

  ImageIndicator({required this.image, required this.size});

  final ui.Image image;
  final Size size;


  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomBoxPainter(
      image: image,
      size: size,
      onChanged: onChanged
    );
  }
  
}

class _CustomBoxPainter extends BoxPainter {

  _CustomBoxPainter({required this.image, required this.size, required VoidCallback? onChanged}): super(onChanged);

  final Size size;
  final ui.Image? image;

  /// 通过assets路径，获取资源图片
  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
  
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    var x = ((configuration.size?.width ?? 0) - size.width)/2+offset.dx;
    var y = (configuration.size?.height ?? 0) - size.height;
    Rect src = Rect.fromLTWH(0, 0, image!.width.toDouble(), image!.height.toDouble());
    Rect dst = Rect.fromLTWH(x, y, size.width, size.height);
    canvas.drawImageRect(image!, src, dst, Paint());
    
  }
}