import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRgeister extends StatefulWidget {
  const LoginOrRgeister({super.key});

  @override
  State<LoginOrRgeister> createState() => _LoginOrRgeisterState();
}

class _LoginOrRgeisterState extends State<LoginOrRgeister> {
  bool showLoginPage = true;
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage
        ? LoginPage(onTap: togglePages)
        : RegisterPage(onTap: togglePages);
  }
}
