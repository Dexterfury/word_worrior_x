import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_worrior_x/constants.dart';
import 'package:word_worrior_x/providers/game_provider.dart';
import 'package:word_worrior_x/utilities/global.dart';
import 'package:word_worrior_x/widgets/game_over.dart';

class StartStopButton extends StatelessWidget {
  const StartStopButton({super.key});

  @override
  Widget build(BuildContext context) {
    //final gameProvider = context.watch<GameProvider>();
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                gameProvider.isPlaying ? Colors.red : Colors.deepPurple,
          ),
          onPressed: () {
            // check if the game is playing
            if (gameProvider.isPlaying) {
              // show dialog to ask if the user wants to stop the game
              showMyAnimatedDialog(
                  context: context,
                  title: 'Quit Game',
                  content: 'Are you sure to Quit?',
                  textAction: 'Yes',
                  onActionTap: (value) {
                    if (value) {
                      // stop the game
                      gameProvider.stopGame(
                        quit: true,
                      );

                      // show game over page rout builder
                      gameOver(
                        context: context,
                        gameProvider: gameProvider,
                      );
                    }
                  });
            } else {
              // show game setup bottom sheet
              showGameSetupBottomSheet(
                  context: context,
                  isSignedIn: false,
                  onActionTap: (value) {
                    if (value) {
                      // check if its multiplayer
                      if (gameProvider.gameMode == GameMode.multiPlayer) {
                        // do action for multiplayer
                      } else {
                        // start the game
                        gameProvider.startGame(timeUp: () {
                          // show game over page rout builder
                          gameOver(
                            context: context,
                            gameProvider: gameProvider,
                          );
                        });
                      }
                    } else {
                      //gameProvider.stopGame();
                    }
                  });
            }
          },
          child: Text(
            gameProvider.isPlaying
                ? Constants.stop.toUpperCase()
                : Constants.start.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
