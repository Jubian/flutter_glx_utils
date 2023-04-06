import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

class ImageSheet extends StatelessWidget {

  ImageSheet.fromGrid({
    required this.imagePath,
    required this. grid,
    required this. index,
    this.imgPaint,
    this.size
  });

  final Size? size;

  final Offset grid;

  final Offset index;

  final String imagePath;

  final Paint? imgPaint;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: load(imagePath),
      builder: (BuildContext ctx,AsyncSnapshot<ui.Image> snp) {
        if (snp.connectionState == ConnectionState.done) {
          final image = snp.data as ui.Image;
          return CustomPaint(
            size: size ?? Size(image.width / grid.dx, image.height / grid.dy),
            painter: ImageSheetPainter.fromGrid(
              image: snp.data as ui.Image, 
              grid: grid, 
              index: index
          )
          );
        }
        return Container();
      }
    );
  }

  /// 通过assets路径，获取资源图片
  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
  
}

class ImageSheetPainter extends CustomPainter {

  ImageSheetPainter.fromGrid({
    required this.image,
    required Offset grid,
    required Offset index,
    this.imgPaint,
  }) {
    final width = image.width / grid.dx;
    final height = image.height / grid.dy;
    srcSize = Rect.fromLTWH(
                index.dx*width,
                index.dy*height,
                width,
                height,
              );
  }

  late ui.Image image;

  late Rect srcSize;

  Paint? imgPaint;

  @override
  void paint(Canvas canvas, Size size) {
    final drawRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(image, srcSize, drawRect, imgPaint ?? Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    
    return false;
  }

}