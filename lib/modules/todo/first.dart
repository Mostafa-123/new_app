import 'package:flutter/material.dart';

class first extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        title: Icon(Icons.accessibility),
        actions: [Icon(Icons.search)],
      ),
    );
  }
}
