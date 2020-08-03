import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gociapp/Data/Api/Produits.dart';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/Data/Model/Produit.dart';
import 'package:gociapp/UI/Component/ProductGrid.dart';
import 'package:shimmer/shimmer.dart';

class ListeProduits extends StatefulWidget {
  String nomCategorie, title;
  ListeProduits(this.nomCategorie,this.title);
  @override
  _ListeProduitsState createState() => _ListeProduitsState(this.nomCategorie, this.title);
}



class _ListeProduitsState extends State<ListeProduits> {
    String nomCategorie, title;
  ///
  /// Get image data dummy from firebase server
  ///
 var imageNetwork = NetworkImage("https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Screenshot_20181005-213931.png?alt=media&token=e6287f67-5bc0-4225-8e96-1623dc9dc42f");
  ///
  /// check the condition is right or wrong for image loaded or no
  ///
  bool imageLoad = true;
  Future<List<Produit>> listsProduits ;
  ///
  /// SetState after imageNetwork loaded to change list card
  _ListeProduitsState(this.nomCategorie, this.title);
  @override
  void initState() {
    listsProduits = getProduitsByCategorieName(this.nomCategorie);
     Timer(Duration(seconds: 5),(){
        setState(() {
          imageLoad=false;
        });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    /// Grid Item a product
    var _grid = SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// check the condition if image data from server firebase loaded or no
            /// if image true (image still downloading from server)
            /// Card to set card loading animation
            imageLoad? _imageLoading(context):
            FutureBuilder<List<Produit>>(
              future: listsProduits,
            builder: (context, snapshot) {
              if (snapshot.hasData){
                  return GridView.count(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 0.545,
                  crossAxisCount: 2,
                  primary: false,
                  children:List.generate(
                    /// Get data in flashSaleItem.dart (ListItem folder)
                    snapshot.data.length,
                        (index) => ProductGrid(snapshot.data[index]),
                  ),
                );
               }else {
                 return Container(
                     height: MediaQuery.of(context).size.height - 150.0,
                     child:Center(child : CircularProgressIndicator() ) ,
                 ) ;
               }
            }
          )
          ],
        ),
      ),
    );

    return Scaffold(
      /// Appbar item
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "$title",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        iconTheme: IconThemeData(
          color: colorGoci,
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            /// Calling search and grid variable
            children: <Widget>[
              _grid,
            ],
          ),
        ),
      ),
    );
  }
}



///
///
///
/// Loading Item Card Animation Constructor
///
///
///
class loadingMenuItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: (){

        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                )
              ]),
          child: Wrap(
            children: <Widget>[
              ///
              ///
              /// Shimmer class for animation loading
              ///
              ///
              Shimmer.fromColors(
                baseColor: Colors.black38,
                highlightColor: Colors.white,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 205.0,
                            width: 185.0,
                            color: Colors.black12,
                          ),
                          Container(
                            height: 25.5,
                            width: 65.0,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(5.0))),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 5.0,top: 12.0),
                          child: Container(
                            height: 9.5,
                            width: 130.0,
                            color: Colors.black12,
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 5.0,top: 10.0),
                          child: Container(
                            height: 9.5,
                            width: 80.0,
                            color: Colors.black12,
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 7.0,bottom: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14.0,
                                )
                              ],
                            ),
                            Container(
                              height: 8.0,
                              width: 30.0,
                              color: Colors.black12,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


///
///
/// Calling imageLoading animation for set a grid layout
///
///
Widget _imageLoading(BuildContext context){
  return GridView.count(
    shrinkWrap: true,
    padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 15.0,
    childAspectRatio: 0.545,
    crossAxisCount: 2,
    primary: false,
    children:List.generate(
      /// Get data in ListeProduits.dart (ListItem folder)
      12,
          (index) => loadingMenuItemCard(),
    ),
  );
}