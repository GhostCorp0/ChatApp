import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  final void Function()? onTap;
  RegisterPage({super.key, this.onTap});

  void register(BuildContext context) {
    //get auth service
    final _auth = AuthService();
    if(_pwController.text == _confirmPwController.text){
      try{
        _auth.signUpWithEmailPassword(_emailController.text,_pwController.text);
      }catch(e) {
        showDialog(context: context, builder:(context) => AlertDialog(
          title: Text(e.toString()),
        ));
      }
    }else {
      showDialog(context: context, builder:(context) => AlertDialog(
        title: Text("Passwords don't match!"),
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
            "Let's create an account for you",
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
          const SizedBox(height: 10),
          MyTextField(
            hintText: "Confirm password",
            obSecureText: true,
            controller: _confirmPwController,
          ),
          SizedBox(height: 25),
          //Login button
          MyButton(text: 'Register', onTap:() => register(context)),
          SizedBox(height: 25),
          //Register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account? ",style:TextStyle(
                  color: Theme.of(context).colorScheme.primary
              )),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login now",
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
