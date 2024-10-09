import 'package:flutter/material.dart';

import '../../utils/constants/dynamic_colors.dart';

class SchoolExpansionTile extends StatefulWidget {
  final Widget title;
  final Widget? leading;
  final List<Widget> children;
  final Color? backgroundColor;
  final bool? initiallyExpanded;

  const SchoolExpansionTile({
    Key? key,
    required this.title,
    this.leading,
    required this.children,
    this.backgroundColor,
    this.initiallyExpanded,
  }) : super(key: key);

  @override
  _SchoolExpansionTileState createState() => _SchoolExpansionTileState();
}

class _SchoolExpansionTileState extends State<SchoolExpansionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late ValueNotifier<bool> _isExpandedNotifier;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _isExpandedNotifier = ValueNotifier<bool>(widget.initiallyExpanded ?? false);
    if (widget.initiallyExpanded ?? false) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _isExpandedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _isExpandedNotifier.value = !_isExpandedNotifier.value;
            if (_isExpandedNotifier.value) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          },
          child: Container(
            color: widget.backgroundColor,
            child: Row(
              children: [
                if (widget.leading != null) ...[
                  widget.leading!,
                  SizedBox(), // Add some space after the leading widget
                ],
                Expanded(child: widget.title),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return RotationTransition(
                      turns: _animationController,
                      child: Icon(
                        _isExpandedNotifier.value ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                        color: SchoolDynamicColors.iconColor,
                        size: 24,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        ValueListenableBuilder<bool>(
          valueListenable: _isExpandedNotifier,
          builder: (context, isExpanded, child) {
            return SizeTransition(
              sizeFactor: _animationController,
              axisAlignment: -1.0,
              child: Column(
                children: widget.children,
              ),
            );
          },
        ),
      ],
    );
  }
}
