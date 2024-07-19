import 'package:flutter/material.dart';
import 'package:food/services/auth/auth_service.dart';
import 'package:food/components/mybutton.dart';
import 'package:food/components/mytextfield.dart';

class SignupPage extends StatelessWidget {
  // Mail and Pw text controllers
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _cpwController = TextEditingController();

  final void Function()? toggle;

  // Signup function
  void signup(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // Create user account if the passwords match
    if (_pwController.text == _cpwController.text) {
      // try login
      try {
        await authService.signUpWithEmailPassword(_mailController.text, _pwController.text);

        // check if the widget is still mounted
        if (!context.mounted) return;
        showDialog(
          
          context: context, 
          builder: (context) => const AlertDialog(
            title: Text("Account created!"),
          )
        );
      }

      // catch any errors
      catch (e) {
        // check if the widget is still mounted
        if (!context.mounted) return;

        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          )
        );
      }
    }

    // Tell the user that the passwords do not match 
    else {
      showDialog(
          context: context, 
          builder: (context) => const AlertDialog(
            title: Text("The passwords do not match"),
          )
      );
    }

    
  }

  SignupPage({super.key, required this.toggle});

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

          MyTextField(hintText: 'Confirm Password', obscureText: true, controller: _cpwController,),

          // Button
          MyButton(btnName: 'Login', onTap: () => signup(context),),

          // Switch to sign up
          Row(
            children: [
              const Text('Already have an account?'),

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