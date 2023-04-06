import 'package:flutter/material.dart';

extension WidgetChantExtList<T> on List<T> {
  List<E> buildAll<E>(E Function(T) builder) {
    return map<E>((item) {
      return builder(item);
    }).toList();
  }

  List<Widget> buildAllAsWidget(Widget Function(T) builder) {
    return map<Widget>((item) {
      return builder(item);
    }).toList();
  }
}
