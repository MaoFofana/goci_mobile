import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gociapp/Data/Api/Auth.dart';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/Data/Model/User.dart';
import 'package:gociapp/UI/Animation/LoginAnimation.dart';
import 'package:gociapp/UI/Component/ButtomBlackBottom.dart';
import 'package:gociapp/UI/Component/TextFormField.dart';
import 'package:gociapp/UI/LoginOrSignup/Login.dart';
import 'package:progress_dialog/progress_dialog.dart';




class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  AnimationController animationControllerScreen;
  Animation animationScreen;

  //controller
  TextEditingController emailController = new TextEditingController();
  TextEditingController nomController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();

  // variable input
  String address = "";
  ///progress
  ProgressDialog progressDialog;
  var tap = 0;
  String notification = "";
  bool pass = false;
  /// Set AnimationController to initState
  @override
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

  /// Dispose animationController
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
    mediaQueryData.size.height;
    mediaQueryData.size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            /// Set Background image in layout
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/img/backgroundgirl.png"),
              fit: BoxFit.cover,
            )),
            child: Container(
              /// Set gradient color in image
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.2),
                    Color.fromRGBO(0, 0, 0, 0.3)
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                ),
              ),
              /// Set component layout
              child: ListView(
                padding: EdgeInsets.all(0.0),
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
                                        top:
                                        mediaQueryData.padding.top + 40.0)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                    Image.asset(
                                      'assets/img/Logo.png',
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0)),
                                    /// Animation text treva shop accept from login layout
                                  ],
                                ),
                                Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 15.0)),
                                Text(
                                  '$notification',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Sans"),
                                ),
                                /// TextFromField Email
                                TextFromField(
                                  icon: Icons.account_box,
                                  password: false,
                                  email: "Votre nom et prenom",
                                  inputType: TextInputType.text,
                                  controller: nomController,
                                ),
                                Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 5.0)),

                                /// TextFromField Email
                                TextFromField(
                                  icon: Icons.email,
                                  password: false,
                                  email: "Votre Email",
                                  inputType: TextInputType.emailAddress,
                                  controller: emailController,

                                ),
                                Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 5.0)),
                                TextFromField(
                                  icon: Icons.phone_android,
                                  password: false,
                                  email: "Numero de telephone",
                                  inputType: TextInputType.number,
                                  controller: numberController,
                                ),

                                Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 5.0)),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Container(
                                    height: 60.0,
                                    alignment: AlignmentDirectional.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14.0),
                                        color: Colors.white,
                                        boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
                                    padding:
                                    EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
                                    child: Theme(
                                      data: ThemeData(
                                        hintColor: Colors.transparent,
                                      ),
                                      child: FormField<String>(
                                        builder: (FormFieldState<String> state) {
                                          return InputDecorator(
                                            decoration: InputDecoration(
                                              labelText: "Zone géographique",
                                              labelStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'Sans',
                                                  letterSpacing: 0.3,
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.w600),
                                              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    address = newValue;
                                                    state.didChange(newValue);
                                                  });
                                                },
                                                items: currencies.map((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                value: address.isNotEmpty ? address : null,
                                                hint: Text('Zone géographique'),
                                                isDense: true,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 5.0)),
                                /// TextFromField Password
                                TextFromField(
                                  icon: Icons.add_location,
                                  password: false,
                                  email: "Quartier ",
                                  inputType: TextInputType.text,
                                  controller: cityController,
                                ),
                                Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 5.0)),

                                /// TextFromField Password
                                TextFromField(
                                  icon: Icons.vpn_key,
                                  password: true,
                                  email: "Votre mot de passe",
                                  inputType: TextInputType.text,
                                  controller: passwordController,
                                ),

                                /// Button Login
                                FlatButton(
                                    padding: EdgeInsets.only(top: 20.0),
                                    onPressed: () {

                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                              new LoginScreen("")));
                                    },
                                    child: Text(
                                      "Vous avez déja un compte? Connectez-vous",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Sans"),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: mediaQueryData.padding.top + 105.0,
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
                          if(nomController.text.isEmpty && passwordController.text.isEmpty && emailController.text.isEmpty){
                            setState(()  {
                              notification = "Veuillez remplir tout les champs";
                            });
                          }else {
                            progressDialog.update(message: "Inscription.....");
                            progressDialog.show();
                            User user = new User(
                                nom: nomController.text,
                                password: passwordController.text,
                                email: emailController.text,
                                city: cityController.text,
                                address: address,
                              phone: numberController.text
                            );
                            var resultat = await inscriptionOrUpdate(user);
                            progressDialog.hide();
                          if(resultat == "valider"){
                            Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                    new LoginScreen("Inscripion effectuer avec success \nveuillez-vous connecter")));
                          }else {
                            setState(()  {
                             // loader = false;
                              notification = resultat ;
                            });
                          }}

                          _PlayAnimation();
                          return tap;
                        },
                        child: buttonBlackBottom("Inscription"),
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
        ],
      ),
    );


  }


}




