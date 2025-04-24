import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerWidget extends StatelessWidget {
  final String title;
  final String? subTitle;
  final IconData? icon;
  final Color textColor;
  final Color? color;
  final Color? iconColor;
  final VoidCallback? onTap;

  const ContainerWidget({
    super.key,
    required this.title,
    required this.textColor,
    this.subTitle,
    this.icon,
    this.color,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: Get.height * 0.16,
        width: Get.width * 0.44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor),
              SizedBox(height: 6),
            ],
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subTitle != null)
              Text(
                subTitle!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
