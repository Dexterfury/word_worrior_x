import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_worrior_x/providers/game_provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        // check if the game is playing
        final isPlaying = gameProvider.isPlaying;

        // get the time
        final time = gameProvider.playTime;
        return AppBar(
          title: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            child: Text('WW'),
          ),
          actions: [
            isPlaying
                ? buildTimerDisplay(time)
                : IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.leaderboard),
                  ),
          ],
        );
      },
    );
  }

  Widget buildTimerDisplay(String time) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              const Icon(
                Icons.timer_rounded,
                size: 20,
                color: Colors.white,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
