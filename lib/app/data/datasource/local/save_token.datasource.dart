import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenDataSource {
  saveToken(String token);
}

class TokenDataSourceImpl implements TokenDataSource {
  final FlutterSecureStorage secureStorage;
  TokenDataSourceImpl(this.secureStorage);

  @override
  saveToken(String token) {
    secureStorage.write(key: 'token', value: token);
  }
}
