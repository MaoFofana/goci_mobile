import 'package:flutter/material.dart';
/// Component category item bellow FlashSale
class BanniereGoci extends StatelessWidget {
  String image;
  BanniereGoci({
    this.image
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        height: 105.0,
        width: 200.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          image: DecorationImage(image: NetworkImage("http://apikeys.g0ci.com/public/storage/"+image), fit: BoxFit.cover),
        ),),
    );
  }
}