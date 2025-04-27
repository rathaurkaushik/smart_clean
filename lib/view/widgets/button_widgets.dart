import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidgets extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? color;
  final VoidCallback? onTap;


  const ButtonWidgets({
    super.key,
    required this.title,
    this.icon,
    required this.backgroundColor,
    required this.color,
   this.onTap,

  });
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.9,
        height: 50,

        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              RichText(
                text: TextSpan(
                  text: title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
