import 'dart:io';

import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final File _profilePicture;

  ProfileInfo(this._profilePicture);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 72, backgroundImage: FileImage(_profilePicture));
  }
}
