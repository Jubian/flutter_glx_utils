import 'package:common_utils/common_utils.dart';

class StringUtil {
  static bool isEmpty(String? value) {
    return value == null || value == '' || value == 'null';
  }

  static bool isNotEmpty(String? value) {
    return value != null && value != '' && value != 'null';
  }

  static String? hiddenPhone(String? phone) {
    if (isEmpty(phone)) {
      return null;
    } else if (!RegexUtil.isMobileSimple(phone!)) {
      return phone;
    }
    return phone.replaceFirst(RegExp(r'\d{4}'), '****', 3);
  }
}