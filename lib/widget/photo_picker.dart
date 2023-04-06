import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPicker extends StatelessWidget {

  PhotoPicker({
    super.key,
    required this.pickSuccess,
    this.isMulti = false,
    required this.photoWidget,
    required this.cameraWidget
    // this.imageQuality = 100,
    // this.maxHeight = 1920,
    // this.maxWidth = 1080
  });

  final void Function(List<String> images) pickSuccess;
  final bool isMulti;
  final Widget photoWidget;
  final Widget cameraWidget;
  // final int? imageQuality;
  // final double? maxHeight;
  // final double? maxWidth;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
          // Pick an image
          Get.back();
          if (isMulti) {
            // Pick multiple images
            final List<XFile> images = await _picker.pickMultiImage();
            final list = images.map((e) => e.path).toList();
            pickSuccess(list);
          } else {
            XFile? file = await _picker.pickImage(source: ImageSource.gallery);
            if (file != null) pickSuccess([file.path]);
          }
        },
          child: photoWidget
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            // Capture a photo
            Get.back();
            XFile? file = await _picker.pickImage(source: ImageSource.camera);
            if (file != null) pickSuccess([file.path]);
          }, 
          child: cameraWidget
        ),
      ],
    );
  }
  
}