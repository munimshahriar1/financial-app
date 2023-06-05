import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  const ExpandedButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    required this.isDarkTheme,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String buttonText;
  final bool isDarkTheme;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        isDarkTheme ? Colors.black : Colors.white;
    Color foregroundColor =
        isDarkTheme ? Colors.white : Colors.black;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
