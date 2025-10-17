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
    // No need to call notifyListeners() here, the listener on the controller will do the work.
  }

  void onDeletePress() {
    final text = _textEditingController.text;
    final selection = _textEditingController.selection;

    if (selection.isCollapsed) {
      // No selection, delete character before cursor
      if (selection.start > 0) {
        final newText =
            text.substring(0, selection.start - 1) + text.substring(selection.start);
        _textEditingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: selection.start - 1),
        );
      }
    } else {
      // Selection, delete selected text
      final newText = text.replaceRange(selection.start, selection.end, '');
      _textEditingController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start),
      );
    }
  }

  void updateHighlightedText(List<String> keywords) {
    final String text = _textEditingController.text;
    const defaultStyle = TextStyle(color: Colors.black, fontSize: 18.0);

    if (keywords.isEmpty || text.isEmpty) {
      _highlightedText = TextSpan(text: text, style: defaultStyle);
      notifyListeners();
      return;
    }

    final List<TextSpan> spans = [];
    final String pattern = "(${keywords.where((k) => k.isNotEmpty).map(RegExp.escape).join('|')})";
    final RegExp regex = RegExp(pattern, caseSensitive: false);

    final List<Match> matches = regex.allMatches(text).toList();

    if (matches.isEmpty) {
      _highlightedText = TextSpan(text: text, style: defaultStyle);
      notifyListeners();
      return;
    }
    
    int lastMatchEnd = 0;
    for (final Match match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
            text: text.substring(lastMatchEnd, match.start), style: defaultStyle));
      }
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: defaultStyle.copyWith(backgroundColor: Colors.yellow),
      ));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd), style: defaultStyle));
    }

    _highlightedText = TextSpan(children: spans);
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
