import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;

  const OptionTile(
      {super.key,
      required this.option,
      required this.description,
      required this.correctAnswer,
      required this.optionSelected});

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
              border: Border.all(
                  color: widget.optionSelected == widget.description
                      ? widget.correctAnswer == widget.optionSelected
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7)
                      : Colors.grey, width: 1.4),
              borderRadius: BorderRadius.circular(30)),
              alignment: Alignment.center,
          child: Text(
            widget.option,
            style: const TextStyle(color: Colors.black54, fontSize: 17),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          widget.description,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        )
      ]),
    );
  }
}
