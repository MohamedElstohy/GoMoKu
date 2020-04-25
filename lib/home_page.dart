import 'package:flutter/material.dart';
import 'two_players_game.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _multiWidth;
  double _soloWidth;
  int _navigatorIndex;


  @override
  void initState() {
    super.initState();
    _multiWidth = 0;
    _soloWidth = 0;
    _navigatorIndex = 2;
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color(0xFF607D8B),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'GO MO KU ',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Bangers'
                    ),
                  ),
//                  TextSpan(
//                    text: 'MO ',
//                    style: TextStyle(
//                      color: Colors.blue,
//                      fontSize: 50.0,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
//                  TextSpan(
//                    text: 'KU',
//                    style: TextStyle(
//                      color: Colors.green,
//                      fontSize: 50.0,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
                ]
                ),
              ),
            ),

//            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _multiWidth = 0;
                          _soloWidth = 2;
                          _navigatorIndex = 0;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: _soloWidth,color: Colors.white),
                          color: Colors.black54,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image(
                              image:AssetImage('assets/solo.png'),
                              width: 80,
                              height: 80,
                              color: Colors.white,
                            ),

                            Text(
                              'vs AI',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Flower'
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _multiWidth = 2;
                          _soloWidth = 0;
                          _navigatorIndex = 1;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: _multiWidth,color: Colors.white),
                          color: Colors.black54,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image(
                              image:AssetImage('assets/triangle.png'),
                              width: 80,
                              height: 80,
                              color: Colors.white,
                            ),

                            Text(
                              '2 Players',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Flower'
                              ),
                            )
                          ],
                        ),
                  ),
                    ),
                  )
                ],
              ),
            ),

//            SizedBox(height: 30,),

            FloatingActionButton(
              onPressed: (){
                if(_navigatorIndex == 0){
                  return;
                } else if(_navigatorIndex == 1){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => TwoPlayerGame()
                      )
                  );
                } else{
                  return;
                }
              },
              backgroundColor: Colors.black38,
              child: Text(
                  'Start',
                style: TextStyle(
                  fontFamily: 'Bangers',
                  color: Color(0xFF607D8B)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}