import 'package:flutter/material.dart';
import 'package:gociapp/UI/BrandUIComponent/BrandLayout.dart';

/// Component category item bellow FlashSale
class BrandItem extends StatelessWidget {
  String image, title;
  BrandItem({
    this.image,
    this.title
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new brand(name: this.title),
            transitionDuration: Duration(milliseconds: 750),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            }));
      },
      child: Container(
        height: 125.0,
        width: 330.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
        ),
      ),
    );
  }
}