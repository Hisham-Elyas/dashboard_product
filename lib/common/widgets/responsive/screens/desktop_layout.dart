import 'package:flutter/material.dart';

import '../../layouts/headers/header.dart';
import '../../layouts/sidebars/sidbar.dart';

class DesktopLayout extends StatelessWidget {
  final Widget? body;
  const DesktopLayout({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        const Expanded(child: HSidbar()),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              // Header
              const HHeader(),
              // Body
              Expanded(child: body ?? const SizedBox())
            ],
          ),
        ),
      ]),
    );
  }
}
