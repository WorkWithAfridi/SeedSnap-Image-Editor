import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:seedsnap_image_editor/constants/colors.dart';
import 'package:seedsnap_image_editor/constants/dimentions.dart';
import 'package:seedsnap_image_editor/constants/textStyle.dart';
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

  Color filterColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
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
                children: [
                  AppBar(
                    title: Text(
                      'SeedSnap',
                      style: titleTS,
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              'Text Style',
                              style: defaultTS,
                            ),
                          ),
                          Container(
                            // color: Color(0xff18191A),
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
                                        await requestPermission(
                                            Permission.storage);
                                        await ImageGallerySaver.saveImage(
                                            image!,
                                            name: name);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Image saved.'),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      }).catchError((err) {
                                        print(err);
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.save,
                                    color: primary,
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
                                    color: primary,
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
                                    color: primary,
                                  ),
                                  tooltip: 'Decrease font size',
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      texts[currentIndex].textAlign =
                                          TextAlign.left;
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
                                      texts[currentIndex].textAlign =
                                          TextAlign.center;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.format_align_center,
                                    color: primary,
                                  ),
                                  tooltip: 'Align Center',
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      texts[currentIndex].textAlign =
                                          TextAlign.right;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.format_align_right,
                                    color: primary,
                                  ),
                                  tooltip: 'Align Right',
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (texts[currentIndex].fontWeight !=
                                        FontWeight.bold) {
                                      setState(() {
                                        texts[currentIndex].fontWeight =
                                            FontWeight.bold;
                                      });
                                    } else {
                                      setState(() {
                                        texts[currentIndex].fontWeight =
                                            FontWeight.normal;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.format_bold,
                                    color: primary,
                                  ),
                                  tooltip: 'Bold',
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (texts[currentIndex].fontStyle ==
                                        FontStyle.italic) {
                                      setState(() {
                                        texts[currentIndex].fontStyle =
                                            FontStyle.normal;
                                      });
                                    } else {
                                      setState(() {
                                        texts[currentIndex].fontStyle =
                                            FontStyle.italic;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.format_italic,
                                    color: primary,
                                  ),
                                  tooltip: 'Italic',
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (texts[currentIndex]
                                        .text
                                        .contains('\n')) {
                                      setState(() {
                                        texts[currentIndex].text =
                                            texts[currentIndex]
                                                .text
                                                .replaceAll('\n', ' ');
                                      });
                                    } else {
                                      setState(() {
                                        texts[currentIndex].text =
                                            texts[currentIndex]
                                                .text
                                                .replaceAll(' ', '\n');
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.space_bar,
                                    color: primary,
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
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              'Image',
                              style: defaultTS,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Screenshot(
                            controller: screenshotController,
                            child: SizedBox(
                              height: getWidth(context),
                              width: getWidth(context),
                              child: Stack(
                                children: [
                                  selectedImage,
                                  Container(
                                    height: getWidth(context),
                                    width: getWidth(context),
                                    color: filterColor,
                                  ),
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
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text('Text removed!'),
                                            ),
                                          );
                                        },
                                        onTap: () =>
                                            setCurrentIndex(context, i),
                                        child: Draggable(
                                          feedback:
                                              ImageText(textInfo: texts[i]),
                                          child: ImageText(textInfo: texts[i]),
                                          onDragEnd: (drag) {
                                            final renderBox =
                                                context.findRenderObject()
                                                    as RenderBox;
                                            Offset offset = renderBox
                                                .globalToLocal(drag.offset);
                                            setState(() {
                                              texts[i].top = offset.dy - 200;
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
                                                color: Colors.black
                                                    .withOpacity(.3)),
                                          ),
                                        )
                                      : SizedBox.shrink()
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              'Apply Filters',
                              style: defaultTS,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 100,
                            width: getWidth(context),
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        filterColor =
                                            Colors.deepOrange.withOpacity(.3);
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.file(
                                            File(widget.selectedImage),
                                            fit: BoxFit.fill,
                                            width: getWidth(context),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          width: 100,
                                          color:
                                              Colors.deepOrange.withOpacity(.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        filterColor =
                                            Colors.pink.withOpacity(.3);
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.file(
                                            File(widget.selectedImage),
                                            fit: BoxFit.fill,
                                            width: getWidth(context),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.pink.withOpacity(.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        filterColor =
                                            Colors.blueAccent.withOpacity(.3);
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.file(
                                            File(widget.selectedImage),
                                            fit: BoxFit.fill,
                                            width: getWidth(context),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          width: 100,
                                          color:
                                              Colors.blueAccent.withOpacity(.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        filterColor =
                                            Colors.green.withOpacity(.3);
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.file(
                                            File(widget.selectedImage),
                                            fit: BoxFit.fill,
                                            width: getWidth(context),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.green.withOpacity(.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        filterColor =
                                            Colors.yellow.withOpacity(.3);
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.file(
                                            File(widget.selectedImage),
                                            fit: BoxFit.fill,
                                            width: getWidth(context),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.yellow.withOpacity(.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        filterColor =
                                            Colors.black.withOpacity(.3);
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.file(
                                            File(widget.selectedImage),
                                            fit: BoxFit.fill,
                                            width: getWidth(context),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.black.withOpacity(.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        filterColor =
                                            Colors.cyan.withOpacity(.3);
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.file(
                                            File(widget.selectedImage),
                                            fit: BoxFit.fill,
                                            width: getWidth(context),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.cyan.withOpacity(.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        filterColor =
                                            Colors.deepPurple.withOpacity(.3);
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.file(
                                            File(widget.selectedImage),
                                            fit: BoxFit.fill,
                                            width: getWidth(context),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          width: 100,
                                          color:
                                              Colors.deepPurple.withOpacity(.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Work in progress.',
                                  style: defaultTS.copyWith(color: Colors.white30),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addDialogBox(context),
        tooltip: "Add text in image",
        backgroundColor: primary,
        child: Icon(
          Icons.edit,
          color: background,
        ),
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
