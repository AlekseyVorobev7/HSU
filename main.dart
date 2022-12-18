// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart'; // импорты
import 'package:english_words/english_words.dart';

void main() => runApp(const Myapp()); // запуск приложения

class Myapp extends StatelessWidget {
  // описание главного экрана
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hi!!!',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(249, 255, 255, 255),
          foregroundColor: Colors.black,
        ),
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  // опимания объета рандом вордс
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() {
    return _RandomWordsState();
  }
}

class _RandomWordsState extends State<RandomWords> {
  //логика рандом вордс
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) {
        final tiles = _saved.map(
          (pair) {
            return ListTile(
              title: Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final divided = tiles.isNotEmpty
            ? ListTile.divideTiles(context: context, tiles: tiles).toList()
            : <Widget>[];

        return Scaffold(
          appBar: AppBar(
            title: const Text("Saved Suggestions"),
          ),
          body: ListView(
            children: divided,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Startup Name Generator"),
        actions: [
          IconButton(
              onPressed: _pushSaved,
              icon: const Icon(Icons.list),
              tooltip: "Saved suggestions"),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          var alredy_save = _saved.contains(_suggestions[index]);

          return ListTile(
            title: Text(_suggestions[index].asPascalCase, style: _biggerFont),
            trailing: Icon(
              alredy_save ? Icons.favorite : Icons.favorite_border,
              color: alredy_save ? Colors.red : null,
              semanticLabel: alredy_save ? 'Remove from saved' : 'Add to saved',
            ),
            onTap: () {
              setState(() {
                if (alredy_save) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });
            },
          );
        },
      ),
    );
  }
}
