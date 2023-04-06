
import 'package:flutter/material.dart';

class _AttributeTextItem {
  
  final String text;
  final TextStyle? style;

  _AttributeTextItem(this.text, this.style);
}

class AttributeText extends StatelessWidget {
  AttributeText({
    required this.text,
    required this.attributeTexts,
    this.textStyle,
    this.attributeStyle,
    this.textAlign = TextAlign.start,
    this.refFirst = false,
    this.textScaleFactor
  }) {
    _sortText();
  }

  final String text;
  final List<String> attributeTexts;
  final TextStyle? textStyle;
  final TextStyle? attributeStyle;
  final TextAlign textAlign;
  final bool refFirst;
  final double? textScaleFactor;

  final List<_AttributeTextItem> _textList = [];

  _sortText() {
    attributeTexts.sort((a,b) {
      final aIndex = text.indexOf(a);
      final bIndex = text.indexOf(b);
      return aIndex.compareTo(bIndex);
    });

    var i = 0;
    var tmpText = text;
    while (i != attributeTexts.length) {
      var attText = attributeTexts[i];
      var tmpList = tmpText.split(attText);
      i++;
      if (tmpList.length < 2) continue;
      _textList.add(_AttributeTextItem(tmpList.first, textStyle));
      _textList.add(_AttributeTextItem(attText, attributeStyle));
      if (tmpList.length == 2) {
        tmpText = tmpList.last;
      } else {
        tmpText = tmpText.substring(tmpList.first.length + attText.length,tmpText.length);
      }
    }
    _textList.add(_AttributeTextItem(tmpText, textStyle));
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textScaleFactor: textScaleFactor ?? MediaQuery.of(context).textScaleFactor,
      textAlign: textAlign,
      text: TextSpan(
        children: _textList.map((e) => 
          TextSpan(
            text: e.text,
            style: e.style
          )
        ).toList()
      )
    );
  }
  
}