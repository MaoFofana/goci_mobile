import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gociapp/Data/Model/Slide.dart';
import 'package:gociapp/Library/carousel_pro/carousel_pro.dart';
import 'package:gociapp/UI/Animation/Animation.dart';
import 'package:gociapp/UI/BottomNavigationBar.dart';
import 'package:gociapp/UI/Component/ButtomCustom.dart';


class ChoseLogin extends StatefulWidget {
  @override
  _ChoseLoginState createState() => _ChoseLoginState();
}

/// Component Widget this layout UI
class _ChoseLoginState extends State<ChoseLogin> with TickerProviderStateMixin {
  /// Declare Animation
  AnimationController animationController;
  var tapLogin = 0;
  var tapSignup = 0;
  var tapHome = 0;

  @override
  /// Declare animation in initState
  void initState() {
    // TODO: implement initState
    /// Animation proses duration
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tapLogin = 0;
                tapSignup = 0;
                tapHome = 0;
              });
            }
          });
    super.initState();
  }

  /// To dispose animation controller
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    // TODO: implement dispose
  }
  /// Playanimation set forward reverse
  Future<Null> _Playanimation() async {
    try {
      await animationController.forward();
      await animationController.reverse();
    } on TickerCanceled {}
  }
  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    mediaQuery.devicePixelRatio;
    mediaQuery.size.height;
    mediaQuery.size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ///
          /// Set background image slider
          ///
        Container(
          color: Colors.white,
          child: new Carousel(
            boxFit: BoxFit.cover,
            autoplay: true,
            animationDuration: Duration(milliseconds: 300),
            dotSize: 0.0,
            dotSpacing: 16.0,
            dotBgColor: Colors.transparent,
            showIndicator: false,
            overlayShadow: false,
            images: [
              AssetImage("assets/img/SliderLogin2.jpg"),
              AssetImage('assets/img/SliderLogin3.jpg'),
              AssetImage("assets/img/SliderLogin4.jpg"),
            ],
          ),
        ),
          Container(
            /// Set gradient color in image (Click to open code)
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0.3),
                      Color.fromRGBO(0, 0, 0, 0.4)
                    ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter)),
            /// Set component layout
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Container(
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: mediaQuery.padding.top + 50.0),
                              ),
                              Center(
                                /// Animation text treva shop accept from splashscreen layout (Click to open code)
                                child: Hero(
                                  tag: "Goci",
                                  child:Image.asset("assets/img/Logo.png"),
                                ),
                              ),
                              /// Padding Text "Get best product in treva shop" (Click to open code)
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 160.0,
                                      right: 160.0,
                                      top: mediaQuery.padding.top + 90.0,
                                      bottom: 10.0
                                  )
                              ),
                              /// to set Text "get best product...." (Click to open code)
                              Text(
                                "Obtenir des produits ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Sans",
                                    letterSpacing: 1.3),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 160.0,
                                      right: 160.0,
                                      top: 10.0,
                                      bottom: 10.0),
                                  child: Container(
                                    color: Colors.white,
                                    height: 0.5,
                                  )),
                              Text(
                                "de qualité chez GOCI.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Sans",
                                    letterSpacing: 1.3),
                                textAlign: TextAlign.center,
                              ),
                              Padding(padding: EdgeInsets.only(top: 250.0)),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            /// To create animation if user tap == animation play (Click to open code)
                            tapLogin == 0
                                ? Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  setState(() {
                                    tapLogin = 1;
                                  });
                                  _Playanimation();
                                  return tapLogin;
                                },
                                child: ButtonCustom(txt: "Mon Compte"),
                              ),
                            )
                                : AnimationSplashSignup(
                              animationController: animationController.view,
                            ),
                            Padding(padding: EdgeInsets.only(top: 15.0)),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  /// To set white line (Click to open code)
                                  Container(
                                    color: Colors.white,
                                    height: 0.2,
                                    width: 80.0,
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                    /// navigation to home screen if user click "OR SKIP" (Click to open code)
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                new bottomNavigationBar()));
                                      },
                                      child: Text(
                                        "OU",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w100,
                                            fontFamily: "Sans",
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ),

                                  /// To set white line (Click to open code)
                                  Container(
                                    color: Colors.white,
                                    height: 0.2,
                                    width: 80.0,
                                  )
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 70.0)),
                          ],
                        ),

                        /// To create animation if user tap == animation play (Click to open code)
                        tapSignup == 0
                            ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                      new bottomNavigationBar()));
                              _Playanimation();
                              return tapSignup;
                            },
                            child: ButtonCustom(txt: "Visiter GOCI"),
                          ),
                        )
                            : AnimationSplashLogin(
                          animationController: animationController.view,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
    ],
      ),
    );
  }
}

