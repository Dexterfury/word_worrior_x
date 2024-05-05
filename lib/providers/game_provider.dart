import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:word_generator/word_generator.dart';
import 'package:word_worrior_x/constants.dart';
import 'package:word_worrior_x/utilities/global.dart';

class GameProvider extends ChangeNotifier {
  // word generator
  final _wordGenerator = WordGenerator();

  // my score
  int _score = 0;

  // computer score
  int _computerScore = 0;

  // list of words - empty at the start
  List<String> _words = [
    '',
    '',
  ];

  // play timer
  Timer? _playTimer;

  // computer timer
  Timer? _computerTimer;

  // game duration
  int _gameDuration = 30;

  // seconds
  int _seconds = 0;

  // is playing
  bool _isPlaying = false;

  // is game over
  bool _isGameOver = false;

  // play time
  String _playTime = '00:00';

  // my current word index
  int _myCurrentWordIndex = 0;

  // computer current word index
  int _computerCurrentWordIndex = 0;

  // number of words
  int _numberOfWords = 5;

  // saved number of words
  int _savedNumberOfWords = 5;

  // game mode
  bool _isTimeMode = false;

  // current word
  String _currentTypedWord = '';

  // number of players
  int _numberOfPlayers = 2;

  // results enum
  Result _result = Result.lose;

  // computer level enum
  ComputerLevel _computerLevel = ComputerLevel.easy;

  // game mode enum
  GameMode _gameMode = GameMode.singlePlayer;

  // getters
  int get score => _score;
  int get computerScore => _computerScore;
  List<String> get words => _words;
  bool get isPlaying => _isPlaying;
  bool get isGameOver => _isGameOver;
  String get playTime => _playTime;
  int get myCurrentWordIndex => _myCurrentWordIndex;
  int get computerCurrentWordIndex => _computerCurrentWordIndex;
  int get numberOfWords => _numberOfWords;
  bool get isTimeMode => _isTimeMode;
  String get currentTypedWord => _currentTypedWord;
  int get numberOfPlayers => _numberOfPlayers;
  Result get result => _result;
  ComputerLevel get computerLevel => _computerLevel;
  GameMode get gameMode => _gameMode;
  int get gameDuration => _gameDuration;

  // setters
  void setisPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  // set number of words
  void setisGameOver(bool value) {
    _isGameOver = value;
    notifyListeners();
  }

  // set number of words
  void setPlayTime(String value) {
    _playTime = value;
    notifyListeners();
  }

  // set number of players
  void setMyCurrentWordIndex(int value) {
    _myCurrentWordIndex = value;
    notifyListeners();
  }

  // set number of words
  void setComputerCurrentWordIndex(int value) {
    _computerCurrentWordIndex = value;
    notifyListeners();
  }

  // set computer level
  void setComputerLevel(ComputerLevel value) {
    _computerLevel = value;
    notifyListeners();
  }

  // set number of players
  void setNumberOfPlayers(int value) {
    _numberOfPlayers = value;
    notifyListeners();
  }

  // set game mode
  void setGameMode(GameMode value) {
    _gameMode = value;
    notifyListeners();
  }

  // set is time mode
  void setIsTimeMode(bool value) {
    _isTimeMode = value;
    if (value) {
      _savedNumberOfWords = _numberOfWords;
    } else {
      _numberOfWords = _savedNumberOfWords;
    }
    notifyListeners();
  }

  // set number of words
  void setNumberOfWords(int value) {
    _numberOfWords = value;
    notifyListeners();
  }

  // set game duration
  void setGameDuration(int value) {
    _gameDuration = value;

    // set number of words based on duration - id duration is 30, set number of words to 50
    switch (value) {
      case 30:
        _numberOfWords = 50;
        break;
      case 60:
        _numberOfWords = 100;
        break;
      case 90:
        _numberOfWords = 150;
        break;
      case 120:
        _numberOfWords = 200;
        break;
      case 150:
        _numberOfWords = 250;
        break;
      case 180:
        _numberOfWords = 300;
        break;
      case 210:
        _numberOfWords = 350;
        break;
      case 240:
        _numberOfWords = 400;
        break;
      default:
        _numberOfWords = 50;
    }

    notifyListeners();
  }

  // start game
  void startGame({
    Function()? timeUp,
  }) async {
    // set is playing to true
    _isPlaying = true;
    // reset game
    await resetGame();

    // start timer
    startTimer(
      timeUp: _isTimeMode ? timeUp : null,
    );

    if (gameMode == GameMode.singlePlayer) {
      // generate random words
      await generateRandomWords();
      // start computer timer
      startAITimer(
        winGame: timeUp,
      );
    }
  }

  // reset game
  Future<void> resetGame() async {
    // set the seconds to 0
    _seconds = _isTimeMode ? _gameDuration : 0;
    // set play time
    _playTime = displayGameTime(
      time: _seconds,
      playing: true,
    );
    // set score to 0
    _score = 0;
    // set computer score to 0
    _computerScore = 0;
    // set is game over to false
    _isGameOver = false;

    // set my current word index to 0
    _myCurrentWordIndex = 0;

    // set computer current word index to 0
    _computerCurrentWordIndex = 0;
    notifyListeners();
  }

  // start timer
  void startTimer({
    Function()? timeUp,
  }) {
    _playTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        // check if its time mode and its timeUp
        if (_isTimeMode && _seconds == 0) {
          // stop game
          stopGame();

          // call timeUp function
          timeUp?.call();
        } else if (_score == _numberOfWords) {
          stopGame();
        } else {
          // tick
          tick();
        }
      },
    );
  }

  // time tick
  void tick() {
    if (_isTimeMode) {
      _seconds--;
    } else {
      _seconds++;
    }
    _playTime = displayGameTime(
      time: _seconds,
      playing: true,
    );
    notifyListeners();
  }

  // stop game
  void stopGame({
    bool quit = false,
    bool cancel = false,
  }) {
    // set is playing to false
    _isPlaying = false;
    // cancel play timer
    _playTimer?.cancel();
    // set is game over to true
    _isGameOver = true;
    _words = [
      '',
      '',
    ];

    if (gameMode == GameMode.singlePlayer) {
      // cancel computer timer
      _computerTimer?.cancel();

      if (quit) {
        _result = Result.quit;
      } else if (_score > _computerScore) {
        _result = Result.win;
      } else if (_score == _computerScore) {
        _result = Result.draw;
      } else {
        _result = Result.lose;
      }
      notifyListeners();
    } else {
      // TODO for multiplayer
    }
  }

  void startAITimer({
    Function()? winGame,
  }) {
    // initialize empty AI word
    var aiWord = '';

    // lookup map for level duration
    const levelDuration = {
      ComputerLevel.easy: Duration(milliseconds: 1000),
      ComputerLevel.medium: Duration(milliseconds: 500),
      ComputerLevel.hard: Duration(milliseconds: 250),
    };

    // get the duration based on the current level
    final duration = levelDuration[_computerLevel]!;

    // start computer timer
    _computerTimer = Timer.periodic(
      duration,
      (timer) {
        if (_computerCurrentWordIndex < _words.length) {
          // get the current word
          final currentWord = _words[_computerCurrentWordIndex];
          if (aiWord == currentWord) {
            aiWord = '';
            _computerScore++;
            _computerCurrentWordIndex++;
          } else {
            // add next letter tp ai word
            aiWord += currentWord[aiWord.length];
          }
          notifyListeners();
        } else {
          timer.cancel();
          // stop game
          stopGame();
          // call win game
          winGame?.call();
        }
      },
    );
  }

  // generate random words
  Future<void> generateRandomWords() async {
    _words = _wordGenerator.randomNouns(_numberOfWords);
    log('message: $_words');
    notifyListeners();
  }

  // check word
  bool checkWord(String word) {
    // set the current typed word
    _currentTypedWord = word;
    notifyListeners();

    // check if word is equal to the current word
    if (word == _words[_myCurrentWordIndex]) {
      // clear current typed word
      _currentTypedWord = '';

      // increment score
      _score++;

      // check if the game is over
      if (_myCurrentWordIndex < _numberOfWords - 1) {
        // increment my current word index
        _myCurrentWordIndex++;
      } else {
        _myCurrentWordIndex;
        // stop game
        stopGame();
      }

      notifyListeners();

      return true;
    }

    return false;
  }
}
