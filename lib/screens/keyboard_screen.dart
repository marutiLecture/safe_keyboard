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

  @override
  void initState() {
    super.initState();
    final keyboardProvider = Provider.of<KeyboardProvider>(context, listen: false);
    final keywordProvider = Provider.of<KeywordProvider>(context, listen: false);

    // Set initial keywords
    keyboardProvider.updateKeywords(keywordProvider.keywords);

    // Listen for keyword changes
    keywordProvider.addListener(() {
      keyboardProvider.updateKeywords(keywordProvider.keywords);
    });

    _focusNode.addListener(() {
      setState(() {}); // Re-render to show/hide keyboard
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardProvider = Provider.of<KeyboardProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Safe Keyboard'),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: keyboardProvider.textEditingController,
                focusNode: _focusNode,
                autofocus: true,
                expands: true,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Type here...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          if (_focusNode.hasFocus)
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
