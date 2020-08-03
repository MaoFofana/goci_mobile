import 'package:flutter/material.dart';
import 'package:gociapp/Data/Api/OrderApi.dart';
import 'package:gociapp/Data/Api/Produits.dart';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/UI/CartUIComponent/CartLayout.dart';
import 'package:gociapp/UI/HomeUIComponent/Search.dart';
import 'package:localstorage/localstorage.dart';

class AppbarGradient extends StatefulWidget {
  @override
  _AppbarGradientState createState() => _AppbarGradientState();
}

class _AppbarGradientState extends State<AppbarGradient> {
  int valueItemChart = 0;
  LocalStorage dataStorage  = new LocalStorage("data");
  @override
  void initState() {
    _panierSizeTraitement();
  }

  _panierSizeTraitement()  async {
    int size = await cartSize();
    setState(() {
      valueItemChart = size;
    });
  }
    /// Build Appbar in layout home
  @override
  Widget build(BuildContext context) {
    _panierSizeTraitement();
    /// Create responsive height and padding
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    /// Create component in appbar
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: 58.0 + statusBarHeight,
      decoration: BoxDecoration(
        /// gradient in appbar
          gradient: LinearGradient(
              colors: [
                const Color(0xFFEB3739),
                const Color(0xFFCD0007),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /// if user click shape white in appbar navigate to search layout
          InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => searchAppbar(),
                  /// transtation duration in animation
                  transitionDuration: Duration(milliseconds: 750),
                  /// animation route to search layout
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    return Opacity(
                      opacity: animation.value,
                      child: child,
                    );
                  }));
            },
            /// Create shape background white in appbar (background treva shop text)
            child: Container(
              margin: EdgeInsets.only(left: media.padding.left + 15),
              height: 37.0,
              width: 222.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  shape: BoxShape.rectangle),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                    left: 17.0,
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(
                      "Chercher ",
                      style: TextStyle(
                          fontFamily: "Popins",
                          color: Colors.black12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.0,
                          fontSize: 16.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /// Icon notification (if user click navigate to notification layout)
          InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new cart())); //notification()
            },
            child: Stack(
              alignment: AlignmentDirectional(-1.0, -0.8),
              children: <Widget>[
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    )),
                CircleAvatar(
                  radius: 10.0,
                  backgroundColor: Colors.redAccent,
                  child: Text(
                    valueItemChart.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}
