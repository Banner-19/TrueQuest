import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier{
  final Dio _dio=Dio();
  BuildContext context;
  List? ques;
  int _quesCnt=0;
  int _score=0;
  final String difficultylvl;
  final String selectedcategory;
  Map<String,int> Category={
    "General Knowledge":9,"Entertainment:Film":11,"Entertainment:Music":12,"Entertainment:TV":14,
    "Entertainment:Video Game":15,"Science & Nature":17,"Science:Computers":18,"Science:Mathematics":19,
    "Mythology":20,"Sports":21,"Gepgraphy":22,"History":23,"Politics":24,"Arts":25,"Celebrities":26,"Animals":27,
    "Vehicles":28,"Entertainment:Comics":29,"Science:Gadgets":30,"Entertainment:Anime & Manga":31,
    "Entertainment:Cartoon & Animation":32
  };

  GamePageProvider({required this.context,required this.difficultylvl,required this.selectedcategory}){
    _dio.options.baseUrl='https://opentdb.com/api.php';
    _getQuestion();
  }

  Future<void> _getQuestion() async{
    var _response = await _dio.get(
      '',
      queryParameters: {
        'amount':10,
        'category':Category[selectedcategory],
        'type':'boolean',
        'difficulty':difficultylvl
      }
    );
    var _data=jsonDecode(_response.toString());
    ques=_data['results'];
    notifyListeners();
  }
  String getCurQuesTxt(){
    return ques![_quesCnt]['question'];
  }
  void ansQues(String _ans)async{
    bool isCorrect=ques![_quesCnt]['correct_answer']==_ans;
    _quesCnt++;
    showDialog(context: context, 
      builder: (BuildContext _context){
        return  AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          icon: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_rounded,
            color: Colors.white,
          ),
        );
      }
    );//showDialog
    if(isCorrect==true){
      _score++;
    }
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    if(_quesCnt==10){
      endGame();
    }
    else{
      notifyListeners();
    }
  }

  Future<void> endGame()async{
    showDialog(context: context, 
      builder: (BuildContext _context){
        return  AlertDialog(
          backgroundColor: Colors.blue,
          title:const Text('End Game :)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Text("Score ${_score}/10"),
        );
      }
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}