import 'package:flutter/material.dart';

import 'welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "BharatPool",
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}