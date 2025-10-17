import 'package:flutter/material.dart';
import '../controllers/highlighting_text_editing_controller.dart';

class KeyboardProvider with ChangeNotifier {
  final HighlightingTextEditingController _textEditingController =
      HighlightingTextEditingController();
  HighlightingTextEditingController get textEditingController =>
      _textEditingController;

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
    final selection = _textEditingController.selection;
    final newText = text.replaceRange(selection.start, selection.end, key);
    _textEditingController.value = _textEditingController.value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: selection.start + key.length),
      composing: TextRange.empty,
    );
  }

  void onDeletePress() {
    final selection = _textEditingController.selection;
    final text = _textEditingController.text;

    if (selection.isCollapsed) {
      if (selection.start == 0) return;
      final newText =
          text.substring(0, selection.start - 1) + text.substring(selection.start);
      _textEditingController.value = _textEditingController.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start - 1),
        composing: TextRange.empty,
      );
    } else {
      final newText = text.replaceRange(selection.start, selection.end, '');
      _textEditingController.value = _textEditingController.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start),
        composing: TextRange.empty,
      );
    }
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

  void showLanguageMenu() {}

  void setLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }

  void updateKeywords(List<String> keywords) {
    _textEditingController.keywords = keywords;
  }
}
