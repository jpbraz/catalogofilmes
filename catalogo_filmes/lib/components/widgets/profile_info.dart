import 'dart:io';

import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String name;
  final String email;
  final File _profilePicture;

  ProfileInfo(this.name, this.email, this._profilePicture);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(radius: 72, backgroundImage: FileImage(_profilePicture)),
          const SizedBox(height: 5),
          Text(
            name,
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            email,
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}
