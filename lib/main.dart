import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/keyboard_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/keyword_provider.dart';
import 'screens/keyboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KeyboardProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => KeywordProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flutter Gboard Clone',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.themeMode,
            home: const KeyboardScreen(),
          );
        },
      ),
    );
  }
}
