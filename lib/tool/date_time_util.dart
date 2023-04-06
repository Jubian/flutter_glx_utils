
import 'package:common_utils/common_utils.dart';

class DateTimeUtil {
  
  static String formatDate(DateTime? dateTime, {String? format}) {
    return DateUtil.formatDate(dateTime?.toLocal(),format: format);
  }

  static DateTime? getDateTime(String dateStr, {bool isUtc = false}) {
    return DateUtil.getDateTime(dateStr,isUtc: isUtc);
  }
}