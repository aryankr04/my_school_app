import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';

class SchoolElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const SchoolElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            visible: !isLoading,
            child: Text(
              text,
            ),
          ),
          Visibility(
            visible: isLoading,
            child: const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
