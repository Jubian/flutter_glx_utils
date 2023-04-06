

class DoubleUtil {
  /// isEmpty
  static double? parse(String? value) {
      return double.tryParse(value ?? '');
  }

  static bool isZero(double? value) {
    return value == null || value == 0;
  }

  static bool isNotZero(double? value) {
    return value != null && value != 0;
  }

  static String toNotNullString(double? value) {
    return value == null ? '' : value.toString();
  }

  static double? getDoubleValue(String text) {
    String cleanText = text.replaceAll(RegExp(r'[^\d\.]'), '');
    try {
      return double.parse(cleanText);
    } catch (e) {
      return 0;
    }
  }

}