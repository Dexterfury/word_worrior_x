import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_worrior_x/constants.dart';
import 'package:word_worrior_x/providers/game_provider.dart';
import 'package:word_worrior_x/widgets/reusable_display.dart';

class PointsDisply extends StatelessWidget {
  const PointsDisply({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, gameProvider, child) {
      final myScore = gameProvider.score;
      final computerScore = gameProvider.computerScore;
      final isPlaying = gameProvider.isPlaying;
      final isSinglePlayer = gameProvider.gameMode == GameMode.singlePlayer;

      return isPlaying
          ? Card(
              child: isSinglePlayer
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableDisplay(label: 'Points', points: myScore),
                          const Text('VS'),
                          ReusableDisplay(
                              label: 'Computer', points: computerScore),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ReusableDisplay(label: 'Points', points: myScore),
                    ),
            )
          : const SizedBox();
    });
  }
}
