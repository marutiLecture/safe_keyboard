import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/keyboard_provider.dart';
import 'key_button.dart';

class KeyboardLayout extends StatelessWidget {
  const KeyboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardProvider = Provider.of<KeyboardProvider>(context);

    return Container(
      color: Colors.grey[200],
      child: keyboardProvider.isNumeric
          ? _buildNumericKeyboard(keyboardProvider)
          : _buildAlphabeticalKeyboard(keyboardProvider),
    );
  }

  Widget _buildAlphabeticalKeyboard(KeyboardProvider keyboardProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRow(
            keyboardProvider,
            keyboardProvider.isShiftEnabled
                ? 'QWERTYUIOP'
                : 'qwertyuiop'),
        _buildRow(
            keyboardProvider,
            keyboardProvider.isShiftEnabled
                ? 'ASDFGHJKL'
                : 'asdfghjkl'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KeyButton(
              icon: Icons.arrow_upward,
              onPressed: keyboardProvider.toggleShift,
              isSpecial: true,
            ),
            ..._generateButtons(
                keyboardProvider,
                keyboardProvider.isShiftEnabled
                    ? 'ZXCVBNM'
                    : 'zxcvbnm'),
            KeyButton(
              icon: Icons.backspace,
              onPressed: keyboardProvider.onDeletePress,
              isSpecial: true,
            ),
          ],
        ),
        _buildSpecialKeys(keyboardProvider),
      ],
    );
  }

  Widget _buildNumericKeyboard(KeyboardProvider keyboardProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRow(keyboardProvider, '1234567890'),
        _buildRow(keyboardProvider, '@#\$%^&*()_+'),
        _buildRow(keyboardProvider, '-=\\/|<>[]{}'),
        _buildSpecialKeys(keyboardProvider),
      ],
    );
  }

  List<Widget> _generateButtons(
      KeyboardProvider keyboardProvider, String keys) {
    String? fontFamily;
    switch (keyboardProvider.currentLanguage) {
      case 'Tamil':
        fontFamily = 'Noto Sans Tamil';
        break;
      case 'Hindi':
        fontFamily = 'Noto Sans Devanagari';
        break;
      default:
        fontFamily = 'Noto Sans';
    }

    return keys.split('').map((key) {
      return KeyButton(
        text: key,
        onPressed: () => keyboardProvider.onKeyPress(key),
        fontFamily: fontFamily,
      );
    }).toList();
  }

  Widget _buildRow(KeyboardProvider keyboardProvider, String keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _generateButtons(keyboardProvider, keys),
    );
  }

  Widget _buildSpecialKeys(KeyboardProvider keyboardProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        KeyButton(
          text: keyboardProvider.isNumeric ? 'ABC' : '123',
          onPressed: keyboardProvider.toggleNumeric,
          isSpecial: true,
        ),
        KeyButton(
          text: keyboardProvider.currentLanguage,
          onPressed: keyboardProvider.showLanguageMenu,
          isSpecial: true,
        ),
        KeyButton(
          text: 'SPACE',
          onPressed: () => keyboardProvider.onKeyPress(' '),
          isSpecial: true,
          flex: 2,
        ),
        KeyButton(
          text: 'Emoji',
          onPressed: keyboardProvider.toggleEmojiPicker,
          isSpecial: true,
        ),
      ],
    );
  }
}
