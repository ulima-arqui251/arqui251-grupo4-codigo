import 'package:flutter/material.dart';

class DiscordSignInButton extends StatelessWidget {
  const DiscordSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.discord),
          const SizedBox(width: 8),
          const Text('Inicia sesión con Discord'),
        ],
      ),
      // child: const Text('Discord login'),
    );
  }
}
