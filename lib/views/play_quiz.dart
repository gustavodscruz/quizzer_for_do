import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzer_for_do/models/question_model.dart';
import 'package:quizzer_for_do/services/database.dart';
import 'package:quizzer_for_do/views/result.dart';
import 'package:quizzer_for_do/widgets/quiz_play_widgets.dart';
import 'package:quizzer_for_do/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;

  const PlayQuiz({super.key, required this.quizId});

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  final DatabaseService databaseService = DatabaseService();
  QuerySnapshot? questionSnapshot;

  QuestionModel getQuestionModelFromDataSnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = QuestionModel();
    Map<String, dynamic> data =
        questionSnapshot.data()! as Map<String, dynamic>;
    questionModel.question = data["question"];

    List<String> options = [
      data["option1"],
      data["option2"],
      data["option3"],
      data["option4"]
    ];

    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = data["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    // TODO: implement initState
    databaseService.getQuizData(widget.quizId).then((value) {
      questionSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionSnapshot!.docs.length;
      print("$total this is total");
      setState(() {});
    });
    print("${widget.quizId}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
            questionSnapshot?.docs == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: questionSnapshot?.docs.length,
                    itemBuilder: ((context, index) {
                      return QuizPlayTile(
                          questionModel: getQuestionModelFromDataSnapshot(
                              questionSnapshot!.docs[index]),
                          index: index);
                    }))
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Results(correct: _correct, incorrect: _incorrect, total: total)));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  const QuizPlayTile(
      {super.key, required this.questionModel, required this.index});

  @override
  State<QuizPlayTile> createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Q${widget.index + 1} ${widget.questionModel.question}", style: const TextStyle(fontSize: 17, color: Colors.black87),),
      const SizedBox(
        height: 12,
      ),
      GestureDetector(
        onTap: () {
          if (!widget.questionModel.answered) {
            if (widget.questionModel.option1 ==
                widget.questionModel.correctOption) {
              optionSelected = widget.questionModel.option1;
              widget.questionModel.answered = true;
              _correct = _correct + 1;
              _notAttempted = _notAttempted - 1;
              setState(() {});
            } else {
              optionSelected = widget.questionModel.option1;
              widget.questionModel.answered = true;
              _incorrect = _incorrect + 1;
              _notAttempted = _notAttempted - 1;
              setState(() {});
            }
          }
        },
        child: OptionTile(
            option: "A",
            description: widget.questionModel.option1,
            correctAnswer: widget.questionModel.correctOption,
            optionSelected: optionSelected),
      ),
      GestureDetector(
        onTap: () {
          if (!widget.questionModel.answered) {
            if (widget.questionModel.option2 ==
                widget.questionModel.correctOption) {
              optionSelected = widget.questionModel.option2;
              widget.questionModel.answered = true;
              _correct = _correct + 1;
              _notAttempted = _notAttempted - 1;
              setState(() {});
            } else {
              optionSelected = widget.questionModel.option2;
              widget.questionModel.answered = true;
              _incorrect = _incorrect + 1;
              _notAttempted = _notAttempted - 1;
              setState(() {});
            }
          }
        },
        child: OptionTile(
            option: "B",
            description: widget.questionModel.option2,
            correctAnswer: widget.questionModel.correctOption,
            optionSelected: optionSelected),
      ),
      GestureDetector(
        onTap: () {
          if (!widget.questionModel.answered) {
            if (widget.questionModel.option3 ==
                widget.questionModel.correctOption) {
              optionSelected = widget.questionModel.option3;
              widget.questionModel.answered = true;
              _correct = _correct + 1;
              _notAttempted = _notAttempted - 1;
              setState(() {});
            } else {
              optionSelected = widget.questionModel.option3;
              widget.questionModel.answered = true;
              _incorrect = _incorrect + 1;
              _notAttempted = _notAttempted - 1;
              setState(() {});
            }
          }
        },
        child: OptionTile(
            option: "C",
            description: widget.questionModel.option3,
            correctAnswer: widget.questionModel.correctOption,
            optionSelected: optionSelected),
      ),
      GestureDetector(
        onTap: () {
          if (!widget.questionModel.answered) {
            if (widget.questionModel.option4 ==
                widget.questionModel.correctOption) {
              optionSelected = widget.questionModel.option4;
              widget.questionModel.answered = true;
              _correct = _correct + 1;
              _notAttempted = _notAttempted - 1;
              print("${widget.questionModel.correctOption}}");
              setState(() {});
            } else {
              optionSelected = widget.questionModel.option4;
              widget.questionModel.answered = true;
              _incorrect = _incorrect + 1;
              _notAttempted = _notAttempted - 1;
              setState(() {});
            }
          }
        },
        child: OptionTile(
            option: "D",
            description: widget.questionModel.option4,
            correctAnswer: widget.questionModel.correctOption,
            optionSelected: optionSelected),
      ),
      const SizedBox(
        height: 20,
      )
    ]);
  }
}
