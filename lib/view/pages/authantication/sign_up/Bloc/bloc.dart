import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisibleBloc extends Cubit<PasswordVisible> {
  VisibleBloc()
      : super(PasswordVisible(isVisible: false, isObsecureText: true));

  void update(bool iconVisible, bool isecureText) {
    emit(PasswordVisible(isVisible: iconVisible, isObsecureText: isecureText));
  }
}

class PasswordVisible {
  bool isVisible = false;
  bool isObsecureText = true;
  PasswordVisible({required this.isVisible, required this.isObsecureText});
}
