import 'package:catalogo_filmes/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../utils/app_routes.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await context.read<AuthService>().logout();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.STARTPAGE, (route) => false);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Logout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Theme.of(context).colorScheme.tertiary,
              )),
          const SizedBox(
            width: 12,
          ),
          Icon(
            Icons.logout,
            size: 45,
            color: Theme.of(context).colorScheme.tertiary,
          )
        ],
      ),
    );
  }
}
