import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return Center(
    child: RichText(
        text: const TextSpan(style: TextStyle(fontSize: 22), children: <TextSpan>[
      TextSpan(
          text: 'Quizzer',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
      TextSpan(
          text: 'ForDo!',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue)),
    ])),
  );
}

Widget blueButton({required BuildContext context, required String label, buttonWidth}){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30),
    ),
    alignment: Alignment.center,
    width: buttonWidth ?? MediaQuery.of(context).size.width - 48,
    child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 18),),
  );
}
