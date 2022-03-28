import 'package:flutter/cupertino.dart';

class TextInfo {
  String text;
  double left;
  double right;
  double top;
  Color color;
  FontWeight fontWeight;
  FontStyle fontStyle;
  double fontSize;
  TextAlign textAlign;

  TextInfo({
    required this.text,
    required this.left,
    required this.right,
    required this.top,
    required this.color,
    required this.fontWeight,
    required this.fontStyle,
    required this.fontSize,
    required this.textAlign,
  });
}
