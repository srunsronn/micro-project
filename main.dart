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

  Participant participant = Participant(firstName!, lastName!, 0, DateTime.now());

  quiz.addNewParticipant(participant);

  quiz.addNewQuestion(
      SingleAnswer("What is 2+2?", ["1. 2", "2. 4", "3. 5"], 3, 2));
  quiz.addNewQuestion(
      MultipleAnswers("What is what?", ["1. 2", "2. 4", "3. 5"], 1, [2, 3]));

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
        score = question.point;
        participant.updateScore(score);

        int point = question.point;
        String scores = "$score / $point";
        print(scores);
      } else {
        score = 0;
        participant.updateScore(score);

        int point = question.point;
        String scores = "$score / $point";
        print(scores);
      }

      participant.totalScore = score;
    } else if (question is MultipleAnswers) {
      print("Enter your answer: ");
      List<String> selectedAns = stdin.readLineSync()!.split(RegExp(r",\s*"));
      List<int> selected = selectedAns.map(int.parse).toList();

      if (question.isCorrectAnswer(selected)) {
        score = question.point;
        participant.updateScore(score);

        int point = question.point;
        String scores = "$score / $point";
        print(scores);
      } else {
        score = 0;
        participant.updateScore(score);

        int point = question.point;
        String scores = "$score / $point";
        print(scores);
      }
    }
  }
  print(points);
  participant.getOverall(points);

  print(participant.startTime);
  
}
