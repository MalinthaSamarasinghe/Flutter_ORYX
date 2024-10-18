import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter/material.dart';

class SettingMenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPress;

  const SettingMenuCard({
    super.key,
    required this.title,
    required this.icon,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.transparent,
          overlayColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.all(20),
          backgroundColor: kColorTextField,
        ),
        onPressed: onPress,
        child: Row(
          children: [
            Icon(icon, size: 24, color: kColorBlack),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: kInter600(context, fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: kColorBlack),
          ],
        ),
      ),
    );
  }
}
