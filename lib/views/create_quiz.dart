import 'package:flutter/material.dart';
import 'package:quizzer_for_do/services/database.dart';
import 'package:quizzer_for_do/views/addquestion.dart';
import 'package:quizzer_for_do/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  late String quizImageUrl, quizTitle, quizDescription, quizId;
  bool _isLoading = false;
  TextEditingController _quizImageUrlController = TextEditingController();
  TextEditingController _quizTitleController = TextEditingController();
  TextEditingController _quizDescriptionController = TextEditingController();


  DatabaseService databaseService = DatabaseService();
  createQuizOnline() async {
    
      quizId = randomAlphaNumeric(16);

      setState(() {
        _isLoading = true;
      });

      Map<String, String> quizMap = {
        "quizImageUrl": _quizImageUrlController.text.trim(),
        "quizTitle": _quizTitleController.text.trim(),
        "quizDescription": _quizDescriptionController.text.trim()
      };

      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddQuestion(quizId: quizId),
              ));
        });
      });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 6,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          hintText: "Quiz Image Url(Optional)"),
                      controller: _quizImageUrlController,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextField(
                      decoration: const InputDecoration(hintText: "Quiz Title"),
                      controller: _quizTitleController,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(hintText: "Quiz Description"),
                      controller: _quizDescriptionController,
                    ),
                    const Spacer(),
                    GestureDetector(onTap:() => createQuizOnline(), child: blueButton(context: context, label: "Create Quiz")),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
