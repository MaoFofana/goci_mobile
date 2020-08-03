import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gociapp/Data/Api/Auth.dart';
import 'package:gociapp/Data/Model/User.dart';
import 'package:gociapp/UI/Component/ButtomBlackBottom.dart';
import 'package:gociapp/UI/Component/TextFormField.dart';
import 'package:gociapp/UI/Animation/LoginAnimation.dart';
import 'package:gociapp/UI/LoginOrSignup/Signup.dart';
import 'package:progress_dialog/progress_dialog.dart';


class LoginScreen extends StatefulWidget {
  String notification ="";
  LoginScreen(this.notification);
  @override
  _LoginScreenState createState() => _LoginScreenState(this.notification);
}
/// Component Widget this layout UI
class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  ProgressDialog progressDialog ;
  String notification = "";
  var color = Colors.black;
  double fontSize = 17.0;
  //Animation Declaration
  AnimationController sanimationController;
  _LoginScreenState(this.notification);
  var tap = 0;
  @override
  /// set state animation controller
  void initState() {
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });
    // TODO: implement initState
    super.initState();
  }

  /// Dispose animation controller
  @override
  void dispose() {
    super.dispose();
    sanimationController.dispose();
  }

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context,type: ProgressDialogType.Normal);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        /// Set Background image in layout (Click to open code)
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/loginscreenbackground.png"),
          fit: BoxFit.cover,
        )),
        child: Container(
          /// Set gradient color in image (Click to open code)
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 0, 0, 0.0),
                Color.fromRGBO(0, 0, 0, 0.3)
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
          /// Set component layout
          child: ListView(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.topCenter,
                        child: Column(
                          children: <Widget>[
                            /// padding logo
                            Padding(
                                padding: EdgeInsets.only(
                                    top: mediaQueryData.padding.top + 40.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/img/Logo.png'),
                                //height: 70.0,
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0)),

                              ],
                            ),

                            /// TextFromField Email
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0)),
                            Text(
                              notification,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: color,
                                  letterSpacing: 0.2,
                                  fontFamily: 'Sans',
                                  fontSize: fontSize
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0)),
                            TextFromField(
                              icon: Icons.email,
                              password: false,
                              email: "Email",
                              inputType: TextInputType.emailAddress,
                              controller: emailController,

                            ),

                            /// TextFromField Password
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0)),
                            TextFromField(
                              icon: Icons.vpn_key,
                              password: true,
                              email: "Mot de passe",
                              inputType: TextInputType.text,
                              controller: passwordController,
                            ),

                            /// Button Signup
                            FlatButton(
                                padding: EdgeInsets.only(top: 20.0),
                                onPressed: () {

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new Signup()));
                                },
                                child: Text(
                                  "Vous n'avez pas de compte?\n Inscrivez-vous",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Sans"),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: mediaQueryData.padding.top + 100.0,
                                  bottom: 0.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  /// Set Animaion after user click buttonLogin
                  tap == 0
                      ? InkWell(
                          splashColor: Colors.yellow,
                          onTap: () async {
                            if(emailController.text.isEmpty || passwordController.text.isEmpty){
                              notification = "Veuillez remplir tous les champs";
                            }
                            progressDialog.update(message: "Connexion..........");
                            progressDialog.show();
                            User user = new User(
                              email: emailController.text,
                              password: passwordController.text
                            );
                            var resultat = await connection(user);
                            progressDialog.hide();
                            if(resultat == "valider"){
                              new LoginAnimation(
                                animationController: sanimationController.view,
                              );
                              _PlayAnimation();
                              setState(() {
                                tap = 1;
                              });
                               //return tap;
                              }else {
                                setState(() {
                                  color = Colors.red;
                                  fontSize = 12.0;
                                  notification = resultat;
                                });
                            }
                            },
                          child: buttonBlackBottom("Connexion"),
                        )
                      : new LoginAnimation(
                          animationController: sanimationController.view,
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


