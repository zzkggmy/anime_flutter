import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

void main() => runApp(AnimeApp());

AnimationController animationController;

Animation<double> _animation;

CurvedAnimation curved;

Animation<double> widthAnime;

Animation _colorTween;

Animation _color;

Animation _trans;

Animation _opacity;

Animation<Offset> _offset;

class AnimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "动画",
      home: new Animen(),
    );
  }
}

class Animen extends StatefulWidget {
  @override
  AnimeContent createState() => new AnimeContent();
}

class AnimeContent extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );

    curved = new CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 1.0, curve: Curves.bounceIn));

    widthAnime = Tween<double>(
      begin: 0.0,
      end: 300.0,
    ).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 1.0, curve: Curves.ease)))
      ..addListener(() {
        setState(() {});
      });

    _colorTween =
        ColorTween(begin: Colors.transparent, end: Colors.black).animate(
      animationController,
    )..addListener(() {
            setState(() {});
          });

    _color = ColorTween(begin: Colors.transparent, end: Colors.blue).animate(
      animationController,
    )..addListener(() {
        setState(() {});
      });

    _trans = EdgeInsetsTween(
            begin: EdgeInsets.only(top: 0.0, right: 0.0),
            end: EdgeInsets.only(top: 50.0, right: 50.0))
        .animate(animationController)
          ..addListener(() {
            setState(() {});
          });

    _opacity = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    _offset = Tween(begin: Offset.zero, end: Offset(0.2, 0))
        .animate(animationController)
          ..addListener(() {
            setState(() {});
          });

    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 10.0,
        onPressed: () => {print("改变颜色"), animationController.repeat()},
      ),
      backgroundColor: Colors.white,
      body: body(context),
    );
  }
}

Widget body(BuildContext buildContext) {
  return Column(
    children: <Widget>[animePart(), clickPart(buildContext)],
  );
}

Widget animePart() {
  return SlideTransition(
      position: _offset,
      child: Container(
          width: widthAnime.value,
          height: 300,
          color: _color.value,
          padding: EdgeInsets.all(50),
          alignment: Alignment.center,
          child: Opacity(
            opacity: _opacity.value,
            child:
                Text("动画", style: TextStyle(color: Colors.black, fontSize: 33)),
          )));
}

Widget clickPart(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 50,
    margin: EdgeInsets.all(30),
    color: Colors.green,
    child: MaterialButton(
      child: Text("点击"),
      onPressed: () => {
        print("点击dialog"),
        showDialog(
            context: context,
            child: new AlertDialog(
              title: Text(
                "AlertDialog",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              content: Text("AlertDialog Content"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("取消"),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("确定"),
                )
              ],
            ))
      },
    ),
  );
}
