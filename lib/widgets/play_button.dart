import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(2.0),
            backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(10.0),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          onPressed: onTap,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ));
  }
}
