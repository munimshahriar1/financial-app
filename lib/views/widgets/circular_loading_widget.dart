import "package:flutter/material.dart";

class CircularLoading extends StatelessWidget {
  const CircularLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: CircularProgressIndicator(
            color: Colors.white), // Show loading indicator
      ),
    );
  }
}
