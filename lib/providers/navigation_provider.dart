import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _navIndex = 0;
  Color _color1 = Color(0xffebeafd);
  Color _color2 = Colors.transparent;
  Color _color3 = Colors.transparent;
  Color _color4 = Colors.transparent;
  Color _text1 = Colors.black;
  Color _text2 = Color(0xffebeafd);
  Color _text3 = Color(0xffebeafd);
  Color _text4 = Color(0xffebeafd);
  String _appBarTitle = 'Home';

//Getters
  int get navIndex => _navIndex;
  Color get color1 => _color1;
  Color get color2 => _color2;
  Color get color3 => _color3;
  Color get color4 => _color4;
  Color get text1 => _text1;
  Color get text2 => _text2;
  Color get text3 => _text3;
  Color get text4 => _text4;
  String get appBarTitle => _appBarTitle;

  void option1() {
    _navIndex = 0;
    _color1 = Color(0xffebeafd);
    _color2 = _color3 = _color4 = Colors.transparent;
    _text1 = Color(0xff44337b);
    _text2 = _text3 = _text4 = Color(0xffebeafd);
    _appBarTitle = 'Home';
    notifyListeners();
  }

  void option2() {
    _navIndex = 1;
    _color2 = Color(0xffebeafd);
    _color1 = _color3 = _color4 = Colors.transparent;
    _text2 = Color(0xff44337b);
    _text1 = _text3 = _text4 = Color(0xffebeafd);
    _appBarTitle = 'Explore';
    notifyListeners();
  }

  void option3() {
    _navIndex = 2;
    _color3 = Color(0xffebeafd);
    _color1 = _color2 = _color4 = Colors.transparent;
    _text3 = Color(0xff44337b);
    _text2 = _text1 = _text4 = Color(0xffebeafd);
    _appBarTitle = 'Upload';
    notifyListeners();
  }

  void option4() {
    _navIndex = 3;
    _color4 = Color(0xffebeafd);
    _color1 = _color2 = _color3 = Colors.transparent;
    _text4 = Color(0xff44337b);
    _text2 = _text3 = _text1 = Color(0xffebeafd);
    _appBarTitle = 'Profile';
    notifyListeners();
  }
}