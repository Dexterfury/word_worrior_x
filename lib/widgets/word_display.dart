import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_worrior_x/constants.dart';
import 'package:word_worrior_x/providers/game_provider.dart';
import 'package:word_worrior_x/utilities/global.dart';

class WordDisplay extends StatelessWidget {
  const WordDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        final words = gameProvider.words;
        final myCurrentWordIndex = gameProvider.myCurrentWordIndex;
        final currentTypedWord = gameProvider.currentTypedWord;
        if (myCurrentWordIndex < words.length) {
          return words[myCurrentWordIndex].isEmpty
              ? AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      Constants.appName,
                      textStyle: Constants.colorizedTextStyle,
                      colors: Constants.colorizedColors,
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                )
              : Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.deepPurple)),
                  child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: getColoredTextSpans(
                            words[myCurrentWordIndex],
                            currentTypedWord,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 24.0,
                          letterSpacing: 2,
                        ),
                      )

                      // Text(
                      //   words[myCurrentWordIndex],
                      //   style: const TextStyle(
                      //     fontSize: 30.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      ),
                );
        } else {
          return // container for done icon
              Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.green,
            ),
            child: const Icon(
              Icons.done,
              size: 30.0,
              color: Colors.white,
            ),
          );
        }
      },
    );
  }
}
