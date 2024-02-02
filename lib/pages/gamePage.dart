import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truequest/providers/gamePageProvider.dart';

class GamePage extends StatelessWidget{
  double? _dheight,_dwidth;
  final String difficulty;
  final String categorys;
  GamePageProvider? _pageProvider;

  GamePage({required this.difficulty,required this.categorys});

  @override
  Widget build(BuildContext context) {
    _dheight=MediaQuery.sizeOf(context).height;
    _dwidth= MediaQuery.sizeOf(context).width;
    return ChangeNotifierProvider(
      create: (_context)=> GamePageProvider(context: _context,difficultylvl: difficulty,selectedcategory: categorys),
      child: _buildUI(),
    );
  }

  Widget _buildUI(){
    return Builder(
      builder: (_context) {
        _pageProvider=_context.watch<GamePageProvider>();
        if(_pageProvider!.ques!=null){
          return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: _dheight!*0.05),
              child: _gameUI(),
            ),
          ),
        );
        }
        else{
          return const Center(child: CircularProgressIndicator(color: Colors.white,));
        }
      }
    );
  }

  Widget _gameUI(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _question(),
        Column(
          children: [
            _trueBtn(),
            SizedBox(height: _dheight!*0.02,),
            _falseBtn(),
          ],
        )
      ],
    );
  }

  Widget _question(){
    return  Text(
      _pageProvider!.getCurQuesTxt(),
      style:const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _trueBtn(){
    return MaterialButton(onPressed: (){
      _pageProvider?.ansQues("True");
      },
      color: Colors.green,
      minWidth: _dwidth!*0.80,
      height: _dheight!*0.10,
      child: const Text("True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
        ),
    );
  }
  Widget _falseBtn(){
    return MaterialButton(onPressed: (){
      _pageProvider?.ansQues("False");
      },
      color: Colors.red,
      minWidth: _dwidth!*0.80,
      height: _dheight!*0.10,
      child: const Text("False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
        ),
    );
  }
}