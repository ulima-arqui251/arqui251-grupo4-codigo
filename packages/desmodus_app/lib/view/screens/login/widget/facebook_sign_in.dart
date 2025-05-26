import 'package:flutter/material.dart';

class FacebookSignInButton extends StatelessWidget {
  const FacebookSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.facebook),
          const SizedBox(width: 8),
          const Text('Inicia sesión con Facebook'),
        ],
      ),
    );
  }
}
