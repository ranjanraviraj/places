import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function _pickedImage;

  ImageInput(this._pickedImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storeImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if(imageFile == null) {
      return;
    }
    setState(() {
      _storeImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget._pickedImage(saveImage);    
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 130,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storeImage != null
              ? Image.file(
                  _storeImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Imgae Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: FlatButton.icon(
          onPressed: _takePicture,
          icon: Icon(Icons.camera),
          label: Text('Take Picture'),
          textColor: Theme.of(context).primaryColor,
        ))
      ],
    );
  }
}
