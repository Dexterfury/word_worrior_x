import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.logoUrl,
    required this.label,
    required this.onPressed,
  });

  final String logoUrl;
  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(2.0),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(10.0),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logoUrl,
                height: 20,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ));
  }
}
