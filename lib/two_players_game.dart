import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'point.dart';

enum GameState {
  Blank,
  Black,
  White,
}

class TwoPlayerGame extends StatefulWidget {
  @override
  _TwoPlayerGameState createState() => _TwoPlayerGameState();
}

class _TwoPlayerGameState extends State<TwoPlayerGame> with SingleTickerProviderStateMixin {
  var activePlayer = GameState.Black;
  var winner = GameState.Blank;
  var boardState = List<List<GameState>>.generate(
    15,
    (i) => List<GameState>.generate(
      15,
      (j) => GameState.Blank,
    ),
  );
  double _boardOpacity = 1.0;
  bool _showWinnerDisplay = false;
  int _moveCount = 0;
  Animation<double> _boardAnimation;
  AnimationController _boardController;
  int _blackWins = 0;
  int _whiteWins = 0;
  int _draws = 0;
  bool _showScore = false;

  @override
  void initState() {
    _boardController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _boardAnimation = Tween(begin: 1.0, end: 0.0).animate(_boardController)
      ..addListener(() {
        setState(() {
          _boardOpacity = _boardAnimation.value;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(boardState.length);
    return Scaffold(
      backgroundColor: Color(0xFF607D8B),
      drawer: _drawer(context),
      appBar: AppBar(
        title: Center(
          child: RichText(
            text: TextSpan(
                children: [
                  TextSpan(
                    text: 'GOMOKU ',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
            ),
          ),
        ),
        backgroundColor: Color(0xFF607D8B),
      ),
      body: SingleChildScrollView(
        physics: !_showScore ? NeverScrollableScrollPhysics() : PageScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*.08,
              child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text(
                          'Show Score',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),
                        ),

                       Switch(
                         value: _showScore,
                         onChanged: (score){
                           setState(() {
                             _showScore = score;
                           });
                         },
                       ),
                     ],
                   ),
            ),

            SizedBox(height: _showScore ? 0 : 40,),

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.59,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12,width: _showWinnerDisplay ? 0 : 3)
              ),
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: _showWinnerDisplay
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      winnerDisplay,
                      FloatingActionButton(
                        child: Icon(Icons.cached,color: Colors.white,),
                        backgroundColor: Colors.black54,
                        elevation: 0,
                        onPressed: ()=> reset(),
                      )
                    ],
                  )
                  : board,
            ),

          Container(
            height: MediaQuery.of(context).size.height*.25,
            child: _showScore ? scoreBoard : Column(),
          )


          ],
        ),
      )
    );
  }

  Widget get scoreBoard => Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        blackScore,
        drawScore,
        whiteScore,
      ],
    ),
  );

  Widget get blackScore => Column(
    children: <Widget>[
      Chip(
        label: FittedBox(
          child: Text(
            'Black',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black87,
      ),

      Chip(
        label: FittedBox(
          child: Text(
            '$_blackWins',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    ],
  );

  Widget get whiteScore => Column(
    children: <Widget>[
      Chip(
        label: FittedBox(
          child: Text(
            'White',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black87,
      ),

      Chip(
        label: FittedBox(
          child: Text(
            '$_whiteWins',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20.0
            ),
          ),
        ),
      )
    ],
  );

  Widget get drawScore => Column(
    children: <Widget>[
      Chip(
        label: FittedBox(
          child: Text(
            'Draw',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black87,
      ),
      Chip(
        label: FittedBox(
          child: Text(
            '$_draws',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.0),
          ),
        ),
      )
    ],
  );

  Widget get board => Opacity(
    opacity: _boardOpacity,
    child: AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        color: Colors.black12,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: boardState.length,
            childAspectRatio: 1.0,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          itemCount: 225,
          itemBuilder: (context, index) {
            int row = index ~/ 15;
            int col = index % 15;
            return gameButton(row, col);
          },
        ),
      ),
    ),
  );

  Widget get winnerDisplay => Visibility(
    visible: _showWinnerDisplay,
    child: Opacity(
      opacity: 1.0 - _boardOpacity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           winner == GameState.Black
                ? Text(
                    'Black ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                      fontSize: 56.0,
                    ),
                  )
                : winner == GameState.White
                    ? Text(
                    'White ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                      fontSize: 56.0,
                    ),
                  )
                    : Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('No WINNER'),
                      ),

          Text(
            (winner == GameState.Blank) ? "It's a draw!" : 'win!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black38,
              fontSize: 56.0,
            ),
          ),
          // if (winner != GameState.Blank)
          //   Padding(
          //     padding: const EdgeInsets.only(left: 8.0),
          //     child: Text('No WINNER'),
          //   ),
        ],
      ),
    ),
  );

  Widget gameButton(int row, int col) {
    return GestureDetector(
      onTap:
          (boardState[row][col] == GameState.Blank && winner == GameState.Blank)
              ? () {
                  _moveCount++;
                  boardState[row][col] = activePlayer;
                  checkWinningCondition(row, col, activePlayer);
                  toggleActivePlayer();
                  setState(() {});
                }
              : null,
      child: Container(
        color: Colors.black38,
        child: Center(
          child: gamePiece(row, col),
        ),
      ),
    );
  }

  Drawer _drawer(BuildContext context){
    return Drawer(
      child: SafeArea(
        child: Container(
          color: Color(0xFF607D8B),
          child: Column(
            children: <Widget>[
              Divider(),
              GestureDetector(
                onTap: () => reset(),
                child: ListTile(
                  title: Text(
                    'Restart',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                  leading: Icon(Icons.cached,color: Colors.white,size: 30,),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  title: Text(
                    'Home Page',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                  leading: Icon(Icons.exit_to_app,color: Colors.white,size: 30,),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: (){},
                child: ListTile(
                  title: Text(
                    'How To Play',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                  leading: Icon(Icons.info_outline,color: Colors.white,size: 30,),
                ),
              ),
              Divider(),

            ],
          ),
        ),
      ),
    );
  }

  void reset() {
    for (int i = 0; i < 15; i++) {
      for (int j = 0; j < 15; j++) {
        boardState[i][j] = GameState.Blank;
      }
    }
    activePlayer = GameState.Black;
    winner = GameState.Blank;
    _moveCount = 0;
    setState(() {
      _showWinnerDisplay = false;
    });
    _boardController.reverse();
  }

  void checkWinningCondition(int row, int col, GameState gameState) {
    if (_moveCount < 5) return;

    if (boardState[row][col] == gameState) {
      if (countConsecutiveStones(row, col, 1, -1) +
              countConsecutiveStones(row, col, -1, 1) >=
          4) {
        setWinner(gameState);

        return;
      }
      if (countConsecutiveStones(row, col, -1, -1) +
              countConsecutiveStones(row, col, 1, 1) >=
          4) {
        setWinner(gameState);

        return;
      }
      // Horizontal
      if (countConsecutiveStones(row, col, 0, 1) +
              countConsecutiveStones(row, col, 0, -1) >=
          4) {
        setWinner(gameState);

        return;
      }
      // Vertical
      if (countConsecutiveStones(row, col, 1, 0) +
              countConsecutiveStones(row, col, -1, 0) >=
          4) {
        setWinner(gameState);

        return;
      }
    }
    if (_moveCount == 225) {
      print('Draw');
      setWinner(GameState.Blank);
      return;
    }
  }

  bool inBounds(int index) {
    return index >= 0 && index < boardState.length;
  }

  int countConsecutiveStones(int row, int col, int rowIncrement, int colIncrement) {
    int count = 0;
    GameState index = boardState[row][col];
    for (int i = 1; i <= 4; i++) {
      if (inBounds(row + (rowIncrement * i)) &&
          inBounds(col + (colIncrement * i))) {
        if (boardState[row + (rowIncrement * i)][col + (colIncrement * i)] ==
            index) {
          count++;
        } else {
          break;
        }
      }
    }
    return count;
  }

  void setWinner(GameState gameState) {
    print('$gameState wins');
    winner = gameState;
    switch (gameState) {
      case GameState.Blank:
        {
          _draws++;
          break;
        }
      case GameState.Black:
        {
          _blackWins++;
          break;
        }
      case GameState.White:
        {
          _whiteWins++;
          break;
        }
    }
    toggleBoardOpacity();
  }

  void toggleBoardOpacity() {
    if (_boardOpacity == 0.0) {
      setState(() {
        _showWinnerDisplay = false;
      });
      _boardController.reverse();
    } else if (_boardOpacity == 1.0) {
      _boardController.forward();
      setState(() {
        _showWinnerDisplay = true;
      });
    }
  }

  void toggleActivePlayer() {
    if (activePlayer == GameState.Black)
      activePlayer = GameState.White;
    else
      activePlayer = GameState.Black;
  }

  gamePiece(int row, int col) {
    if (boardState[row][col] == GameState.Black)
      return Dot(Colors.black);
    else if (boardState[row][col] == GameState.White)
      return Dot(Colors.white);
    else
      return null;
  }
}
