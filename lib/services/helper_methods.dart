

import 'package:flutter/material.dart';

class HelperMethods{


  ThemeMode _currentTheme = ThemeMode.system;

  get currentTheme => _currentTheme;


  void changeTheme(){
    if(_currentTheme == ThemeMode.light)
      {
        _currentTheme = ThemeMode.dark;
      }
    else{
      _currentTheme = ThemeMode.light;
    }
    debugPrint("Theme is $_currentTheme");
  }


}