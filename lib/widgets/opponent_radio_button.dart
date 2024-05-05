import 'package:flutter/material.dart';
import 'package:word_worrior_x/constants.dart';

class OpponentRadioButton extends StatelessWidget {
  const OpponentRadioButton({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String title;
  final GameMode value;
  final GameMode? groupValue;
  final Function(GameMode?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadioListTile<GameMode>(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: EdgeInsets.zero,
        tileColor: Colors.grey[300],
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
