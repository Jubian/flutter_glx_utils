import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // 获得当前文本选择的起始和结束位置
    // final int selectionStartIndex = newValue.selection.start;
    // final int selectionEndIndex = newValue.selection.end;

    // 如果新输入的字符是数字，将其追加到已有文本末尾
    if (newValue.text.codeUnitAt(newValue.text.length - 1) >= 48 &&
        newValue.text.codeUnitAt(newValue.text.length - 1) <= 57) {
      String newString = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
      double value = double.parse(newString);
      String formattedString = NumberFormat.currency(
        symbol: '',
        decimalDigits: 0,
      ).format(value);

      TextSelection newSelection = TextSelection(
        baseOffset: formattedString.length,
        extentOffset: formattedString.length,
        affinity: newValue.selection.affinity,
        isDirectional: newValue.selection.isDirectional,
      );
      return TextEditingValue(
        text: formattedString,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }

    // 如果新输入的字符是退格键，将已有文本的最后一个字符删除
    else if (newValue.text == '' && oldValue.text.isNotEmpty) {
      String newString = oldValue.text.substring(0, oldValue.text.length - 1);
      double value = double.parse(newString) / 100;
      String formattedString = NumberFormat.currency(
        symbol: '',
        decimalDigits: 0,
      ).format(value);

      TextSelection newSelection = TextSelection(
        baseOffset: formattedString.length,
        extentOffset: formattedString.length,
        affinity: newValue.selection.affinity,
        isDirectional: newValue.selection.isDirectional,
      );
      return TextEditingValue(
        text: formattedString,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }

    // 如果新输入的字符是其他非数字字符，忽略它
    else {
      return oldValue;
    }
  }
}

