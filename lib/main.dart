import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Container(color: Colors.white, child: GameScreen()),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  /// Speed of the game! EX/ 1 = 1 second, 10 = 100 ms
  var gameSpeed = 3;


  /// asynch Timer that moves the screen
  Timer _everySecond;



  /// Controller of the main game flow
  ScrollController _scrollController = ScrollController();


  List<PianoObject> gameOBJ = [PianoObject(2,clicked: true),PianoObject(1,clicked: true),PianoObject(3,clicked: true),PianoObject(3),PianoObject(2),PianoObject(4),PianoObject(2),PianoObject(1),PianoObject(1),PianoObject(3),PianoObject(4),PianoObject(2)];
  /// List of the Objects
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_scrollController.jumpTo(_scrollController.offset)
    asyncFlow(); /// trigger game flow
  }

  void updateFlow(var Data) {
    ///Updater function of game flow tiles
    setState(() {
      gameOBJ.add(Data);
  //    gameOBJ.removeAt(0);
    });
  }

  void asyncFlow() {
    /// Async engine of the game
    _everySecond = Timer.periodic(Duration(milliseconds: (1000*(pow(gameSpeed, -1))).round()), (Timer t)
    {

      /// Calculating the duration of the animation of an tile to move out of the screen according to the gameSpeed property
      Duration duration = Duration(milliseconds: (1000*(pow(gameSpeed, -1))).round());

      /// Animation
      _scrollController.animateTo(_scrollController.offset + MediaQuery.of(context).size.height / 6,
          duration: duration, curve: Curves.linear);

      var rng = Random(); /// Randomizing the [touchablePosition] property
      var touchablePosition = rng.nextInt(4);
      updateFlow(PianoObject(touchablePosition,)); /// adding new game object on top of the game flow

    /// This shit is the algorithm calculating if the bottom tile is clicked or not
//        print(((_scrollController.offset / (MediaQuery.of(context).size.height / 6)) -((_scrollController.offset / MediaQuery.of(context).size.height / 6)/2)).floor());
//      if(gameOBJ[((_scrollController.offset / (MediaQuery.of(context).size.height / 6)) -((_scrollController.offset / MediaQuery.of(context).size.height / 6)/2)).floor()-1].clicked == false){
//        _everySecond.cancel();
//
//        print("gameover");
//      }


    });
  }


  /// Main build method
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                /// Game Flow List
                controller: _scrollController,
                reverse: true,
                itemCount: gameOBJ.length,
                itemBuilder: (BuildContext context, int position) {
                  return Column(
                    children: <Widget>[
                      PianoTile(context,gameOBJ[position].touchablePosition,position),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2.0,
                        color: Colors.black38,
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  bool isPositionTrue(var defaultPose, var initialPose,var position) {
    /// checking the position of the tile element in order to paint and checking if it is clicked already
    if (defaultPose == initialPose &&  gameOBJ[position].clicked == false) {
      return true;
    } else
      return false;
  }



  /// Tile Vidget
  Widget PianoTile(BuildContext context, var a,var position) {
    /// Height of the Tile

    double tileHeight = MediaQuery.of(context).size.height / 6;
    double ElementWidth = (MediaQuery.of(context).size.width - 24) /4;
    /// Position of the touchable in the row( RANDOM as default)

    var touchablePosition = a;

    return new Container(
      height: tileHeight,
      child: new Row(
        children: <Widget>[
          GestureDetector(
            onTapDown: (var pos){
              print("clicked");
              if(isPositionTrue(touchablePosition, 0,position)){
                setState(() {
                  gameOBJ[position].onclick();
                });
              }
            },
            child: new Container(
              width:  ElementWidth,
              height: tileHeight,
              child: new Container(
                color: isPositionTrue(touchablePosition, 0,position) ? Colors.black : Colors.white,
              ),
            ),
          ),
          new Container(
            height: tileHeight,
            width: 8.0,
            color: Colors.black38,
          ),
          GestureDetector(
            onTapDown: (var pos){
              print("clicked");
              if(isPositionTrue(touchablePosition, 1,position)){
                setState(() {
                  gameOBJ[position].onclick();
                });
              }
            },
            child: new Container(
              width:  ElementWidth,
              height: tileHeight,
              child: new Container(
                color: isPositionTrue(touchablePosition, 1,position) ? Colors.black : Colors.white,
              ),
            ),
          ),
          new Container(
            height: tileHeight,
            width: 8.0,
            color: Colors.black38,
          ),
          GestureDetector(

            onTapDown: (var pos){
              print("clicked");
              if(isPositionTrue(touchablePosition, 2,position)){
                setState(() {
                  gameOBJ[position].onclick();
                });
              }
            },
            child: new Container(
              width:  ElementWidth,
              height: tileHeight,
              child: new Container(
                color: isPositionTrue(touchablePosition, 2,position) ? Colors.black : Colors.white,
              ),
            ),
          ),
          new Container(
            height: tileHeight,
            width: 8.0,
            color: Colors.black38,
          ),
          GestureDetector(
            onPanDown: (var pos){
              print("clicked");
              if(isPositionTrue(touchablePosition, 3,position)){
                setState(() {
                  gameOBJ[position].onclick();
                });
              }
            },
            child: new Container(
              width:  ElementWidth,
              height: tileHeight,
              child: new Container(
                color: isPositionTrue(touchablePosition, 3,position) ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class PianoObject{ /// This is the object that determines whether tiles are clicked or the position of the touchable
  var touchablePosition; /// position of the touchable
   var clicked; /// İs Clicked??

  PianoObject(this.touchablePosition, {this.clicked = false});

  void onclick(){ /// Setter of the var clicked when player clicks to the touchable
    clicked = true;
  }
}
