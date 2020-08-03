import 'package:flutter/material.dart';
import 'package:gociapp/UI/HomeUIComponent/ListeProduits.dart';

/// Component item Menu icon bellow a ImageSlider
class CategoryIconValue extends StatelessWidget {
  String icon1, icon2, title1, title2;
  String  tap1, tap2;

  CategoryIconValue({
    this.icon1,
    this.tap1,
    this.icon2,
    this.tap2,
    this.title1,
    this.title2,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(23, 0, 23, 23)),
        Center(child:
        InkWell(
          onTap: (){
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new ListeProduits(tap1, title1),
                transitionDuration: Duration(milliseconds: 750),
                transitionsBuilder:
                    (_, Animation<double> animation, __, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: child,
                  );
                }));
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                icon1,
                height: 40,
                width: 50,
              ),
              Padding(padding: EdgeInsets.only(top: 7.0)),
              Text(
                title1,
                style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),),

        Padding(padding: EdgeInsets.all(23.0)),
        Center(
          child:  InkWell(
            onTap: (){
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new ListeProduits(tap2,title2),
                  transitionDuration: Duration(milliseconds: 750),
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    return Opacity(
                      opacity: animation.value,
                      child: child,
                    );
                  }));
            },
            child: Column(
              children: <Widget>[
                Image.asset(
                  icon2,
                  height: 40,
                  width: 50,
                ),
                Padding(padding: EdgeInsets.only(top: 0.0)),
                Text(
                  title2,
                  style: TextStyle(
                    fontFamily: "Sans",
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ) ,
        )
      ,
      ],
    );
  }
}