import 'package:flutter/material.dart';
import 'package:word_worrior_x/widgets/my_app_bar.dart';
import 'package:word_worrior_x/widgets/my_textfield.dart';
import 'package:word_worrior_x/widgets/points_display.dart';
import 'package:word_worrior_x/widgets/start_stop_button.dart';
import 'package:word_worrior_x/widgets/word_display.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            8.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              PointsDisply(),

              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    WordDisplay(),
                    // Add a SizedBox with height 20.0
                    SizedBox(height: 20.0),

                    StartStopButton(),
                  ],
                ),
              ),

              // textfield
              MyTextField(),
            ],
          ),
        ),
      ),
    );
  }
}
