import 'package:flutter/material.dart';
import 'package:quizzer_for_do/helper/functions.dart';
import 'package:quizzer_for_do/services/auth.dart';
import 'package:quizzer_for_do/views/home.dart';
import 'package:quizzer_for_do/views/singup.dart';
import 'package:quizzer_for_do/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  AuthService authService = AuthService();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  singIn() async {
    setState(() {
      isLoading = true;
    });
    await authService
        .signInEmailAndPassword(_emailTextController.text.trim(),
            _passwordTextController.text.trim())
        .then((value) {
      if (value != null) {
        setState(() {
          isLoading = false;
        });
        HelperFunctions.saveUserLoggedInSharedPreference(isUserLoggedIn: true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(),
                    TextField(
                      decoration: const InputDecoration(hintText: "Email"),
                      controller: _emailTextController,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextField(
                      decoration: const InputDecoration(hintText: "Password"),
                      controller: _passwordTextController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        singIn();
                      },
                      child: blueButton(context: context, label: "Sign In"),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        const Text("Don't have an account?",
                            style: TextStyle(fontSize: 15)),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            },
                            child: const Text(
                              " Sign Up",
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
