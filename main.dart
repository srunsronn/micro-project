
import 'dart:io';
import 'participant.dart';
import 'quiz.dart';
import 'question.dart';

void main() {
  Quiz quiz = Quiz();

  String? firstName;
  String? lastName;

  print("Enter First Name: ");
  firstName = stdin.readLineSync();

  print("Enter Last Name: ");
  lastName = stdin.readLineSync();

  Participant participant =
      Participant(firstName!, lastName!, 0, DateTime.now());

  quiz.addNewParticipant(participant);

  quiz.addNewQuestion(
      SingleAnswer("What is 2+2?", ["1. 2", "2. 4", "3. 5"], 3,0, 2));
  quiz.addNewQuestion(
      MultipleAnswers("What is what?", ["1. 2", "2. 4", "3. 5"], 1,0, [2, 3]));
  quiz.addNewQuestion(
    MultipleAnswers("Find sum of 1 to 10 and average of sum", 
    ["1. 100","2. 50","3. 55", "4. 5.5"], 5,0, [3,4]));

  int score = 0;
  int points = 0;
  for (var question in quiz.questions) {
    points += question.point;

    print(question.title);
    question.optionAns.forEach((option) => print(option));

    if (question is SingleAnswer) {
      print("Enter your answer: ");
      int selected = int.parse(stdin.readLineSync()!);

      if (question.isCorrectAnswer(selected)) {
        question.gotPoint = question.point;
        participant.updateScore(score);
        // I should add update score for each question 
        //int point = question.point;
        String scores = "${question.gotPoint} / ${question.point}";
        print("score : $scores");
      } else {
        question.gotPoint = 0;
        participant.updateScore(question.gotPoint);

        int point = question.point;
        String scores = "${question.gotPoint} / $point";
        print("score : $scores");
      }

      //participant.totalScore = score;

    } else if (question is MultipleAnswers){
      print("Enter your answer: ");
      List<String> selectedAns = stdin.readLineSync()!.split(RegExp(r",\s*"));
      List<int> selected = selectedAns.map(int.parse).toList();

      if (question.isCorrectAnswer(selected)) {
        question.gotPoint = question.point;
        participant.updateScore(question.gotPoint);

        int point = question.point;
        String scores = "${question.gotPoint} / $point";
        print(scores);
      } else {
        question.gotPoint = 0;
        participant.updateScore(question.gotPoint);

        int point = question.point;
        String scores = "${question.gotPoint} / $point";
        print(scores);
      }
    }
  }
  print(points);
  participant.getOverall(points);

  // we should put the result of this loop in toString for save in text file
  int i=0;
  for(var questions in quiz.questions){
  print("${i+1}. ${questions.title} - Score: ${questions.gotPoint}/${questions.point}");
  i++;
  }

  String toString(){
    return("Participant: ${participant.firstName} ${participant.lastName} \n Time: ${participant.startTime}\n Overall Score: ${participant.getOverall(points)}\n");
  }

  


  File file = File("participantInfo.txt");
  file.writeAsString(toString());
}
