import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedItems extends StatelessWidget {
  final List divided;

  SavedItems({this.divided});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.white,
            ),
            onPressed: () {
              _back(context);
            }),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.blueGrey.shade900,
        backgroundColor: Colors.blueGrey.shade800,
        title: Text(
          'Saved Suggestions',
          style: GoogleFonts.sail(
            fontSize: 25,
            // decoration: TextDecoration.underline,
            // decorationStyle: TextDecorationStyle.dashed),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: divided,
      ),
    );
  }

  void _back(BuildContext context) {
    /* Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return MyApp();
      }),
    );*/

    Navigator.pop(context, true);
  }
}
