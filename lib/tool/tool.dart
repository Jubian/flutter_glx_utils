
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ToolsUtils {

  MaterialColor createMaterialColor(Color color) {
    List<double> strengths = [.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  Map<String, dynamic> genNotNullMap({List<String>? keys, List<dynamic>? values}) {
    assert(keys != null && values != null && keys.length == values.length, '参数不匹配');
    Map<String, dynamic> map = {};
    keys!.forEachIndexed((index, element) {
      map[element] = values![index];
    });
    return map;
  }
  
}
