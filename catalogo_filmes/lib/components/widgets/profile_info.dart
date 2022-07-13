import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class ProfileInfo extends StatefulWidget {
  ProfileInfo();

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  late File _profilePicture;

  _generateImageFile() async {
    final _auth = Provider.of<AuthService>(context).user;
    final dir = await getApplicationDocumentsDirectory();
    final fileName = '${_auth!.uid}.jpg';
    final fileDir = '${dir.absolute.path}/$fileName';
    setState(() {
      _profilePicture = File(fileDir);
    });
  }

  @override
  Widget build(BuildContext context) {
    _generateImageFile();
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
      ),
      child: Image.file(_profilePicture),
    );
  }
}
