import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/keyword_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _keywordController = TextEditingController();

  void _addKeyword(KeywordProvider provider) {
    final keyword = _keywordController.text.trim();
    if (keyword.isNotEmpty) {
      provider.addKeyword(keyword);
      _keywordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Highlight Keywords',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _keywordController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a keyword',
                    ),
                    onSubmitted: (_) =>
                        _addKeyword(Provider.of<KeywordProvider>(context, listen: false)),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () =>
                      _addKeyword(Provider.of<KeywordProvider>(context, listen: false)),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Consumer<KeywordProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.keywords.length,
                    itemBuilder: (context, index) {
                      final keyword = provider.keywords[index];
                      return ListTile(
                        title: Text(keyword),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => provider.removeKeyword(keyword),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
