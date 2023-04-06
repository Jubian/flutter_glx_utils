// ignore_for_file: file_names

import 'dart:math' as math;
import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';

enum TextIconDirection {
  leftIcon,
  rightIcon,
  topIcon,
  bottomIcon
}

/// 可以自定义图标文字排列方向的button组件
class TextIconButton extends TextButton {
  TextIconButton({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    double space = 8,
    TextIconDirection direction = TextIconDirection.leftIcon,
    required Widget icon,
    required Widget label,
  }) : 
       super(
         key: key,
         onPressed: onPressed,
         onLongPress: onLongPress,
         onHover: onHover,
         onFocusChange: onFocusChange,
         style: style,
         focusNode: focusNode,
         autofocus: autofocus ?? false,
         clipBehavior: clipBehavior ?? Clip.none,
         child: _TextButtonWithIconChild(icon: icon, label: label,space: space,direction: direction),
      );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsets.all(8),
      const EdgeInsets.symmetric(horizontal: 4),
      const EdgeInsets.symmetric(horizontal: 4),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );
    return super.defaultStyleOf(context).copyWith(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(scaledPadding),
    );
  }
}

class _TextButtonWithIconChild extends StatelessWidget {
  const _TextButtonWithIconChild({
    Key? key,
    required this.label,
    required this.icon,
    required this.space,
    required this.direction,
  }) : super(key: key);

  final Widget label;
  final Widget icon;
  final double space;
  final TextIconDirection direction;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap = scale <= 1 ?  space : lerpDouble(space, space/2, math.min(scale - 1, 1))!;

    if (direction == TextIconDirection.leftIcon) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[icon, SizedBox(width: gap), Flexible(child: label)],
      );
    } else if (direction == TextIconDirection.rightIcon) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[Flexible(child: label), SizedBox(width: gap), icon],
      );
    } else if (direction == TextIconDirection.topIcon) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[icon, SizedBox(height: gap), Flexible(child: label)],
      );
    } else {
      return Column(
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[Flexible(child: label), SizedBox(height: gap), icon],
      );
    }
  }
}