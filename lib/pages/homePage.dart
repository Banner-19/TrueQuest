import 'package:flutter/material.dart';
import 'package:flutter/src/material/slider.dart';
import 'package:truequest/pages/gamePage.dart';
class HomePage extends StatefulWidget{
  
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomeSate();
  }
}
class _HomeSate extends State<HomePage>{
  double? _dheight,_dwidth;
  double _curDif=0;
  final List<String> _difficultytext=["Easy","Medium","Hard"];
  String? _category="General Knowledge";

  _HomeSate();

  @override
  Widget build(BuildContext context) {
    _dheight=MediaQuery.of(context).size.height;
    _dwidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _dwidth!*0.02),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _gameTitle(),
                _selectDifficulty(),
                _selectCategory(),
                _startGameBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _gameTitle(){
    return  Column(
      children: [
         const Text("TrueQuest",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(_difficultytext[_curDif.toInt()],
          style:const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }
  Widget _selectDifficulty(){
    return Slider(
      label: "Difficulty",
      min: 0,
      max: 2,
      divisions: 2,
      value: _curDif, 
      onChanged: (_value){
        setState(() {
          _curDif=_value;
        });
      }
    );
  }
  Widget _selectCategory(){
    List<String> _ctg=["General Knowledge","Entertainment:Film","Entertainment:Music","Entertainment:TV",
    "Entertainment:Video Game","Science & Nature","Science:Computers","Mythology","Sports","Gepgraphy","History",
    "Politics","Arts","Celebrities","Animals","Vehicles","Entertainment:Comics","Science:Gadgets",
    "Entertainment:Anime & Manga","Entertainment:Cartoon & Animation"];
    List<DropdownMenuItem<String>> _items=_ctg.map((e){
      return DropdownMenuItem(
        value: e,
        child:Text(e,
          style:const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400
          ),
        ),  
      );
    }).toList();
    return  DropdownButton(
        value: _category,
        items: _items, 
        onChanged: (_value){
          setState(() {
            _category = _value;
          });
        },
        dropdownColor:const Color.fromRGBO(35, 45, 63, 1.0),
      
    );
  }
  Widget _startGameBtn(){
    return MaterialButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext _context){
          return GamePage(difficulty:_difficultytext[_curDif.toInt()].toLowerCase(),categorys: _category!,);
            }
          )
        );
      },
      color: Colors.blue,
      minWidth: _dwidth!*0.80,
      height: _dheight!*0.10,
      child: const Text("Start Game",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}