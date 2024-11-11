import 'participant.dart';
import 'question.dart';

class Quiz {
  List<Participant> participants = [];
  List<Question> questions = [];

  void addNewQuestion(Question question) {
    questions.add(question);
  }

  void addNewParticipant(Participant participant) {
    participants.add(participant);
  }
}
