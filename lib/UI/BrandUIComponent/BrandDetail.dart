import 'package:flutter/material.dart';
import 'package:gociapp/Data/Api/ZoneAchatApi.dart';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/Data/Model/Boutique.dart';
import 'package:gociapp/Data/Model/BoutiqueProduits.dart';
import 'package:gociapp/Data/Model/Produit.dart';
import 'package:gociapp/UI/HomeUIComponent/DetailProduct.dart';

class brandDetail extends StatefulWidget {
  @override
  /// Get data from FraisDeLivraison.dart (List Item)
  /// Declare class
  final Boutique brand;
  brandDetail(this.brand);
  _brandDetailState createState() => _brandDetailState(brand);
}

class _brandDetailState extends State<brandDetail> {
  /// set key for bottom sheet
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();



  /// Get data from FraisDeLivraison.dart (List Item)
  /// Declare class
  final Boutique brand;
  _brandDetailState(this.brand);
  String notif = "Notifications";

  Future<List<BoutiqueProduits>> listsProduits ;
  double expandedHeight = 180.0;
  ScrollController scrollController = new ScrollController();
  /// To set duration initState auto start if FlashSale Layout open
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listsProduits =  getProduitsByStoreId(this.brand.id.toString());
    scrollController.addListener(() {

    });
  }
  /// https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Artboard%203.png?alt=media&token=dc7f4bf5-8f80-4f38-bb63-87aed9d59b95

  @override
  Widget build(BuildContext context) {
    /// Hero animation for image

    final appBar = AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: colorGoci),
      elevation: 0.1,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            brand.storeName,
            style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontFamily: "Popins",
                fontWeight: FontWeight.w700),
          ),
     ),
    );
    return Scaffold(
      appBar: appBar,
      body:  Container(
        child: SingleChildScrollView(
          child: FutureBuilder<List<BoutiqueProduits>>(
              future: listsProduits,
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  if(snapshot.data.length != 0) {
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
                            (index) => ItemGrid(snapshot.data[index], brand.storeName),
                      ),
                    );
                  }else  {
                    return Center(child : Text('Aucun produit') ) ;
                  }
                }else {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(12, 300, 12, 50),
                    child: Center(child :CircularProgressIndicator() )  ,
                  ) ;
                }
              }
          ),
        ),
      )
    );
  }
}

/// ItemGrid class
class ItemGrid extends StatelessWidget {
  @override
  BoutiqueProduits item;
  String vandorName;
  ItemGrid(this.item, this.vandorName);
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return InkWell(
        onTap: () {
          Produit produit = new Produit(
          id : item.id,poids : item.poids,prix : item.prix,image : item.image,stock : item.stock,regular_price : item.regularPrice
          ,sale_price : item.salePrice,description : item.description,nom : item.nom
          );
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new detailProduk(produit, vandorName: vandorName,),
              transitionDuration: Duration(milliseconds: 900),
              /// Set animation Opacity in route to detailProduk layout
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              }));
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: mediaQueryData.size.height / 5.3,
                        width: 200.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7.0),
                                topRight: Radius.circular(7.0)),

                            image: DecorationImage(
                                image: new NetworkImage(item.image), fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 7.0)),
                  Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child:  Container(child:
                      Center(
                        child: Text(
                          item.nom,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                        height: 100,)
                  ),
                  Padding(padding: EdgeInsets.only(top: 1.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      item.prix + " FCFA",
                      style: TextStyle(
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              item.regularPrice != null? item.regularPrice + " FCFA" : "",
                              style: TextStyle(
                                  fontFamily: "Sans",
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12.0),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )

    );
  }
}


