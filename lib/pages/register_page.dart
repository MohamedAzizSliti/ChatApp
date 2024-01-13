import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailContoller = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  void signUp() async {
    if (passwordController.text != confirmpasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password do not match ")));
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.registerNewUser(
          emailContoller.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print(e.toString());
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
                    "Let's Create an account for you !! ",
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
                    height: 10,
                  ),
                  // password
                  MytextField(
                      hintText: "Confirm Password",
                      controller: confirmpasswordController,
                      obscureText: true),
                  const SizedBox(
                    height: 25,
                  ),
                  //Signin
                  MyButton(onTap: signUp, text: "Sign In"),
                  const SizedBox(
                    height: 50,
                  ),

                  //not a memeber ? registter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already a member ?"),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Login now ",
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
