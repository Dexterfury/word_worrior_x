import 'package:flutter/material.dart';
import 'package:word_worrior_x/constants.dart';
import 'package:word_worrior_x/providers/game_provider.dart';

class LevelAndPlayers extends StatelessWidget {
  const LevelAndPlayers({
    super.key,
    required this.gameProvider,
  });

  final GameProvider gameProvider;

  @override
  Widget build(BuildContext context) {
    final singlePlayer = gameProvider.gameMode == GameMode.singlePlayer;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(
          singlePlayer ? Icons.laptop : Icons.group,
          color: Colors.white,
        ),
      ),
      title: Text(
        singlePlayer ? Constants.level : Constants.numberOfPlayers,
      ),
      subtitle: Text(
        singlePlayer ? Constants.levelDes : Constants.playersDes,
      ),
      trailing: singlePlayer ? levelDropDown() : numbersDropDown(),
    );
  }

  Widget levelDropDown() {
    final computerLevel = gameProvider.computerLevel;
    final setComputerLevel = gameProvider.setComputerLevel;
    return DropdownButton<int>(
        value: computerLevel.index,
        onChanged: (value) {
          setComputerLevel(ComputerLevel.values[value!]);
        },
        items: List.generate(Constants.levels.length, (index) {
          // get level
          final level = Constants.levels[index].name;
          // capitalize the first letter
          final capitalizedLevel = level[0].toUpperCase() + level.substring(1);
          return DropdownMenuItem(
            value: index,
            child: Text(
              capitalizedLevel,
            ),
          );
        }));
  }

  Widget numbersDropDown() {
    final numberOfPlayers = gameProvider.numberOfPlayers;
    final setNumberOfPlayers = gameProvider.setNumberOfPlayers;
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: numberOfPlayers == 2
                ? null
                : () {
                    setNumberOfPlayers(numberOfPlayers - 1);
                  },
            icon: const Icon(
              Icons.remove,
            ),
          ),
          Text(
            numberOfPlayers.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          IconButton(
            onPressed: numberOfPlayers == 10
                ? null
                : () {
                    setNumberOfPlayers(numberOfPlayers + 1);
                  },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
    );
  }
}
