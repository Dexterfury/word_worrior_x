import 'package:flutter/material.dart';
import 'package:word_worrior_x/constants.dart';
import 'package:word_worrior_x/providers/game_provider.dart';
import 'package:word_worrior_x/utilities/global.dart';

class QuantityListTile extends StatelessWidget {
  const QuantityListTile({
    super.key,
    required this.gameProvider,
  });

  final GameProvider gameProvider;

  @override
  Widget build(BuildContext context) {
    final timeMode = gameProvider.isTimeMode;
    final gameDuration = gameProvider.gameDuration;
    final numberOfWords = gameProvider.numberOfWords;
    final setGameTime = gameProvider.setGameDuration;
    final setNumberOfWords = gameProvider.setNumberOfWords;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(
          timeMode ? Icons.timer : Icons.timer_off,
          color: Colors.white,
        ),
      ),
      title: Text(
        timeMode ? Constants.time : Constants.words,
      ),
      subtitle: Text(
        timeMode ? Constants.timeDes : Constants.wordsDes,
      ),
      trailing: DropdownButton<int>(
        value: timeMode ? gameDuration : numberOfWords,
        items: List.generate(
            timeMode
                ? Constants.gameTimes.length
                : Constants.numberOfWords.length, (index) {
          return DropdownMenuItem<int>(
            value: timeMode
                ? Constants.gameTimes[index]
                : Constants.numberOfWords[index],
            child: Text(
              timeMode
                  ? displayGameTime(time: index)
                  : '${Constants.numberOfWords[index]} words',
            ),
          );
        }),
        onChanged: (value) {
          if (timeMode) {
            setGameTime(value!);
          } else {
            setNumberOfWords(value!);
          }
        },
      ),
    );
  }
}
