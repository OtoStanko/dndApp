import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoggedInSettings extends StatelessWidget {
  final User user;

  const LoggedInSettings({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final service = GetIt.I<FirebaseService>();

    return Column(
      children: [
        ListTile(
          title: const Text('Name'),
          trailing: Text(user.displayName ?? ''),
          onLongPress: () {
            _showEditNameDialog(context, service);
          },
        ),
        ListTile(
            title: const Text('Email'),
            trailing: Text(user.email ?? '<no_email>'),
            onLongPress: () {
              _showEditEmailDialog(context, service);
            }),
        ListTile(
          title: const Text('Photo'),
          trailing: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: user.photoURL!.isNotEmpty ? Image.network(
                user.photoURL!,
                width: 50,
                height: 50,
                fit: BoxFit.fitWidth,
              ) : const Text('No photo')),
          onLongPress: () {
            service.updateUserPhoto();
          },
        ),
        const Divider(),
        ElevatedButton(
          onPressed: () async {
            service.signOut().then((value) => Navigator.pop(context));
          },
          child: const Text('Sign out'),
        ),
      ],
    );
  }

  void _showEditNameDialog(BuildContext context, FirebaseService service) {
    final controller = TextEditingController(text: user.displayName);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit name'),
            content: TextField(
              controller: controller,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    service
                        .updateDisplayName(controller.text)
                        .then((value) => Navigator.pop(context));
                  },
                  child: const Text('Save')),
            ],
          );
        });
  }

  void _showEditEmailDialog(BuildContext context, FirebaseService service) {
    final controller = TextEditingController(text: user.email);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit email'),
            content: TextField(
              controller: controller,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    service
                        .updateDisplayName(controller.text)
                        .then((value) => Navigator.pop(context));
                  },
                  child: const Text('Save')),
            ],
          );
        });
  }
}
