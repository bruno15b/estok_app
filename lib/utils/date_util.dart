import 'package:estok_app/app/shared/constants.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static DateTime formatStringToDate(String dateString) {
    return DateFormat(Constants.DATE_FORMAT_STRING).parse(dateString);
  }

  static String formatDateToString(DateTime date) {
    return DateFormat(Constants.DATE_FORMAT_STRING).format(date);
  }
}