import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((onError){
          print(onError.toString());
        });
  }

  Future<void> addQuestionData(Map<String, dynamic> questionData, String quizId)async{
      await FirebaseFirestore.instance
          .collection("Quiz")
          .doc(quizId)
          .collection("QNA")
          .add(questionData)
          .catchError((onError){
            print(onError.toString());
          });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getQuizData(){
    return FirebaseFirestore.instance
        .collection("Quiz")
        .snapshots();
  }
}
