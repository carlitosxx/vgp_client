// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
String changeFormatDate(String date){
  DateTime newDateTime = DateTime.parse(date);
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(newDateTime);
  return formatted;
}