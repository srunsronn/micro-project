class Participant {
  String firstName;
  String lastName;
  int totalScore =0;
  DateTime startTime = DateTime.now();

  Participant(this.firstName, this.lastName, this.totalScore, this.startTime);

  void updateScore (int score){
    totalScore +=score;
  }

  void getOverall(int points) {
    print("Overall: $totalScore / $points");
  }
  
  
}