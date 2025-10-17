import 'package:flutter/material.dart';

class HighlightingTextEditingController extends TextEditingController {
  HighlightingTextEditingController({
    List<String>? keywords,
    this.highlightStyle =
        const TextStyle(backgroundColor: Colors.yellow, color: Colors.black),
    String? text,
  })  : _keywords = keywords ?? [],
        super(text: text);

  List<String> _keywords;
  final TextStyle highlightStyle;

  List<String> get keywords => _keywords;
  set keywords(List<String> newKeywords) {
    if (_keywords.join(',') == newKeywords.join(',')) return;
    _keywords = newKeywords;
    notifyListeners();
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<TextSpan> children = [];
    final String text = this.text;
    final defaultStyle =
        style ?? const TextStyle(color: Colors.black, fontSize: 18.0);

    if (_keywords.isEmpty || text.isEmpty) {
      return TextSpan(text: text, style: defaultStyle);
    }

    final String pattern =
        "(${_keywords.where((k) => k.isNotEmpty).map(RegExp.escape).join('|')})";
    final RegExp regex = RegExp(pattern, caseSensitive: false);

    int lastMatchEnd = 0;

    for (final Match match in regex.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        children.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
        ));
      }
      children.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: defaultStyle.merge(highlightStyle),
      ));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      children.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return TextSpan(style: defaultStyle, children: children);
  }
}
