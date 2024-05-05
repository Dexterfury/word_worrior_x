import 'package:flutter/material.dart';
import 'package:word_worrior_x/constants.dart';
import 'package:word_worrior_x/providers/game_provider.dart';

class GameModeListTile extends StatelessWidget {
  const GameModeListTile({
    super.key,
    required this.gameProvider,
  });

  final GameProvider gameProvider;

  @override
  Widget build(BuildContext context) {
    final timeMode = gameProvider.isTimeMode;
    final onChanged = gameProvider.setIsTimeMode;
    return SwitchListTile(
      secondary: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(
          timeMode ? Icons.timer : Icons.timer_off,
          color: Colors.white,
        ),
      ),
      title: Text(
        timeMode ? Constants.timeMode : Constants.wordsMode,
      ),
      subtitle: const Text(
        Constants.toggleBetweenTW,
      ),
      contentPadding: EdgeInsets.zero,
      value: timeMode,
      onChanged: onChanged,
    );
  }
}
