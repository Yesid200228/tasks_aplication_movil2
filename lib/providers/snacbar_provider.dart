
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SnacBarProvider extends ChangeNotifier {
  int _mensajeCode = 0;
  String _message = '';

  int get selectedStatusCode {
    return _mensajeCode;
  }

  String get selectedMessage {
    return _message;
  }
  set selectedMessage( String message ){

    _message = message;

    notifyListeners();
  }

  set selectedStatusCode( int i ){

    _mensajeCode = i;

    notifyListeners();
  }
}