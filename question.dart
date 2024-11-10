class Question {
  String title;
  List<String> optionAns ;
  int point;
  // i modify this for update when choose right or wrong answer
  int gotPoint;

  Question(this.title, this.optionAns, this.point,this.gotPoint);
}

class SingleAnswer extends Question {
  int correctAnswer;

  SingleAnswer(super.title, super.optionAns, super.point,super.gotPoint, this.correctAnswer);

  bool isCorrectAnswer(int selectedAnswer) {
    return selectedAnswer == correctAnswer;
  }
}

class MultipleAnswers extends Question {
  List<int> correctAnswers;

  MultipleAnswers(super.title, super.optionAns, super.point,super.gotPoint, this.correctAnswers);

  bool isCorrectAnswer(List<int> selectedAnswers) {
  
    selectedAnswers.sort();
    correctAnswers.sort();

    return selectedAnswers.length == correctAnswers.length && 
        selectedAnswers.every((answer) => correctAnswers.contains(answer));
  }
}