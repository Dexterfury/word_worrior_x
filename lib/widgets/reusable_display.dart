import 'package:flutter/material.dart';

class ReusableDisplay extends StatelessWidget {
  const ReusableDisplay({
    super.key,
    required this.label,
    required this.points,
  });

  final String label;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        const SizedBox(
          width: 80,
          child: Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
        ),
        Text(points.toString())
      ],
    );
  }
}
