import 'package:catalogo_filmes/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<NotificationService>(context);
    final items = service.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Notificações'),
      ),
      body: ListView.builder(
        itemCount: service.itemsCount,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(items[i].title.toString()),
          subtitle: Text(items[i].body.toString()),
          onTap: () => service.remove(i),
        ),
      ),
    );
  }
}
