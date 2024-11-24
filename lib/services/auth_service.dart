import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/ui/screens/login_screen.dart';
import 'package:myapp/ui/widgets/dialogs/custom_alert_dialog.dart';

class AuthService {

  // FORGOT PASSWORD
  Future passwordReset(BuildContext context, GlobalKey<FormState> formKey,
      TextEditingController forgotEmailController) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: forgotEmailController.text.trim(),
        );

        debugPrint("****** AUTH SUCCESS");

        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              message:
                  "A password reset email has been sent to your e-mail address.",
              backGroundColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        debugPrint('Error: ${e.message}');
      }
    }
  }
}
