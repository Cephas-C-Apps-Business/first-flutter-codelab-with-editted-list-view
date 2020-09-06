import 'package:english_words/english_words.dart';
import 'package:first_flutter_codelab/saved_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      /*   darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),*/
      home: Banner(
        location: BannerLocation.bottomEnd,
        color: Colors.indigo[900],
        message: "© Cephas",
        textStyle: GoogleFonts.montserrat(
          fontSize: 13,
          color: Colors.yellow[900],
          fontWeight: FontWeight.bold,
        ),
        child: Scrollbar(child: RandomWords()), // With this text.
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // The itemBuilder callback is called once per suggested
        // word pairing, and places each suggestion into a ListTile
        // row. For even rows, the function adds a ListTile row for
        // the word pairing. For odd rows, the function adds a
        // Divider widget to visually separate the entries. Note that
        // the divider may be difficult to see on smaller devices.
        itemBuilder: (BuildContext _context, int i) {
          // Add a one-pixel-high divider widget before each row
          // in the ListView.

          /*
          //this inserts a divider after every tile
          //we use final int index = i ~/ 2; not final int index = i ~/ 1; for this implementation
          if (i.isOdd) {
            return Divider(
              color: Colors.grey.shade700,
            );
          }*/

          //this implemenation below inserts a text widget after every 5 elements(in the 6th position) in the list view
          //we shall use this implementation for displaying Ads in our Apps
          //wen using it, this final int index = i ~/ 2; changes to
          //final int index = i ~/ 1;
          if (i % 6 == 0) {
            return Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.indigoAccent[700],
                      thickness: 1.5,
                      indent: 8,
                      endIndent: 8,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Cephas --',
                          style: TextStyle(
                            color: Colors.indigoAccent[700],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '\tBrian',
                          style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 18,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.red.shade900,
                      thickness: 1.5,
                      indent: 8,
                      endIndent: 8,
                    ),
                  ),
                ],
              ),
              /* child: Text(
                'Tap the heart icon to Select a Name',
                style: TextStyle(color: Colors.indigo[900]),
              ),*/
            );
          }

          // The syntax "i ~/ 2" divides i by 2 and returns an
          // integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings
          // in the ListView,minus the divider widgets.
          // this is used wen inserting dividers
          // final int index = i ~/ 2;

          //this is for inserting the text widget or Ad
          final int index = i ~/ 1;
          // If you've reached the end of the available word
          // pairings...
          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the
            // suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    return ListTile(
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red[900] : Colors.red[900],
      ),
      onTap: () {
        // NEW lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
      title: Text(
        pair.asPascalCase,
        style: GoogleFonts.montserrat(
          fontSize: 15,
          color: Colors.blueGrey.shade900,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add from here...
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.blueGrey.shade900,
        actions: [
          IconButton(
            icon: Icon(
              Icons.list,
              color: Colors.white,
            ),
            // onPressed: () => _pushSaved(),
            onPressed: () => Navigator.of(context).push(
              _pushCustom(),
            ),
          )
        ],
        title: Text(
          'Cephas Startup Names',
          style: GoogleFonts.sail(
            fontSize: 25,
            // decoration: TextDecoration.underline,
            // decorationStyle: TextDecorationStyle.dashed),
          ),
        ),
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    //this is an example of navigation using material page route
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here.../
        builder: (BuildContext context) {
          List<Widget> divided = buildMyTile(context);

          return SavedItems(divided: divided);
        },
      ),
    );
  }

  Route _pushCustom() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        List<Widget> divided = buildMyTile(context);

        return SavedItems(divided: divided);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  List<Widget> buildMyTile(BuildContext context) {
    bool icon;
    final tiles = _saved.map(
      (WordPair pair) {
        print('rebuilding');
        return ListTile(
          trailing: Icon(
            Icons.favorite_border,
            color: Colors.red[600],
          ),
          /*trailing: IconButton(
              icon: icon == true
                  ? Icon(
                      Icons.remove_circle_outline,
                      color: Colors.blueGrey[600],
                    )
                  : Icon(
                      Icons.favorite_border,
                      color: Colors.blueGrey[600],
                    ),
              onPressed: () {
                setState(() {
                  icon = false;
                  buildMyTile(context);
                });
                //

                // _saved.remove(pair);
                // _pushSaved(); this changes stuff but builds widget again
                // buildMyTile(context);
              }),*/
          title: Text(
            pair.asPascalCase,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              color: Colors.blueGrey.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
      color: Colors.grey.shade700,
    ).toList();
    return divided;
  }
}
