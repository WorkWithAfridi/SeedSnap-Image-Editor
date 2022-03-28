import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seedsnap_image_editor/constants/dimentions.dart';

import '../constants/textStyle.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  triggerSplashScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    triggerSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        child: Stack(
          children: [
            SizedBox(
              height: getHeight(context),
              width: getWidth(context),
              child: Image.asset(
                'assets/background_image.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: getHeight(context),
              width: getWidth(context),
              color: Colors.black.withOpacity(.85),
            ),
            Container(
              height: getHeight(context),
              width: getWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: getWidth(context) / 2.5,
                    width: getWidth(context) / 2.5,
                    child: Lottie.asset('assets/lottieAnimation.json'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'SeedSnap',
                            style: titleTS,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            'By KYOTO',
                            style: creatorTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
