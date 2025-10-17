import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeywordProvider with ChangeNotifier {
  List<String> _keywords = [];

  KeywordProvider() {
    _loadKeywords();
  }

  // Using a getter with an unmodifiable list to prevent external mutations
  List<String> get keywords => List.unmodifiable(_keywords);

  Future<void> _loadKeywords() async {
    final prefs = await SharedPreferences.getInstance();
    // Assigning a new list from prefs or a default list
    _keywords = prefs.getStringList('keywords') ?? [
      'flutter',
      'dart',
      'provider',
    ];
    notifyListeners();
  }

  Future<void> addKeyword(String keyword) async {
    if (keyword.isNotEmpty && !_keywords.contains(keyword)) {
      // Creating a new list with the added keyword
      _keywords = [..._keywords, keyword];
      await _saveKeywords();
      notifyListeners();
    }
  }

  Future<void> removeKeyword(String keyword) async {
    if (_keywords.contains(keyword)) {
      // Creating a new list excluding the keyword
      _keywords = _keywords.where((k) => k != keyword).toList();
      await _saveKeywords();
      notifyListeners();
    }
  }

  Future<void> _saveKeywords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('keywords', _keywords);
  }
}
