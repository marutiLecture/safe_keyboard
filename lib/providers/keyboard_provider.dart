import 'package:flutter/material.dart';

class KeyboardProvider with ChangeNotifier {
  final TextEditingController _textEditingController = TextEditingController();
  TextEditingController get textEditingController => _textEditingController;

  TextSpan _highlightedText = const TextSpan();
  TextSpan get highlightedText => _highlightedText;

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

  void updateHighlightedText(List<String> keywords) {
    final text = _textEditingController.text;
    final List<TextSpan> textSpans = [];

    final lowerCaseText = text.toLowerCase();
    int lastMatchEnd = 0;

    for (final keyword in keywords) {
      if (keyword.isEmpty) continue;
      final lowerCaseKeyword = keyword.toLowerCase();
      int startIndex = lowerCaseText.indexOf(lowerCaseKeyword, lastMatchEnd);
      while (startIndex != -1) {
        if (startIndex > lastMatchEnd) {
          textSpans.add(TextSpan(text: text.substring(lastMatchEnd, startIndex)));
        }
        final endIndex = startIndex + keyword.length;
        textSpans.add(
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: const TextStyle(backgroundColor: Colors.yellow),
          ),
        );
        lastMatchEnd = endIndex;
        startIndex = lowerCaseText.indexOf(lowerCaseKeyword, lastMatchEnd);
      }
    }

    if (lastMatchEnd < text.length) {
      textSpans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    _highlightedText = TextSpan(children: textSpans);
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
