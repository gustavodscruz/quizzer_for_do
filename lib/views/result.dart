import 'package:flutter/material.dart';
import 'package:quizzer_for_do/widgets/widgets.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  const Results(
      {super.key,
      required this.correct,
      required this.incorrect,
      required this.total});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("${widget.correct}/${widget.total}", style: const TextStyle(fontSize: 25),),
            const SizedBox(
              height: 8,
            ),
            Text(
              "You answered ${widget.correct} answers correctly and ${widget.incorrect} answers incorrectly",
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14,),
            GestureDetector(onTap: () {
              Navigator.pop(context);
            },
            child: blueButton(context: context, label: "Go to Home", buttonWidth: MediaQuery.of(context).size.width/2,))
          ]),
        ),
      ),
    );
  }
}
