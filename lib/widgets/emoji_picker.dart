import 'package:flutter/material.dart';

import 'key_button.dart';

class EmojiPicker extends StatelessWidget {
  final void Function(String) onEmojiSelected;
  final VoidCallback onBackToKeyboard;

  const EmojiPicker({
    super.key,
    required this.onEmojiSelected,
    required this.onBackToKeyboard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 8,
              children: [
                _buildEmoji('😀'),
                _buildEmoji('😃'),
                _buildEmoji('😄'),
                _buildEmoji('😁'),
                _buildEmoji('😆'),
                _buildEmoji('😅'),
                _buildEmoji('😂'),
                _buildEmoji('🤣'),
                _buildEmoji('😊'),
                _buildEmoji('😇'),
                _buildEmoji('😉'),
                _buildEmoji('😍'),
                _buildEmoji('🥰'),
                _buildEmoji('😘'),
                _buildEmoji('😗'),
                _buildEmoji('😙'),
              ],
            ),
          ),
          Row(
            children: [
              KeyButton(text: 'ABC', onPressed: onBackToKeyboard),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEmoji(String emoji) {
    return TextButton(
      onPressed: () => onEmojiSelected(emoji),
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
