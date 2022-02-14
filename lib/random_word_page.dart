import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWordPage extends StatefulWidget {
  const RandomWordPage({Key? key}) : super(key: key);

  @override
  State<RandomWordPage> createState() => _RandomWordPageState();
}

class _RandomWordPageState extends State<RandomWordPage> {
  String titleName = "Startup Name Generator";
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _buildSugesstion(),
    );
  }

  AppBar appBar() => AppBar(
        title: Text(titleName),
        actions: [
          IconButton(
            onPressed: () {
              _pushSaved();
            },
            icon: const Icon(Icons.list),
            tooltip: "Saved Suggestions",
          ),
        ],
      );

  _buildSugesstion() {
    return ListView.builder(
      itemBuilder: (context, a) {
        if (a.isOdd) {
          return const Divider(
            height: 1,
          );
        }
        final index = a ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRowListTile(_suggestions[index]);
      },
    );
  }

  _buildRowListTile(WordPair suggestion) {
    var alreadySaved = _saved.contains(suggestion);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Colors.grey.shade200,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: titleSuggestion(suggestion),
          trailing: iconSuggestion(alreadySaved),
          onTap: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(suggestion);
              } else {
                _saved.add(suggestion);
              }
            });
          },
        ),
      ),
    );
  }

  Icon iconSuggestion(bool alreadySaved) {
    return Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
      semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
    );
  }

  Text titleSuggestion(WordPair suggestion) {
    return Text(
      suggestion.asPascalCase,
      style: _biggerFont,
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
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
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
