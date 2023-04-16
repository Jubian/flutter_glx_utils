
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CustomSwiperPaginationBuilder extends SwiperPlugin {
  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color? activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color? color;

  ///Size of the rect when activate
  final Size activeSize;

  ///Size of the rect
  final Size size;

  /// Space between rects
  final double space;

  /// Space between rects
  final double radius;

  final Key? key;

  const CustomSwiperPaginationBuilder({
    this.activeColor,
    this.color,
    this.key,
    this.size = const Size(10.0, 2.0),
    this.activeSize = const Size(10.0, 2.0),
    this.space = 2.0,
    this.radius = 1.0
  });

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    final themeData = Theme.of(context);
    final activeColor = this.activeColor ?? themeData.primaryColor;
    final color = this.color ?? themeData.scaffoldBackgroundColor;

    final list = <Widget>[];

    final itemCount = config.itemCount;
    final activeIndex = config.activeIndex;
    if (itemCount > 20) {
      debugPrint(
        'The itemCount is too big, we suggest use FractionPaginationBuilder '
        'instead of DotSwiperPaginationBuilder in this situation',
      );
    }

    for (var i = 0; i < itemCount; ++i) {
      final active = i == activeIndex;
      final size = active ? activeSize : this.size;
      Widget widget;
      if (active) {
       widget = Container(
          key: Key('pagination_$i'),
          margin: EdgeInsets.all(space),
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),color: activeColor),
        );
      } else {
        widget = Container(
          key: Key('pagination_$i'),
          margin: EdgeInsets.all(space),
          width: size.height,
          height: size.height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),color: color),
        );
      }
      list.add(
        widget
      );
    }

    if (config.scrollDirection == Axis.vertical) {
      return Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      return Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }
  }
}