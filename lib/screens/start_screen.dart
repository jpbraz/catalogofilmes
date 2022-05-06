import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          Container(padding: EdgeInsets.all(10), child: Icon(Icons.menu))
        ],
        title: Text('NerdCatalog'),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose your plataform',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    child: Image.asset('assets/imgs/netflix_logo.png',
                        height: 65)),
                SizedBox(
                  width: 30,
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    child:
                        Image.asset('assets/imgs/prime_logo.png', height: 65)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
