import 'dart:async';

import 'package:flutter/material.dart';

import './home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(
      Duration(seconds: 4),
      (){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => HomePage()
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF607D8B),//
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'GO MO KU ',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 50.0,
                                fontFamily: 'Bangers',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  CircleAvatar(
                    child: Image.asset('assets/circle.png',color: Colors.white,),
                    //Icon(Icons.blur_circular,size: 40,color: Theme.of(context).accentColor,)
                    backgroundColor: Colors.black45,
                    radius: 50,
                  ),
                ],
              ),



              Column(
                children: <Widget>[
                  CircularProgressIndicator(),

                  SizedBox(height: 10,),

                  Text(
                    'Loading..',
                    style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
