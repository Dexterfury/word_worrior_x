import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static const colorizedColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.green,
  ];

  static const colorizedTextStyle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
  );

  // app name
  static const appName = 'Word Worrior';

  // game setup
  static const gameSetup = 'Game Setup';

  // level
  static const level = 'Level';

  // levels discription
  static const levelDes = 'Select the level of Computer';

  // players
  static const numberOfPlayers = 'Number of Players';

  // players discription
  static const playersDes = 'Select the number of players';

  // time mode
  static const timeMode = 'Time Mode';

  // words mode
  static const wordsMode = 'Words Mode';

  // time description
  static const toggleBetweenTW = 'Toggle between Timer and Words';

  // time
  static const time = 'Time';

  // time description
  static const timeDes = 'Select time to play';
  // words
  static const words = 'Words';

  // time description
  static const wordsDes = 'Select the number of words';

  // start
  static const start = 'Start';

  // stop
  static const stop = 'Stop';

  // you win
  static const youWin = 'You Win';

  // you lose
  static const youLose = 'You Lost';

  // draw
  static const draw = 'Draw';

  // you quit
  static const quit = 'Quited';

  // list of levels
  static const List<ComputerLevel> levels = [
    ComputerLevel.easy,
    ComputerLevel.medium,
    ComputerLevel.hard,
  ];

  // list of game time
  static const List<int> gameTimes = [
    30,
    60,
    90,
    120,
    150,
    180,
    210,
    240,
  ];

  // list number of words
  static const List<int> numberOfWords = [
    5,
    10,
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50
  ];
}

// enum for computer level
enum ComputerLevel {
  easy,
  medium,
  hard,
}

// enum for result
enum Result {
  win,
  lose,
  draw,
  quit,
}

// enum for single or multiplayer
enum GameMode {
  singlePlayer,
  multiPlayer,
}

// enum for sign in type
enum SignInType {
  phone,
  email,
  google,
  facebook,
  apple,
}
