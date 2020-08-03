import 'package:flutter/material.dart';
import 'package:gociapp/UI/HomeUIComponent/CategoryDetail.dart';

/// Component category item bellow FlashSale
class CategoryItemValue extends StatelessWidget {
  String image, title,tap, nomImage;

  CategoryItemValue({
    this.image,
    this.title,
    this.tap,
    this.nomImage
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new categoryDetail(this.tap, this.title, this.nomImage),
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
        height: 105.0,
        width: MediaQuery.of(context).size.width/2.03,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}