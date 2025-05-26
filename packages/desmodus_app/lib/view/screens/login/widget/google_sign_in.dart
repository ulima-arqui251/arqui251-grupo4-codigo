import 'package:flutter/material.dart';
import 'package:desmodus_app/view/ui/theme/custom_icons.dart'
    show DesmodusCustomIcons;

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(DesmodusCustomIcons.google),
          const SizedBox(width: 8),
          const Text('Inicia sesión con Google'),
        ],
      ),
    );
  }
}
