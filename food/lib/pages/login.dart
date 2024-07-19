import 'package:flutter/material.dart';
import 'package:food/services/auth/auth_service.dart';
import 'package:food/components/mybutton.dart';
import 'package:food/components/mytextfield.dart';

class LoginPage extends StatelessWidget {
  // Mail and Pw text controllers
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  final void Function()? toggle;

  LoginPage({super.key, required this.toggle});

  // Login function
  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(_mailController.text, _pwController.text);
    }

    // catch any errors
    catch (e) {
      // check if the widget is still mounted
      if (!context.mounted) return;

      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo and Brand name
          const Text('Brand Name'),

          // Mail and Pw textfields
          MyTextField(hintText: 'Mail', obscureText: false, controller: _mailController,),

          MyTextField(hintText: 'Password', obscureText: true, controller: _pwController,),

          // Button
          MyButton(btnName: 'Login', onTap: () => login(context),),

          // Switch to sign in
          Row(
            children: [
              const Text("Don't have an account?"),

              GestureDetector(
                onTap: toggle,
                child: const Text('Sign in', style: TextStyle(decoration: TextDecoration.underline))
              )
            ],
          )
        ],
      ),
    );
  }
}