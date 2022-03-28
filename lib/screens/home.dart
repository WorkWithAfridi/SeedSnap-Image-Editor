import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:seedsnap_image_editor/constants/colors.dart';
import 'package:seedsnap_image_editor/constants/dimentions.dart';
import 'package:seedsnap_image_editor/constants/textStyle.dart';
import 'package:seedsnap_image_editor/screens/editor.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Container(
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
              width: getWidth(context),
              height: getHeight(context),
              child: Column(
                children: [
                  // AppBar(
                  //   title: Text(
                  //     'SeedSnap',
                  //     style: titleTS,
                  //   ),
                  //   centerTitle: true,
                  //   backgroundColor: Colors.transparent,
                  //   elevation: 0,
                  // ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            XFile? xfile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (xfile != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Editor(selectedImage: xfile.path),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Add Image",
                            style: titleTS,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}