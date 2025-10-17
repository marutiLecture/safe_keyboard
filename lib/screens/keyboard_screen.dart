import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/keyboard_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/keyboard_layout.dart';
import '../widgets/emoji_picker.dart';
import 'settings_screen.dart';

class KeyboardScreen extends StatelessWidget {
  const KeyboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardProvider = Provider.of<KeyboardProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Gboard Clone'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Tap here to start typing',
                ),
                readOnly: true,
                showCursor: true,
              ),
            ),
          ),
          Expanded(
            child: Consumer<KeyboardProvider>(
              builder: (context, keyboardProvider, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: keyboardProvider.isEmojiPickerVisible
                      ? EmojiPicker(
                          onEmojiSelected: keyboardProvider.onKeyPress,
                          onBackToKeyboard: keyboardProvider.toggleEmojiPicker,
                        )
                      : const KeyboardLayout(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
