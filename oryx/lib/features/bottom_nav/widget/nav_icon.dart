import 'package:flutter/material.dart';

class NavBarIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  const NavBarIcon({super.key, required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Icon(
        icon,
        size: 22,
        color: iconColor,
      ),
    );
  }
}
