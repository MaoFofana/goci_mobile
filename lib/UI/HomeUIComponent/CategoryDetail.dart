import 'dart:async';
import 'package:gociapp/Data/Api/Produits.dart';
import 'package:gociapp/Data/Model/Produit.dart';
import 'package:gociapp/UI/Animation/LoadingImageAnimation.dart';
import 'package:gociapp/Library/carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:gociapp/UI/Component/ProductGrid.dart';
import 'package:gociapp/UI/HomeUIComponent/Search.dart';
import 'package:shimmer/shimmer.dart';

class categoryDetail extends StatefulWidget {
  String nomCategorie, nomImage, titre; 
  categoryDetail(this.nomCategorie, this.titre,this.nomImage );
  @override
  _categoryDetailState createState() => _categoryDetailState(this.nomCategorie, this.titre, this.nomImage);
}

/// if user click icon in category layout navigate to categoryDetail Layout
class _categoryDetailState extends State<categoryDetail> {

  ///
  /// Get image data dummy from firebase server
  ///
  var imageNetwork = NetworkImage("https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Screenshot_20181005-213916.png?alt=media&token=f952caf0-2de7-417c-9c9e-3b6dcea953f4");
  ///
  /// check the condition is right or wrong for image loaded or no
  ///
  bool loadImage = true;

  String nomCategorie, nomImage, titre;
  _categoryDetailState(this.nomCategorie, this.titre, this.nomImage);
  Future<List<Produit>> listsProduits ;
  ///
  /// SetState after imageNetwork loaded to change list card
  ///
  @override
  void initState() {
     Timer(Duration(seconds: 8),(){
      setState(() {
        loadImage=false;
      });
    });
    // TODO: implement initState
    listsProduits = getProduitsByCategorieName(this.nomCategorie);
    super.initState();
  }

  /// All Widget Component layout
  @override
  Widget build(BuildContext context) {

    /// imageSlider in header layout category detail
    var _imageSlider = Padding(
      padding: const EdgeInsets.only(
          top: 0.0, left: 10.0, right: 10.0, bottom: 35.0),
      child: Container(
        height: 180.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          image: DecorationImage(image: AssetImage("assets/categorie/"+ this.nomImage), fit: BoxFit.fill),
        ),
       /* child: new Carousel(
          boxFit: BoxFit.contain,
          dotColor: Colors.transparent,
          dotSize: 5.5,
          dotSpacing: 16.0,
          dotBgColor: Colors.transparent,
          showIndicator: false,
          overlayShadow: false,
          overlayShadowColors: Colors.white.withOpacity(0.9),
          overlayShadowSize: 0.9,
          images: [
            AssetImage("assets/categorie/"+ this.nomImage)
          ],
        ),*/
      ),
    );

    /// Variable item Discount with Card
    var _itemDiscount = Container(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              ///
              ///
              /// check the condition if image data from server firebase loaded or no
              /// if image true (image still downloading from server)
              /// Card to set card loading animation
              ///
              ///
              child: loadImage? _imageLoading(context):
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
                    height: MediaQuery.of(context).size.height,
                     child : Container(
                        height: MediaQuery.of(context).size.height - 250,
                         padding: EdgeInsets.only(bottom: 430),
                         child :Center(child :CircularProgressIndicator() )))  ;
               }
            }
          )  
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed:(){
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new searchAppbar()));
            },
            icon: Icon(Icons.search, color: Color(0xFFCD0007)),
          ),
        ],
        centerTitle: true,
        title: Text(
          this.titre,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFFCD0007),
        ),
        elevation: 0.0,
      ),
      /// For call a variable include to body
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _imageSlider,
              _itemDiscount,
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








