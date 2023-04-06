
class IntUtil {
  /// isEmpty
  static int? parse(String? value) {
      return int.tryParse(value ?? '');
  }

  static bool isZero(int? value) {
    return value == null || value == 0;
  }

}