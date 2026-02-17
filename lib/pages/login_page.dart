import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  void login(BuildContext context) async{
    final authService = AuthService();
    try{
      await authService.signInWithEmailPassword(_emailController.text,_pwController.text);
    }catch(e) {
      showDialog(context: context, builder:(context) => AlertDialog(
        title: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50),
          //Welcome back message
          Text(
            "Welcome back, you've been missed!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),
          //Email text field
          MyTextField(
            hintText: "Email",
            obSecureText: false,
            controller: _emailController,
          ),
          const SizedBox(height: 10),
          //Password text field
          MyTextField(
            hintText: "Password",
            obSecureText: true,
            controller: _pwController,
          ),
          SizedBox(height: 25),
          //Login button
          MyButton(text: 'Login', onTap:() => login(context)),
          SizedBox(height: 25),
          //Register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not a member? ",style:TextStyle(
                color: Theme.of(context).colorScheme.primary
              )),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Register now",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
