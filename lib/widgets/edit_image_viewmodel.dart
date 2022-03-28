import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:seedsnap_image_editor/models/textInfo.dart';

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
        return AlertDialog(
          title: Text('Add new text'),
          content: TextField(
            controller: addCaptionController,
            maxLines: 5,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.edit),
              filled: true,
              hintText: 'Enter you caption here...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Back"),
            ),
            TextButton(
              onPressed: () => addNewText(context),
              child: Text("Add Text"),
            ),
          ],
        );
      },
    );
  }
}
