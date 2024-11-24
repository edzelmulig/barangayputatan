import 'package:flutter/material.dart';
import 'package:myapp/ui/widgets/buttons/custom_button.dart';
import 'package:myapp/ui/widgets/images/custom_image_display.dart';
import 'package:myapp/ui/widgets/input_fields/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers and Focus Nodes
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  // Form Key
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  // FUNCTION TO AUTHENTICATE LOGIN
  Future<void> _login() async {
    // CONTROLLER
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    debugPrint("email: $email");
    debugPrint("password: $password");
    

    // // AUTHENTICATE ADMIN ACCOUNT
    // await AuthService().signIn(
    //   context: context,
    //   username: username,
    //   password: password,
    //   userType: 'admin',
    // );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          // App Logo
          Center(
            child: CustomImageDisplay(
              imageSource: "lib/ui/assets/barangay_putatan_icon.png",
              imageHeight: screenHeight * 0.4,
              imageWidth: screenWidth * 0.4,
            ),
          ),

          // Form
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Email Text Field
                _EmailTextField(
                  controller: emailController,
                  currentFocusNode: emailFocusNode,
                  nextFocusNode: passwordFocusNode,
                ),

                const SizedBox(height: 8),

                // Password Text Field
                _PasswordTextField(
                  controller: passwordController,
                  currentFocusNode: passwordFocusNode,
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Login Button
          _LoginButton(onPressed: _login),
          // Forgot Password
        ],
      ),
    );
  }
}

// Private Email Text Field Widget
class _EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;

  const _EmailTextField({
    required this.controller,
    required this.currentFocusNode,
    required this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: CustomTextField(
        controller: controller,
        currentFocusNode: currentFocusNode,
        nextFocusNode: nextFocusNode,
        inputFormatters: null,
        validator: (value) {
          if (value!.isEmpty) {
            return "Email or Phone number cannot be empty";
          }
          return null;
        },
        isPassword: false,
        hintText: "Email or Phone number",
        minLines: 1,
        maxLines: 1,
        prefixIcon: const Icon(Icons.email_rounded),
      ),
    );
  }
}

// Private Password Text Field Widget
class _PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode currentFocusNode;

  const _PasswordTextField({
    required this.controller,
    required this.currentFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: CustomTextField(
        controller: controller,
        currentFocusNode: currentFocusNode,
        nextFocusNode: null,
        inputFormatters: null,
        validator: (value) {
          if (value!.isEmpty) {
            return "Password is required";
          }
          return null;
        },
        isPassword: true,
        hintText: "Password",
        minLines: 1,
        maxLines: 1,
        prefixIcon: const Icon(Icons.lock_rounded),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _LoginButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: CustomButton(
        buttonLabel: "Sign In",
        onPressed: onPressed,
        buttonColor: const Color(0xFF002091),
        buttonHeight: 50.0,
        fontWeight: FontWeight.bold,
        fontSize: 13,
        fontColor: Colors.white,
        borderRadius: 8,
      ),
    );
  }
}
