import 'package:flutter/material.dart';
import 'package:seedsnap_image_editor/screens/home.dart';

void main(){
  runApp(SeedSnap());
}

class SeedSnap extends StatelessWidget {
  const SeedSnap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Home(),
    );
  }
}


// Done till 1:04:00
// video link https://www.youtube.com/watch?v=vzg6iNziiKw