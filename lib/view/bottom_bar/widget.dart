import 'package:flutter/material.dart';

class AnimatedLabel extends StatefulWidget {
  final String label;
  final bool isActive;

  const AnimatedLabel({
    Key? key,
    required this.label,
    required this.isActive,
  }) : super(key: key);

  @override
  _AnimatedLabelState createState() => _AnimatedLabelState();
}

class _AnimatedLabelState extends State<AnimatedLabel> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        widget.label,
        key: ValueKey<String>(widget.label),
        style: TextStyle(
          color: widget.isActive ? Colors.blue : Colors.grey,
          fontWeight: widget.isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
