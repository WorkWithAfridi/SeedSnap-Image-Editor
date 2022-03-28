import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:seedsnap_image_editor/constants/colors.dart';
import 'package:seedsnap_image_editor/models/textInfo.dart';

import '../constants/textStyle.dart';
import '../screens/editor.dart';

abstract class EditImageViewModel extends State<Editor> {
  List<TextInfo> texts = [];

  addNewText(BuildContext) {
    setState(() {
      texts.add(
        TextInfo(
            text: addCaptionController.text,
            left: 0.0,
            right: 0.0,
            top: 0.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            textAlign: TextAlign.left),
      );
    });
    Navigator.of(context).pop();
  }

  TextEditingController addCaptionController = TextEditingController();
  TextEditingController createdText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  addDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final inputBorder = OutlineInputBorder(
          borderSide: Divider.createBorderSide(context),
        );
        return AlertDialog(
          backgroundColor: background,
          titleTextStyle: defaultTS,
          title: Text(
            'Add new text',
            style: defaultTS,
          ),
          content: TextField(
            controller: addCaptionController,
            style: defaultTS,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Enter your caption here',
              hintStyle: defaultTS.copyWith(color: primary.withOpacity(.5)),
              border: inputBorder,
              focusedBorder: inputBorder,
              enabledBorder: inputBorder,
              fillColor: Colors.white10,
              filled: true,
              contentPadding: const EdgeInsets.all(8),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text("Back", style: defaultTS),
            ),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: () {
                addNewText(context);
                addCaptionController.text = '';
              },
              child: Text(
                "Add Text",
                style: defaultTS,
              ),
            ),
            Column(
              children: [
                SizedBox(width: 10,),

                SizedBox(height: 45,),
              ],
            ),
          ],
        );
      },
    );
  }
}
