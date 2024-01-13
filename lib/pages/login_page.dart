import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailContoller = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.singInWithEmailandPassword(
          emailContoller.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),

                  Icon(
                    Icons.message,
                    size: 100,
                    color: Colors.grey[800],
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  //Welcome Back Message
                  const Text(
                    'Welcome to ChatChout , you\'ve been missed ',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // email
                  MytextField(
                      hintText: "E-mail",
                      controller: emailContoller,
                      obscureText: false),
                  const SizedBox(
                    height: 10,
                  ),
                  // password
                  MytextField(
                      hintText: "Password",
                      controller: passwordController,
                      obscureText: true),
                  const SizedBox(
                    height: 25,
                  ),
                  //Signin
                  MyButton(onTap: signIn, text: "Sign In"),
                  const SizedBox(
                    height: 50,
                  ),

                  //not a memeber ? registter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member ?"),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Register now ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
