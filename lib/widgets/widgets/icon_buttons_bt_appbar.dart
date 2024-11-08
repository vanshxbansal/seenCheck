import 'package:flutter/material.dart';

class BuildIconButtonsForBottomAppBar extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;

  const BuildIconButtonsForBottomAppBar({super.key,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(iconData),
            color: Colors.white,
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
