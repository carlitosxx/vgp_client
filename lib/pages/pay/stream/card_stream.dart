import 'dart:async';

class CardStream {
  final _numberCardController = StreamController<String>();
  final _expiryDateController = StreamController<String>();
  final _nameController = StreamController<String>();
  final _cvvController = StreamController<String>();

  Stream<String> get numberCardStream => _numberCardController.stream;
  Stream<String> get expiryDateStream => _expiryDateController.stream;
  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get cvvStream => _cvvController.stream;

  updateNumberCard(String text) {
    _numberCardController.sink.add(text);
  }

  updateExpiryDate(String text) {
    _expiryDateController.sink.add(text);
  }

  updateCVV(String text) {
    _cvvController.sink.add(text);
  }

  updateName(String text) {
    _nameController.sink.add(text);
  }

  dispose() {
    _nameController.close();
    _expiryDateController.close();
    _numberCardController.close();
  }
}
