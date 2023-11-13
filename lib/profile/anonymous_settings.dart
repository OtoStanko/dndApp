import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/common/services/flutter_service.dart';
import 'package:firstapp/common/widgets/page_wrapper.dart';
import 'package:firstapp/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AnonymousSettings extends StatelessWidget {
  final User user;

  const AnonymousSettings({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<FirebaseService>();

    return SingleChildScrollView(
      child: ListView(shrinkWrap: true, children: [
        ListTile(
          title: const Text('User ID'),
          trailing: Text(user.uid),
        ),
        const Divider(),
        ListTile(
          title: const Text('Username'),
          trailing: Text(user.displayName ?? 'Anonymous'),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const PageWrapper(child: SignUpPage());
                }));
              },
              child: const Text('Create Account'),
            ),
            ElevatedButton(
                onPressed: () {
                  // Dialog to confirm
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Remove anonymous data'),
                          content: const Text(
                              'Are you sure you want to remove your anonymous data?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: () {
                                  service.deleteAnonymousUser();
                                  Navigator.pop(context);
                                },
                                child: const Text('Remove'))
                          ],
                        );
                      });
                },
                child: const Text('Remove anonymous data'))
          ],
        ),
      ]),
    );
  }
}
