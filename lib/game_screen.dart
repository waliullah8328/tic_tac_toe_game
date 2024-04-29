import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/home_screen.dart';

class GameScreen extends StatefulWidget {
  String player1;
  String player2;
   GameScreen({super.key,required this.player1,required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  late List<List<String>>_board;
  late String _currentPlayer;
  late String _winPlayer;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3,(_)=> ""));
    _currentPlayer = "X";
    _winPlayer = "";
    _gameOver = false;
  }


  // Reset Game
  void _resetGame(){
    setState(() {
      _board = List.generate(3, (_) => List.generate(3,(_)=> ""));
      _currentPlayer = "X";
      _winPlayer = "";
      _gameOver = false;

    });

  }

  void _makeOver(int row,int col){
    if(_board[row][col] != ""  || _gameOver){
      return;
  }
    setState(() {
  _board[row][col] = _currentPlayer;

  // check for winners
  if(_board[row][0]== _currentPlayer && _board[row][1]== _currentPlayer && _board[row][2]== _currentPlayer){

    _winPlayer = _currentPlayer;
    _gameOver = true;
  }

  else if(_board[0][col]== _currentPlayer && _board[1][col]== _currentPlayer && _board[2][col]== _currentPlayer){

  _winPlayer = _currentPlayer;
  _gameOver = true;
  }

  else if(_board[0][0]== _currentPlayer &&
  _board[1][1]== _currentPlayer &&
  _board[2][2]== _currentPlayer){

  _winPlayer = _currentPlayer;
  _gameOver = true;
  }

  // Switch player

  _currentPlayer = _currentPlayer == "X" ? "O" : "X" ;


  // check for tie

  if(!_board.any((row) => row.any((cell) => cell == ""))){
    _gameOver = true;
    _winPlayer =" It's tie";
  }

  if(_winPlayer!= ""){
    AwesomeDialog(
        context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      btnOkText: "Play Again",
      title: _winPlayer == "X"? widget.player1 + " Won!": _winPlayer == "O"?widget.player2 + " Won!":" It's a tie",

      btnOkOnPress: (){
          _resetGame();
      }
    )..show();
  }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323D5B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60,),
            SizedBox(height: 83,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Turn: ",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),

                    Text(_currentPlayer == "X"? widget.player1 + " ($_currentPlayer)"
                      :widget.player2 + " ($_currentPlayer)",

                      style: TextStyle(fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: _currentPlayer == "X"? const Color(0xFFE25041): const Color(0xFF1CBD9E)),),

                  ],
                ),

                const SizedBox(height:20,),

              ],
            ),
            ),
            const SizedBox(height:20,),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5F6B84),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: 9,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder:(context, index) {
                    int row =  index ~/ 3;
                    int col =  index % 3;
                    return GestureDetector(
                      onTap: ()=> _makeOver(row,col),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0E1E3A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(_board[row][col],style: TextStyle(
                          fontSize: 120,
                          fontWeight: FontWeight.bold,
                          color: _board[row][col]=="X"? const Color(0xFFE25041): const Color(0xFF1CBD9E),
                        ),),
                      ),
                    );
                  },
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: _resetGame,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                    child: const Text("Reset Game",style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                    widget.player1 = "";
                    widget.player2 = "";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                    child: const Text("Restart Game",style: TextStyle(fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                  ),
                ),

            ],)
          ],
        ),
      ),
    );
  }
}
