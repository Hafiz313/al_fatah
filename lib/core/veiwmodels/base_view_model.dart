import 'package:flutter/material.dart';
import 'package:inventory_app/utils/app_state.dart';



class BaseViewModel extends ChangeNotifier {
  ViewState _appState = ViewState.kIdle;
  ViewState get state => _appState;

  void setState(ViewState state) {
    _appState = state;
    notifyListeners();
  }
}