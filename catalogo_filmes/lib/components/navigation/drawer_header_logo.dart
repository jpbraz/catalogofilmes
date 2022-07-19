import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class DrawerHeaderLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.112,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).colorScheme.secondary,
      child: Text(
        'NerdCatalog',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 42,
            color: Theme.of(context).colorScheme.tertiary),
      ),
    );
  }
}
