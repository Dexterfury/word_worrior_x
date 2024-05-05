import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_worrior_x/constants.dart';
import 'package:word_worrior_x/providers/game_provider.dart';
import 'package:word_worrior_x/widgets/game_over.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({super.key});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  // focus node
  final FocusNode _focusNode = FocusNode();

  // text controller
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  // always request focus when the screen is loaded
  void requestFocus() {
    // make sure widget is built before requesting focus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        // check if the game is playing
        final isPlaying = gameProvider.isPlaying;
        return TextField(
          focusNode: _focusNode,
          controller: _textController,
          decoration: const InputDecoration(
            hintText: 'Enter a word',
            border: OutlineInputBorder(),
            labelText: 'Enter a word',
            //enabled: gameProvider.isPlaying,
          ),
          onChanged: (value) async {
            if (isPlaying) {
              bool isDone = gameProvider.checkWord(value);

              if (isDone) {
                _textController.clear();
              }

              if (gameProvider.isGameOver) {
                await Future.delayed(const Duration(milliseconds: 200))
                    .whenComplete(() {
                  if (gameProvider.gameMode == GameMode.singlePlayer) {
                    gameOver(
                      context: context,
                      gameProvider: gameProvider,
                    );
                  } else {
                    // TODO do the multi player methods
                  }
                });
              }
            }
          },
        );
      },
    );
  }
}
