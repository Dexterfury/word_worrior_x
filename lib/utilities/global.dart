import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_worrior_x/constants.dart';
import 'package:word_worrior_x/providers/game_provider.dart';
import 'package:word_worrior_x/utilities/assets_manager.dart';
import 'package:word_worrior_x/widgets/game_mode_listtile.dart';
import 'package:word_worrior_x/widgets/level_and_players.dart';
import 'package:word_worrior_x/widgets/opponent_radio_button.dart';
import 'package:word_worrior_x/widgets/play_button.dart';
import 'package:word_worrior_x/widgets/quantity_listtile.dart';
import 'package:word_worrior_x/widgets/sign_in_button.dart';

List<TextSpan> getColoredTextSpans(String currentWord, String typedWord) {
  List<TextSpan> spans = [];

  for (int i = 0; i < currentWord.length; i++) {
    bool isCorrect = i < typedWord.length && currentWord[i] == typedWord[i];

    spans.add(
      TextSpan(
          text: currentWord[i].toUpperCase(),
          style: TextStyle(
            color: isCorrect ? Colors.green : Colors.black,
            fontWeight: FontWeight.bold,
          )),
    );
  }
  return spans;
}

// game setup bottom sheet
void showGameSetupBottomSheet({
  required BuildContext context,
  required bool isSignedIn,
  required Function(bool) onActionTap,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Constants.gameSetup,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10.0),
                const Divider(
                  thickness: 1.0,
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    OpponentRadioButton(
                        title: 'Single Player',
                        value: GameMode.singlePlayer,
                        groupValue: gameProvider.gameMode,
                        onChanged: (value) {
                          // set value in game provider
                          gameProvider.setGameMode(value!);
                        }),
                    const SizedBox(
                      width: 10.0,
                    ),
                    OpponentRadioButton(
                        title: 'Multi Player',
                        value: GameMode.multiPlayer,
                        groupValue: gameProvider.gameMode,
                        onChanged: (value) {
                          // set value in game provider
                          gameProvider.setGameMode(value!);
                        }),
                  ],
                ),
                const SizedBox(height: 10.0),

                // game mode
                LevelAndPlayers(
                  gameProvider: gameProvider,
                ),
                const SizedBox(height: 10.0),

                // time mode
                GameModeListTile(
                  gameProvider: gameProvider,
                ),

                const SizedBox(height: 10.0),

                // quantity list tile
                QuantityListTile(
                  gameProvider: gameProvider,
                ),

                const SizedBox(height: 10.0),

                // SignInButton(
                //   logoUrl: AssetsManager.googleLogo,
                //   label: 'Sign In',
                //   onPressed: () {},
                // )

                gameProvider.gameMode == GameMode.multiPlayer && !isSignedIn
                    ? SignInButton(
                        logoUrl: AssetsManager.googleLogo,
                        label: 'Sign In',
                        onPressed: () {
                          // sign in user

                          // pop the bottom sheet
                          Navigator.pop(context);
                          // call the onActionTap function
                          onActionTap(true);
                        },
                      )
                    : PlayButton(
                        title: 'Play',
                        onTap: () {
                          // pop the bottom sheet
                          Navigator.pop(context);
                          // call the onActionTap function
                          onActionTap(true);
                        },
                      ),
              ],
            ),
          );
        },
      );
    },
  );
}

// display game time like 00:00
String displayGameTime({
  required int time,
  bool playing = false,
}) {
  final minutes = playing ? time ~/ 60 : Constants.gameTimes[time] ~/ 60;
  final seconds = playing ? time % 60 : Constants.gameTimes[time] % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

// // display game time
// String displayGameTimePackageMethod(int time) {
//   final minutes = Constants.gameTimes[time] ~/ 60;
//   final seconds = Constants.gameTimes[time] % 60;
//   return sprintf("%02i:%02i", [minutes, seconds]);
// }

// show my animated dialog
void showMyAnimatedDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String textAction,
  String textCancel = 'Cancel',
  bool isReadOnly = false,
  required Function(bool) onActionTap,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: AlertDialog(
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              content: Text(
                content,
                textAlign: TextAlign.center,
              ),
              actions: [
                isReadOnly
                    ? const CircularProgressIndicator()
                    : TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onActionTap(false);
                        },
                        child: Text(textCancel),
                      ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onActionTap(true);
                  },
                  child: Text(textAction),
                ),
              ],
            ),
          ));
    },
  );
}
