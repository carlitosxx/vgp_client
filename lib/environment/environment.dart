import 'dart:io';

class Environment {
  // static String apiUrl = Platform.isAndroid ? 'http://192.168.0.2:5000':'http://192.168.0.2:5000';
  static String apiUrl = Platform.isAndroid
      ? 'http://201.240.104.66:3000/api/'
      : 'http://201.240.104.66:3000/api/';
  // static String socketUrl = Platform.isAndroid ? 'http://192.168.0.6:3000':'http://192.168.0.6:3000';
}
