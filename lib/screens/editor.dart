import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:seedsnap_image_editor/constants/dimentions.dart';
import 'package:seedsnap_image_editor/widgets/edit_image_viewmodel.dart';

import '../functions/requestPermission.dart';
import '../widgets/imageText.dart';

class Editor extends StatefulWidget {
  final String selectedImage;
  const Editor({Key? key, required this.selectedImage}) : super(key: key);

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends EditImageViewModel {
  int currentIndex = 0;

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected for styling'),
      ),
    );
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff18191A),
      appBar: AppBar(
        title: Text('SeedSnap'),
        centerTitle: true,
      ),
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0xff18191A),
              height: 60,
              width: getWidth(context),
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  IconButton(
                    onPressed: () {
                      if (texts.isNotEmpty) {
                        screenshotController
                            .capture()
                            .then((Uint8List? image) async {
                          final time = DateTime.now()
                              .toIso8601String()
                              .replaceAll('.', '-')
                              .replaceAll(':', '-');
                          final name = "screenshot_$time";
                          await requestPermission(Permission.storage);
                          await ImageGallerySaver.saveImage(image!, name: name);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Image saved.'),
                            ),
                          );
                        }).catchError((err) {
                          print(err);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        texts[currentIndex].fontSize =
                            texts[currentIndex].fontSize + 2;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    tooltip: 'Increase font size',
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        texts[currentIndex].fontSize =
                            texts[currentIndex].fontSize - 2;
                      });
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    tooltip: 'Decrease font size',
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        texts[currentIndex].textAlign = TextAlign.left;
                      });
                    },
                    icon: Icon(
                      Icons.format_align_left,
                      color: Colors.white,
                    ),
                    tooltip: 'Align Left',
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        texts[currentIndex].textAlign = TextAlign.center;
                      });
                    },
                    icon: Icon(
                      Icons.format_align_center,
                      color: Colors.white,
                    ),
                    tooltip: 'Align Center',
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        texts[currentIndex].textAlign = TextAlign.right;
                      });
                    },
                    icon: Icon(
                      Icons.format_align_right,
                      color: Colors.white,
                    ),
                    tooltip: 'Align Right',
                  ),
                  IconButton(
                    onPressed: () {
                      if (texts[currentIndex].fontWeight != FontWeight.bold) {
                        setState(() {
                          texts[currentIndex].fontWeight = FontWeight.bold;
                        });
                      } else {
                        setState(() {
                          texts[currentIndex].fontWeight = FontWeight.normal;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.format_bold,
                      color: Colors.white,
                    ),
                    tooltip: 'Bold',
                  ),
                  IconButton(
                    onPressed: () {
                      if (texts[currentIndex].fontStyle == FontStyle.italic) {
                        setState(() {
                          texts[currentIndex].fontStyle = FontStyle.normal;
                        });
                      } else {
                        setState(() {
                          texts[currentIndex].fontStyle = FontStyle.italic;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.format_italic,
                      color: Colors.white,
                    ),
                    tooltip: 'Italic',
                  ),
                  IconButton(
                    onPressed: () {
                      if (texts[currentIndex].text.contains('\n')) {
                        setState(() {
                          texts[currentIndex].text =
                              texts[currentIndex].text.replaceAll('\n', ' ');
                        });
                      } else {
                        setState(() {
                          texts[currentIndex].text =
                              texts[currentIndex].text.replaceAll(' ', '\n');
                        });
                      }
                    },
                    icon: Icon(
                      Icons.space_bar,
                      color: Colors.white,
                    ),
                    tooltip: 'Add New Line',
                  ),
                  Tooltip(
                    message: 'White',
                    child: GestureDetector(
                      onTap: () {
                        changeTextColor(Colors.white);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Tooltip(
                    message: 'Red',
                    child: GestureDetector(
                      onTap: () {
                        changeTextColor(Colors.red);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Tooltip(
                    message: 'Blue',
                    child: GestureDetector(
                      onTap: () {
                        changeTextColor(Colors.blue);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Tooltip(
                    message: 'Pink',
                    child: GestureDetector(
                      onTap: () {
                        changeTextColor(Colors.pink);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.pink,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Tooltip(
                    message: 'Yellow',
                    child: GestureDetector(
                      onTap: () {
                        changeTextColor(Colors.yellow);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Tooltip(
                    message: 'Green',
                    child: GestureDetector(
                      onTap: () {
                        changeTextColor(Colors.green);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Tooltip(
                    message: 'Black',
                    child: GestureDetector(
                      onTap: () {
                        changeTextColor(Colors.black);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            Screenshot(
              controller: screenshotController,
              child: SizedBox(
                height: getHeight(context) * .3,
                child: Stack(
                  children: [
                    selectedImage,
                    for (int i = 0; i < texts.length; i++)
                      Positioned(
                        left: texts[i].left,
                        top: texts[i].top,
                        right: texts[i].right,
                        child: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              texts.removeAt(i);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Text removed!'),
                              ),
                            );
                          },
                          onTap: () => setCurrentIndex(context, i),
                          child: Draggable(
                            feedback: ImageText(textInfo: texts[i]),
                            child: ImageText(textInfo: texts[i]),
                            onDragEnd: (drag) {
                              final renderBox =
                                  context.findRenderObject() as RenderBox;
                              Offset offset =
                                  renderBox.globalToLocal(drag.offset);
                              setState(() {
                                texts[i].top = offset.dy - 135;
                                texts[i].left = offset.dx;
                              });
                            },
                          ),
                        ),
                      ),
                    createdText.text.isNotEmpty
                        ? Positioned(
                            left: 0,
                            bottom: 0,
                            child: Text(
                              createdText.text,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(.3)),
                            ),
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addDialogBox(context),
        tooltip: "Add text in image",
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget get selectedImage => Center(
        child: Image.file(
          File(widget.selectedImage),
          fit: BoxFit.fill,
          width: getWidth(context),
        ),
      );
}
