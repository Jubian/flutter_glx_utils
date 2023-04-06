
import 'package:flutter/material.dart';
import 'package:flutter_glx_utils/glx_manager.dart';

// ignore: constant_identifier_names
const bool DEBUG_NET_IMAGE = true;

class NetImage extends StatelessWidget {

  const NetImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholderImgPath
  });

  final String? imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final String? placeholderImgPath;

  Widget _placeHorlder() {
    if (placeholderImgPath != null  ) {
      return Image.asset(
        placeholderImgPath!,
        width: width, 
        height: height, 
        fit: fit,
      );
    } else {
      GLXManger().ensureNetPlacehoderIsSet();
      return Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          color: Colors.white,
          child: Image.asset(GLXManger().netPlacehoder!,height: 80),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty || !DEBUG_NET_IMAGE) {
      return _placeHorlder();
    } else {
      // return CachedNetworkImage(
      //   useOldImageOnUrlChange: true,
      //   imageUrl: imageUrl!,
      //   placeholder: (ctx,string) => _placeHorlder(),
      //   errorWidget: (ctx,string,err) => _placeHorlder(),
      //   fit: fit,
      //   width: width,
      //   height: height
      // );
      GLXManger().ensureNetPlacehoderIsSet();
      return FadeInImage.assetNetwork(
        placeholder: placeholderImgPath ?? GLXManger().netPlacehoder!,
        image: imageUrl!,
        fit: fit,
        placeholderFit: BoxFit.contain,
        placeholderErrorBuilder: (_,__,___)=> _placeHorlder(),
        imageErrorBuilder: (_,__,___)=> _placeHorlder(),
        width: width,
        height: height,
      );

// FadeInImage(
//   placeholder: Image.asset(
//           placeholderImgPath!,
//           width: width, 
//           height: height, 
//           fit: fit,
//         ) //Assets.imagesImgGoodsPlaceholder,//your placeholder
//   image: Image.network(
//         imageUrl!,
//         fit: fit,
//         loadingBuilder: (_,__,___)=> _placeHorlder(),
//         errorBuilder: (_,__,___)=> _placeHorlder(),
//         width: width,
//         height: height,
//       )
// );
    }
  }


}