import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';

class CircularIndicatorWithValue extends StatefulWidget {
  final double value;
  final Color backgroundColor;
  final Animation<Color>? valueColor;

  CircularIndicatorWithValue({
    required this.value,
    required this.backgroundColor,
    required this.valueColor,
  });

  @override
  _CircularIndicatorWithValueState createState() => _CircularIndicatorWithValueState();
}

class _CircularIndicatorWithValueState extends State<CircularIndicatorWithValue> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Adjust duration as needed
    );
    _animation = Tween<double>(begin: 0, end: widget.value).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 64,
            width: 64,
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              strokeWidth: 6,
              value: _animation.value, // Use animated value
              backgroundColor: widget.backgroundColor,
              valueColor: widget.valueColor,
            ),
          ),
          if (_animation.value >= 0) // Display percentage text only if value is greater than 0
            Text(
              '${(_animation.value * 100).toStringAsFixed(1)}%', // Display percentage value
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: SchoolDynamicColors.headlineTextColor, // Adjust the color as needed
              ),
            )
          else
            Text(
              '0.00%',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: SchoolDynamicColors.headlineTextColor, // Adjust the color as needed
              ),
            ),
        ],
      );
    } catch (e, stackTrace) {
      // Handle the exception
      print('CircularIndicator Exception: $e\nStackTrace: $stackTrace');
      // Return a default fallback widget or an error message
      return Container(
        height: 64,
        width: 64,
        color: Colors.red,
        child: Center(
          child: Text(
            'Error',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}
