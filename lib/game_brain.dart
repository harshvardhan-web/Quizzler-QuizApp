import 'main.dart';
import 'package:quizzler/question.dart';

class quiz_brain{
  int _questionNumber = 0;
  List<Question> _questionBank = [
    Question("Some Cats are allergic to Humans", true),
    Question("A Dog can climb up the stairs but not down", false),
    Question("Modi is the Prime Minister of India", true),
    Question("It's impossible to lick your elbow", true),
    Question("Shah Jahan cut hands of all the workers", false),
    Question("Napolean Bonaparte cut hjs own hand to extend his life line", true),
    Question("Walking on grass will help remove your glasses", true),
    Question("It's necessary to have friends", false)
  ];

  void reset(){
    _questionNumber = 0;
  }

  bool isFinished(){
    if(_questionNumber <= _questionBank.length-1){
      return false;
    }else{
      return true;
    }
  }

  void nextQuestion(){
    if(!isFinished()){
      _questionNumber++;
    }
  }

  String getQuestion(){
    return _questionBank[_questionNumber].questionText;
  }

  bool getAnswer(){
    return _questionBank[_questionNumber].answerText;
  }
}