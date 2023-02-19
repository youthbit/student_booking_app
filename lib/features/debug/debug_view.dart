import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routing/router_spec.dart';

class DebugView extends StatelessWidget {
  const DebugView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Menu'),
      ),
      body: Column(
        children: [
          TextButton(
            child: const Text('Trigger Error Alert'),
            onPressed: () {
              if (!context.mounted) return;
              context.goNamed(RouteSpec.error.name);
            },
          ),
          TextButton(
            child: const Text('Trigger Success Alert'),
            onPressed: () {
              if (!context.mounted) return;
              context.goNamed(RouteSpec.success.name);
            },
          ),
        ],
      ),
    );
  }
}
