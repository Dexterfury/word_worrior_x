import 'package:flutter/material.dart';
import 'package:word_worrior_x/constants.dart';
import 'package:word_worrior_x/providers/game_provider.dart';

void gameOver({
  required BuildContext context,
  required GameProvider gameProvider,
}) async {
  // rout to game over page route builder
  PageRouteBuilder gameOverPageRouteBuilder = PageRouteBuilder(
    opaque: false,
    pageBuilder: (BuildContext context, animation, secondaryAnimation) {
      Widget gameOverWidget = GameOverWidget(
        gameProvider: gameProvider,
      );
      return ScaleTransition(
        scale: Tween(begin: 3.0, end: 1.0).animate(animation),
        child: gameOverWidget,
      );
    },
  );
  String result = await Navigator.of(context).push(gameOverPageRouteBuilder);
  // switch on the result
  switch (result) {
    case 'exit':
      await gameProvider.resetGame();
      break;
    case 'ad':
      // show ad
      break;
    default:
  }
}

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({
    super.key,
    required this.gameProvider,
  });

  final GameProvider gameProvider;

  @override
  Widget build(BuildContext context) {
    // check if is single player
    final singlePlayer = gameProvider.gameMode == GameMode.singlePlayer;
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.85),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              singlePlayer
                  ? SinglePlayerResults(
                      gameProvider: gameProvider,
                    )
                  : MultiPlayerResults(
                      gameProvider: gameProvider,
                    ),
              const SizedBox(
                height: 20,
              ),

              // divider
              const Divider(
                color: Colors.black,
                thickness: 0.5,
              ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'exit');
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class SinglePlayerResults extends StatelessWidget {
  const SinglePlayerResults({
    super.key,
    required this.gameProvider,
  });

  final GameProvider gameProvider;

  @override
  Widget build(BuildContext context) {
    String title = getResults(gameProvider.result);

    if (title == Constants.youWin) {
      //TODO play confetti
      //TODO play victory sound
    } else {
      //TODO play lose sound
    }

    // get the computer level
    String computerLevel = gameProvider.computerLevel.name;
    // capitalize the first letter
    computerLevel = computerLevel[0].toUpperCase() + computerLevel.substring(1);
    // get the time
    String time = gameProvider.playTime;
    // get scores
    int score = gameProvider.score;
    int computerScore = gameProvider.computerScore;

    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GameOverItem(
          label: 'Level',
          value: computerLevel,
        ),
        const SizedBox(
          height: 10,
        ),
        GameOverItem(
          label: 'Time',
          value: time,
        ),
        const SizedBox(
          height: 10,
        ),
        GameOverItem(
          label: 'Your Points',
          value: score.toString(),
        ),
        const SizedBox(
          height: 10,
        ),
        GameOverItem(
          label: 'Computer Points',
          value: computerScore.toString(),
        ),
      ],
    );
  }
}

class MultiPlayerResults extends StatelessWidget {
  const MultiPlayerResults({
    super.key,
    required this.gameProvider,
  });

  final GameProvider gameProvider;

  @override
  Widget build(BuildContext context) {
    return Text('Multi Player Results');
  }
}

String getResults(Result result) {
  String finalResult = '';
  switch (result) {
    case Result.win:
      finalResult = Constants.youWin;
      break;
    case Result.lose:
      finalResult = Constants.youLose;
      break;
    case Result.draw:
      finalResult = Constants.draw;
      break;
    case Result.quit:
      finalResult = Constants.quit;
      break;
    default:
      finalResult = '';
  }
  return finalResult;
}

class GameOverItem extends StatelessWidget {
  const GameOverItem({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16.0,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textStyle),
        Text(value, style: textStyle),
      ],
    );
  }
}
