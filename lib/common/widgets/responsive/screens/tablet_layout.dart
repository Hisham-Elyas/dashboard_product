import 'package:flutter/material.dart';

import '../../layouts/headers/header.dart';
import '../../layouts/sidebars/sidbar.dart';

class TabletLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final Widget? body;
  TabletLayout({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: const HSidbar(),
        appBar: HHeader(
          scaffoldKey: scaffoldKey,
        ),
        body: body);
  }
}
