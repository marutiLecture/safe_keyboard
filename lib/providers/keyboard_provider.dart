import 'package:flutter/material.dart';

class KeyboardProvider with ChangeNotifier {
  final TextEditingController _textEditingController = TextEditingController();
  TextEditingController get textEditingController => _textEditingController;

  bool _isShiftEnabled = false;
  bool get isShiftEnabled => _isShiftEnabled;

  bool _isEmojiPickerVisible = false;
  bool get isEmojiPickerVisible => _isEmojiPickerVisible;

  bool _isNumeric = false;
  bool get isNumeric => _isNumeric;

  String _currentLanguage = 'EN';
  String get currentLanguage => _currentLanguage;

  void onKeyPress(String key) {
    final text = _textEditingController.text;
    final textSelection = _textEditingController.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      key,
    );
    final myTextLength = key.length;
    _textEditingController.text = newText;
    _textEditingController.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
    notifyListeners();
  }

  void onDeletePress() {
    final text = _textEditingController.text;
    final textSelection = _textEditingController.selection;
    if (textSelection.start == 0 && textSelection.end == 0) return;

    final newText = text.replaceRange(
      textSelection.start - 1,
      textSelection.end,
      '',
    );
    _textEditingController.text = newText;
    _textEditingController.selection = textSelection.copyWith(
      baseOffset: textSelection.start - 1,
      extentOffset: textSelection.start - 1,
    );
    notifyListeners();
  }

  void toggleShift() {
    _isShiftEnabled = !_isShiftEnabled;
    notifyListeners();
  }

  void toggleEmojiPicker() {
    _isEmojiPickerVisible = !_isEmojiPickerVisible;
    notifyListeners();
  }

  void toggleNumeric() {
    _isNumeric = !_isNumeric;
    notifyListeners();
  }

  void showLanguageMenu() {
    // This will be implemented later
  }

  void setLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }
}
