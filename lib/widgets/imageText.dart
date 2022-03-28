import 'package:flutter/material.dart';
import 'package:seedsnap_image_editor/models/textInfo.dart';

import '../constants/textStyle.dart';

class ImageText extends StatelessWidget {
  final TextInfo textInfo;
  const ImageText({Key? key, required this.textInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      textAlign: textInfo.textAlign,
      style: defaultTS.copyWith(
        fontSize: textInfo.fontSize,
        fontWeight: textInfo.fontWeight,
        fontStyle: textInfo.fontStyle,
        color: textInfo.color,
      ),
    );
  }
}
