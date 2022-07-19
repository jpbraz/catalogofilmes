import 'package:catalogo_filmes/screens/catalog_screen.dart';
import 'package:catalogo_filmes/services/auth_service.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../screens/login_screen.dart';
import 'loading.dart';

class AuthCheck extends StatefulWidget {
  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return const Loading();
    } else if (auth.user == null) {
      return LoginScreen();
    } else {
      return CatalogScreen();
    }
  }
}
