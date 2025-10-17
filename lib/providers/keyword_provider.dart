import 'package:flutter/material.dart';

class KeywordProvider with ChangeNotifier {
  final List<String> _keywords = ['hello', 'world'];
  List<String> get keywords => _keywords;

  void addKeyword(String keyword) {
    _keywords.add(keyword);
    notifyListeners();
  }
}
