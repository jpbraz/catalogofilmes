import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/components/navigation/navigation_routes_buttons.dart';
import '/components/navigation/drawer_header_logo.dart';
import '/components/navigation/logout_button.dart';

import '../../services/auth_service.dart';
import '../widgets/profile_info.dart';

class MyMainDrawer extends StatefulWidget {
  @override
  State<MyMainDrawer> createState() => _MyMainDrawerState();
}

class _MyMainDrawerState extends State<MyMainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(children: [
        DrawerHeaderLogo(),
        const SizedBox(
          height: 15,
        ),
        Consumer<AuthService>(
          builder: ((context, auth, child) {
            return auth.user != null
                ? auth.user!.displayName != null
                    ? ProfileInfo(auth.user!.displayName!, auth.user!.email!,
                        auth.profilePicture)
                    : Container(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      )
                : const Text('No user');
          }),
        ),
        const SizedBox(height: 10),
        Divider(
          thickness: 2,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        Expanded(child: NavigationRoutesButtons()),
        Divider(
          thickness: 2,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        const SizedBox(height: 10),
        LogoutButton(),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
