// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:salon_app/core/managers/navigation/nav_routes.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Seems Like you are lost"),
          Image.network(
            "https://i.pinimg.com/736x/4e/37/3b/4e373b73dc9535ffc979d975897a0840.jpg",
            height: 200,
          ),
          const SizedBox(height: 30),
          const Text("404",
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          const Text("You want me to take you home?"),
          const SizedBox(height: 30),
          TextButton.icon(
              onPressed: () {
                GoRouter.of(context).go(Routes.root);
              },
              icon: const Icon(Icons.home),
              label: const Text("Go Home")),
        ],
      ),
    );
  }
}
