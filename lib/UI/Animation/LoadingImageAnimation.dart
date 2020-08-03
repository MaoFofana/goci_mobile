import 'package:flutter/material.dart';
import 'package:gociapp/UI/Component/LoadLMenuItem.dart';

///
///
/// Calling imageLoading animation for set a grid layout
///
///
class LoadingImageAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index)=>loadingMenuItemDiscountCard(),
      itemCount: 20,
    );
  }
}


