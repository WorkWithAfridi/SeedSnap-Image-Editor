import 'package:flutter/material.dart';
import 'package:seedsnap_image_editor/screens/SplashScreen.dart';
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
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.pink,
        primaryColorLight: Colors.pink
      ),
      home: SplashScreen(),
    );
  }
}

//play heat waves