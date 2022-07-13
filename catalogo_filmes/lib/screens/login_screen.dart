import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/widgets/image_input.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _userName = TextEditingController();
  late File? _pickedImage;

  bool _isLogin = true;
  late String _title;
  late String _actionButtonLabel;
  late String _toggleButtonLabel;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _setFormAction(true);
  }

  _setFormAction(bool mode) {
    _isLogin = mode;
    if (_isLogin) {
      _title = 'Welcome';
      _actionButtonLabel = 'Login';
      _toggleButtonLabel = 'Don\' have an account? Sign up here!';
    } else {
      _title = 'Create account';
      _actionButtonLabel = 'Register';
      _toggleButtonLabel = 'You already have an account? Log in here!';
    }
  }

  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(_email.text, _password.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  registrar() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().registrar(
          _email.text, _password.text, _pickedImage!.path, _userName.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Widget _buildSignUpNameAndPhotoFields(Function selectImage) {
    return Column(
      children: [
        ImageInput(selectImage),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 15),
          child: TextFormField(
            controller: _userName,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Username'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Insert your username!';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _title,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                _isLogin
                    ? const SizedBox(
                        height: 0,
                      )
                    : _buildSignUpNameAndPhotoFields(_selectImage),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 15),
                  child: TextFormField(
                    autofocus: false,
                    controller: _email,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Insert the email correctly!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
                  child: TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Insert your password!';
                      } else if (value.length < 6) {
                        return 'Your password needs at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 25),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_isLogin) {
                          login();
                        } else {
                          registrar();
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(_actionButtonLabel),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _setFormAction(!_isLogin);
                      });
                    },
                    child: Text(_toggleButtonLabel),
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary)),
              ],
            )),
      )),
    );
  }
}
