import 'package:flutter/material.dart';
import 'package:notes/addNote.dart';
import 'package:notes/splashScreen.dart';
import 'home.dart';

main() => runApp(Notes());

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        'home': (context) => Home(),
        'splashScreen': (context) => SplashScreen(),
        'addNote': (context) => AddNote(),
      },
    );
  }
}
