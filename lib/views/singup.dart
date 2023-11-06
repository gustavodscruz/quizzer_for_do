import 'package:flutter/material.dart';
import 'package:quizzer_for_do/helper/functions.dart';
import 'package:quizzer_for_do/services/auth.dart';
import 'package:quizzer_for_do/views/singin.dart';
import 'package:quizzer_for_do/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService authService = AuthService();
  bool _isLoading = false;
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  signUp() async {
    setState(() {
      _isLoading = true;
    });
    await authService
        .signUpWithEmailAndPassword(_emailTextController.text.trim(),
            _passwordTextController.text.trim())
        .then((value) {
      if (value != null) {
        setState(() {
          _isLoading = false;
        });
        HelperFunctions.saveUserLoggedInSharedPreference(isUserLoggedIn: true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
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
      body: _isLoading
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
                      controller: _nameTextController,
                      decoration: const InputDecoration(hintText: "Name"),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextField(
                      controller: _emailTextController,
                      decoration: const InputDecoration(hintText: "Email"),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextField(
                      controller: _passwordTextController,
                      decoration: const InputDecoration(hintText: "Password"),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () => signUp(),
                      child: blueButton(context: context, label: "Sign Up"),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        const Text("Already have an account?",
                            style: TextStyle(fontSize: 15)),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()));
                            },
                            child: const Text(
                              " Sign In",
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
