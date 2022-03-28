import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seedsnap_image_editor/screens/editor.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SeedSnap'),
        centerTitle: true,
      ),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.upload_file),
          onPressed: () async {
            XFile? xfile =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (xfile != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Editor(selectedImage: xfile.path),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
