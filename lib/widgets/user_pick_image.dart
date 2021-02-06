import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserPickImage extends StatefulWidget {
  void Function(File pickedImage) pickedImageFn;

  UserPickImage(this.pickedImageFn);

  @override
  UserPickImageState createState() => UserPickImageState();
}

class UserPickImageState extends State<UserPickImage> {
  File _displayPicture;
  void _pickImage() async {
    final pickedImage = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 600, maxWidth: 600);
    setState(() {
      _displayPicture = pickedImage;
    });
    widget.pickedImageFn(_displayPicture);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _displayPicture == null ? null : FileImage(_displayPicture),
        ),
        FlatButton.icon(
          color: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.camera),
          label: Text("Add Picture"),
        ),
      ],
    );
  }
}
