import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/keyboard_provider.dart';
import '../providers/keyword_provider.dart';
import '../widgets/keyboard_layout.dart';
import '../widgets/emoji_picker.dart';
import 'settings_screen.dart';

class KeyboardScreen extends StatefulWidget {
  const KeyboardScreen({super.key});

  @override
  _KeyboardScreenState createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  final FocusNode _focusNode = FocusNode();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    final keyboardProvider = Provider.of<KeyboardProvider>(context, listen: false);
    final keywordProvider = Provider.of<KeywordProvider>(context, listen: false);
    keyboardProvider.textEditingController.addListener(() {
      keyboardProvider.updateHighlightedText(keywordProvider.keywords);
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isKeyboardVisible = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardProvider = Provider.of<KeyboardProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Gboard Clone'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(_focusNode);
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: RichText(
                  text: keyboardProvider.highlightedText,
                ),
              ),
            ),
          ),
          const Spacer(),
          if (_isKeyboardVisible)
            Consumer<KeyboardProvider>(
              builder: (context, keyboardProvider, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: keyboardProvider.isEmojiPickerVisible ? 300 : 250,
                  child: keyboardProvider.isEmojiPickerVisible
                      ? EmojiPicker(
                          onEmojiSelected: keyboardProvider.onKeyPress,
                          onBackToKeyboard: keyboardProvider.toggleEmojiPicker,
                        )
                      : const KeyboardLayout(),
                );
              },
            ),
        ],
      ),
    );
  }
}
