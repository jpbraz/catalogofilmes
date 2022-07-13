import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  void _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile? imageFile;
    await _picker
        .pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    )
        .then((file) {
      if (file != null) {
        imageFile = file;
      } else {
        imageFile = null;
      }
    });

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile!.path);
    });

    _uploadImage();
  }

  void _pickImageInGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? imageFile;
    await _picker
        .pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    )
        .then((file) {
      if (file != null) {
        imageFile = file;
      } else {
        imageFile = null;
      }
    });

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile!.path);
    });

    _uploadImage();
  }

  void _uploadImage() async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy(
      '${appDir.absolute.path}/$fileName',
    );
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _takePicture(),
      onLongPress: () => _pickImageInGallery(),
      child: CircleAvatar(
          radius: 72,
          child: _storedImage == null
              ? const Text(
                  'Upload image',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                )
              : null,
          backgroundImage:
              _storedImage != null ? FileImage(_storedImage!) : null,
          backgroundColor: Colors.grey[300]),
      // child: Container(
      //   width: 150,
      //   height: 150,
      //   decoration: BoxDecoration(
      //     border: Border.all(width: 1, color: Colors.grey),
      //   ),
      //   alignment: Alignment.center,
      //   child: _storedImage != null
      //       ? Image.file(
      //           _storedImage!,
      //           width: double.infinity,
      //           fit: BoxFit.cover,
      //         )
      //       : const Text('Nenhuma Imagem!'),
      // ),
    );
  }
}
