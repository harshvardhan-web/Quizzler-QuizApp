import 'package:flutter/material.dart';
import 'package:quizzler/game_brain.dart';

void main() {
  runApp(quizzler());
}

quiz_brain quizBrain = quiz_brain();

class quizzler extends StatelessWidget {
  const quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: quizPage(),
        ),
      ),
    );
  }
}


class quizPage extends StatefulWidget {
  const quizPage({Key? key}) : super(key: key);

  @override
  State<quizPage> createState() => _quizzlerState();

}

class _quizzlerState extends State<quizPage> {

  List<Icon> scoreKeeper=[];
  String question="";
  int correct = 0;
  int incorrect = 0;

  String _displayQuestion(){
    setState((){
      question =  quizBrain.getQuestion();
    });
    return question;
  }

  void _checkAnswer(bool userPickedAnswer){
    setState((){
      if(quizBrain.isFinished()==false) {
        if (userPickedAnswer == quizBrain.getAnswer()) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
          correct++;
        }else{
          scoreKeeper.add(Icon(Icons.close, color: Colors.red,));
          incorrect++;
        }
        quizBrain.nextQuestion();
      }else{
        _showAlert(context);
      }
    });
  }

  void _showAlert(BuildContext context){

    showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          title: Text("Quiz Finished"),
          content: Text("You got $correct questions correct."),
          actions: [
            TextButton(onPressed: (){
              quizBrain.reset();
              scoreKeeper = [];
              correct = 0;
              incorrect = 0;
              Navigator.pop(context);
              build(context);
            }, child: Text("Play Again"))
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text("Quizzler",
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Text(
              _displayQuestion(),
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: TextButton(onPressed: (){
              _checkAnswer(true);
            }, child: Text("True", style: TextStyle(color: Colors.white, fontSize: 30),), style: TextButton.styleFrom(
              backgroundColor: Colors.teal,
            ),),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: TextButton(onPressed: (){
              _checkAnswer(false);
            }, child: Text("False", style: TextStyle(color: Colors.white, fontSize: 30),), style: TextButton.styleFrom(
              backgroundColor: Colors.teal,
            ),),
          ),
          Row(
              children: scoreKeeper
          ),
        ],
      ),
    );
  }
}

