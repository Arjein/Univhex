import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Objects/user_secure_storage.dart';
import 'package:univhex/Router/app_router.gr.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                if (await UserSecureStorage.deleteStorage()) {
                  context.router.replaceAll([const AuthRoute()]);
                }
              },
              child: const Text("Log Out"),
            )
          ],
        ),
      ),
    );
  }
}
