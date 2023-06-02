import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:univhex/Constants/current_user.dart';

@RoutePage(name: 'DiscoverPageRoute')
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              child: Text("Discover Page"),
            ),
            ElevatedButton(
                onPressed: () {
                  debugPrint(CurrentUser.user.toString());
                },
                child: Text("Debug"))
          ],
        ),
      );
}
