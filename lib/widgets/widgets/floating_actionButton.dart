import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function onPressed;

  const CustomFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await onPressed();
      },
      tooltip: 'Search',
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }
}
