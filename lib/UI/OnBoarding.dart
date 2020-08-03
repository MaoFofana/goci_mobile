import 'package:flutter/material.dart';
import 'package:gociapp/Library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:gociapp/Library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';
import 'package:gociapp/UI/LoginOrSignup/ChoseLoginOrSignup.dart';
import 'package:localstorage/localstorage.dart';

class onBoarding extends StatefulWidget {
  @override
  _onBoardingState createState() => _onBoardingState();
}

var _fontHeaderStyle = TextStyle(
  fontFamily: "Popins",
  fontSize: 18.0,
  fontWeight: FontWeight.w800,
  color: Colors.black87,
  letterSpacing: 1.5,

);

var _fontDescriptionStyle = TextStyle(
  fontFamily: "Sans",
  fontSize: 15.0,
  color: Colors.black26,
  fontWeight: FontWeight.w400
);

///
/// Page View Model for on boarding
///
final pages = [
  new PageViewModel(
      pageColor:  Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Votre Marketplace Innovante',style: _fontHeaderStyle,textAlign: TextAlign.center,
      ),
      body: Container(
        height: 250.0,
        child: Text(
          "La boutique leader de la vente en ligne  \nen Côte d'Ivoire.",textAlign: TextAlign.center,
          style: _fontDescriptionStyle
        ),
      ),
      mainImage: Image.asset(
        'assets/imgIllustration/IlustrasiOnBoarding1.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),

  new PageViewModel(
      pageColor:  Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Acheter',style: _fontHeaderStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
            "Acheter dans l'un  des meilleurs supermarché en ligne à portée de main.",textAlign: TextAlign.center,
            style: _fontDescriptionStyle
        ),
      ),
      mainImage: Image.asset(
        'assets/imgIllustration/IlustrasiOnBoarding2.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),

  new PageViewModel(
      pageColor:  Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'G-WARI',style: _fontHeaderStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
            "Beneficier de notre système de recompense\n sur chacun de vos achats.",textAlign: TextAlign.center,
            style: _fontDescriptionStyle
        ),
      ),
      mainImage: Image.asset(
        'assets/imgIllustration/IlustrasiOnBoarding3.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),

];

class _onBoardingState extends State<onBoarding> {
  LocalStorage localStorage = new LocalStorage('onBoard');

  @override
  Widget build(BuildContext context) {

    return IntroViewsFlutter(
      pages,
      pageButtonsColor: Colors.green,
      skipText: Text("SAUTER",style: _fontDescriptionStyle.copyWith(color: Color(0xFFCD0007),fontWeight: FontWeight.w800,letterSpacing: 1.0),),
      doneText: Text("TERMINER",style: _fontDescriptionStyle.copyWith(color: Color(0xFFCD0007),fontWeight: FontWeight.w800,letterSpacing: 1.0),),
      onTapDoneButton: (){
      localStorage.setItem('valide', 'valide');
        Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_,__,___)=> new ChoseLogin(),
        transitionsBuilder: (_,Animation<double> animation,__,Widget widget){
          return Opacity(
            opacity: animation.value,
            child: widget,
          );
        },
        transitionDuration: Duration(milliseconds: 1500),
        ));
      },
    );
  }
}

