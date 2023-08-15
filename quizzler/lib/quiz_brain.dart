import 'question.dart';

class QuizBrain {

  int _questionNumber = 0;

  final List<Question> _questionBank = [
    Question('มินนี่น่ารักที่สุดในโลก(ของเมล)', true),
    Question('เมลเป็นลูกรักของมินนี่', true),
    Question('มินนี่ไม่คิดถึงเมล', false),
    Question('มินนี่ชอบ 🌻', true),
    Question('Mail 💖 Minnie', true),
    Question('มินนี่ชอบสีเขียว', true),
    Question('มินนี่เกิด 9 มิ.ย. 2539', true),
    Question('มินนี่ชอบวง NCT', true),
    Question('มินนี่ชอบ พี่ john, mark lee และคนอื่นๆ🤣', true),
    Question('มินนี่คือคนพิเศษ(ของเมล)', true),
  ];

  bool isFinished(){
    return (_questionNumber == _questionBank.length - 1);
  }

  void reset(){
    _questionNumber = 0;
  }

  void nextQuestion(){
    if (_questionNumber < _questionBank.length - 1){
      _questionNumber++;
    }
  }

  String getQuestionText(){
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer(){
    return _questionBank[_questionNumber].questionAnswer;
  }

  int getNumberOfQuestion(){
    return _questionBank.length;
  }


}