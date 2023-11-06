import 'package:flutter/material.dart';
import 'package:quizzer_for_do/services/database.dart';
import 'package:quizzer_for_do/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  const AddQuestion({required this.quizId,super.key});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = DatabaseService();

  TextEditingController _questionTextController = TextEditingController();
  TextEditingController _option1TextController = TextEditingController();
  TextEditingController _option2TextController = TextEditingController();
  TextEditingController _option3TextController = TextEditingController();
  TextEditingController _option4TextController = TextEditingController();

  uploadQuestionData() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, String> quizMap = {
      "question": _questionTextController.text.trim(),
      "option1": _option1TextController.text.trim(),
      "option2": _option2TextController.text.trim(),
      "option3": _option3TextController.text.trim(),
      "option4": _option4TextController.text.trim(),
    };

    await databaseService.addQuestionData(quizMap, widget.quizId).then((value) {
      setState(() {
        _isLoading = false;
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
                        decoration: const InputDecoration(hintText: "Question"),
                        controller: _questionTextController,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            hintText: "Option1(Correct Answer)"),
                        controller: _option1TextController,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextField(
                        decoration: const InputDecoration(hintText: "Option2"),
                        controller: _option2TextController,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextField(
                        decoration: const InputDecoration(hintText: "Option3"),
                        controller: _option3TextController,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextField(
                        decoration: const InputDecoration(hintText: "Option4"),
                        controller: _option4TextController,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: blueButton(
                              context: context,
                              label: "Submit",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36,
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          GestureDetector(
                            onTap: () => uploadQuestionData(),
                            child: blueButton(
                              context: context,
                              label: "Add Question",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
  }
}
