import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KeyButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final bool isSpecial;
  final int flex;
  final IconData? icon;
  final String? fontFamily;

  const KeyButton({
    super.key,
    this.text,
    required this.onPressed,
    this.isSpecial = false,
    this.flex = 1,
    this.icon,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (icon != null) {
      child = Icon(icon, size: 24);
    } else {
      child = Text(
        text ?? '',
        style: GoogleFonts.getFont(
          fontFamily ?? 'Noto Sans',
          fontSize: 18,
        ),
      );
    }

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            backgroundColor: isSpecial ? Colors.grey[400] : Colors.grey[300],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
