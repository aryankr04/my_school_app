import 'package:flutter/material.dart';

// Enum to define button styles
enum CustomButtonStyle { filled, outlined }

class CustomButton extends StatelessWidget {
  final VoidCallback onTap; // Callback for onTap action
  final String text; // Text to be displayed on the button
  final double radius; // Border radius for the button
  final EdgeInsetsGeometry padding; // Padding around the text
  final Color color; // Background color of the button
  final Color borderColor; // Border color for outlined button
  final CustomButtonStyle style; // Button style (filled or outlined)

  // Constructor to pass all the customizable parameters
  CustomButton({
    required this.onTap,
    required this.text,
    this.radius = 8.0, // Default radius
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Default padding
    this.color = Colors.blue, // Default background color for filled button
    this.borderColor = Colors.blue, // Default border color for outlined button
    this.style = CustomButtonStyle.filled, // Default style is filled
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: padding,
        decoration: BoxDecoration(
          color: style == CustomButtonStyle.filled ? color : Colors.transparent, // Set color for filled, transparent for outlined
          borderRadius: BorderRadius.circular(radius),
          border: style == CustomButtonStyle.outlined ? Border.all(color: borderColor) : null, // Border for outlined button
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: style == CustomButtonStyle.filled ? Colors.white : borderColor, // Text color: white for filled, border color for outlined
          ),
        ),
      ),
    );
  }
}
