import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/keyword_provider.dart';

class KeywordSettingsScreen extends StatelessWidget {
  const KeywordSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keywordProvider = Provider.of<KeywordProvider>(context);
    final textEditingController = TextEditingController();

    void addKeyword() {
      if (textEditingController.text.isNotEmpty) {
        keywordProvider.addKeyword(textEditingController.text);
        textEditingController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keyword Filtering'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Add a new keyword',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addKeyword,
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<KeywordProvider>(
              builder: (context, keywordProvider, child) {
                return ListView.builder(
                  itemCount: keywordProvider.keywords.length,
                  itemBuilder: (context, index) {
                    final keyword = keywordProvider.keywords[index];
                    return ListTile(
                      title: Text(keyword),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
