import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
                        GestureDetector(
                          onTap: () async {
                            XFile? xfile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (xfile != null) {
                              File? croppedImage =
                                  await ImageCropper().cropImage(
                                sourcePath: xfile.path,
                                aspectRatio:
                                    CropAspectRatio(ratioX: 1, ratioY: 1),
                                aspectRatioPresets: [
                                  CropAspectRatioPreset.square
                                ],
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Editor(selectedImage: xfile.path),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Start editing",
                            style: titleTS,
                          ),
                        )
                      ],
                    ),
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
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
