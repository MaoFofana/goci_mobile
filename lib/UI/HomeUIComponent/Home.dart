import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:gociapp/Data/Api/Produits.dart';
import 'package:gociapp/Data/Api/VenteFlash.dart';
import 'package:gociapp/UI/Component/Banniere.dart';
import 'package:gociapp/UI/Component/BrandItem.dart';
import 'package:gociapp/UI/Component/CategoryIconValue.dart';
import 'package:gociapp/UI/Component/CategoryItemValue.dart';
import 'package:gociapp/UI/Component/FlashSaleItem.dart';
import 'package:gociapp/UI/Component/ProductGrid.dart';
import 'package:http/http.dart' as http;
import 'package:gociapp/Data/Model/Produit.dart';
import 'package:gociapp/Data/Model/Slide.dart';
import 'package:gociapp/Data/Model/VenteFlashApi.dart';
import 'package:gociapp/Library/carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:gociapp/UI/HomeUIComponent/AppbarGradient.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

/// Component all widget in home
class _MenuState extends State<Menu> with TickerProviderStateMixin {
  /// Declare class GridItem from HomeGridItemReoomended.dart in folder ListItem
  /// gros-electromenager
  /// petit-electromenager
  bool isStarted = false;
  Future<List>  futurProduits ;
  Future<VenteFlashApi>  _venteFlash;
  Future<List<Produit>> listsProduits ;
  Future<List<Slide>> futureSlide ;
  Future<List<Slide>> futureSlideBanniere ;
  List<Slide> slides = new List();
  List<String> networkImages = new List();
  /// To set duration initState auto start if FlashSale Layout open
  @override
  void initState() {
    super.initState();
    _venteFlash = getVenteFlash();
    listsProduits =  recommander();
    futureSlide = getAllSlide();
  }

  Future<List<Slide>>  getAllSlide() async {
    final response = await http.get("http://apikeys.g0ci.com/api/sliders");


    if(response.statusCode == 200) {

      var  listImage  = json.decode(response.body) as List;
      log(listImage.toString());
       List<Slide> slides = listImage.map<Slide>((m) => Slide.fromJson(m)).toList();
       log(slides.toString());
      List<Slide>  slidesReturn= new List();
      slides.forEach((element) {
        slidesReturn.add(element);
      });
      log("dhddhhdh" +slidesReturn.toString());
       return slidesReturn;
    }
    else {
      throw ('Erreur sur le chargement des fichiers');
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var deviceSize = MediaQuery.of(context).size;
    /// ImageSlider in header
    var imageSlider = Container(
      height: 180.0,
      child:FutureBuilder<List<Slide>>(
        future: futureSlide ,
          builder: (context, snaspshot){
              if(snaspshot.hasData){
                return new Carousel(
                    boxFit: BoxFit.contain,
                    dotColor: Color(0xFF6991C7).withOpacity(0.8),
                    dotBgColor: Colors.transparent,
                    showIndicator: true,
                    dotSize: 3.5,
                    dotSpacing: 16.0,
                    images: snaspshot.data.map<NetworkImage>((e) => new NetworkImage("http://apikeys.g0ci.com/public/storage/"+e.link,)).toList(),
                  ) ;
              }else {
                return Center(child: CircularProgressIndicator());
            }
          })
    );

    /// CategoryIcon Component
    var categoryIcon = Container(
      height: 240,
      color: Colors.white,
      padding: EdgeInsets.only(top: 10.0),
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Categories",
              style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: "Sans",
                  fontWeight: FontWeight.w700),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 0.0, right: 23)),
                CategoryIconValue(
                    tap1: "produit-pour-bebe",
                    icon1: "assets/icon/bb.png",
                    title1: "Produits pour bébé",
                    tap2: "informatique",
                    icon2: "assets/icon/informatique.png",
                    title2: "Informatique"
                ),
                Padding(padding: EdgeInsets.only(top: 3.0, right: 23)),
                CategoryIconValue(
                  tap2: "photo-carmeras",
                  icon2: "assets/icon/camera.png",
                  title2: "Photo & cameras",
                  tap1: "electromenager",
                  icon1: "assets/icon/electromenager.png",
                  title1: "Electromenager",
                ), Padding(padding: EdgeInsets.only(top: 0.0, right: 23)),

                CategoryIconValue(
                  icon1: "assets/icon/epicerie.png",
                  tap1: "epicerie",
                  title1: "Epicerie",
                  icon2: "assets/icon/maisonbureau.png",
                  tap2: "maison-bureau",
                  title2: "Maison et bureau",
                ),
                Padding(padding: EdgeInsets.only(top: 23.0, right: 23)),
                CategoryIconValue(
                  icon1: "assets/icon/telephone.png",
                  tap1: "telephone-portable",
                  title1: "Téléphone et tablette",
                  tap2: "electronique",
                  icon2: "assets/icon/electronique.png",
                  title2: "Electronique",
                ),
                Padding(padding: EdgeInsets.only(top: 23.0, right: 23)),
                CategoryIconValue(
                  icon1: "assets/icon/jeux.png",
                  tap1: 'jeux-videos-consoles',
                  title1: "Jeux video & Console",
                  icon2: "assets/icon/sante.png",
                  tap2: "beaute-hygiene",
                  title2: "Beauté & Higiène",
                ),
                Padding(padding: EdgeInsets.only(top: 23.0, right: 23)),
                CategoryIconValue(
                  icon1: "assets/icon/entretien.png",
                  tap1: "entretien",
                  title1: "Entretien",
                  icon2: "assets/icon/mode.png",
                  tap2: "mode",
                  title2: "Mode",
                ),
                Padding(padding: EdgeInsets.only(top: 23.0, right: 23)),
                CategoryIconValue(
                  icon1: "assets/icon/accessoire.png",
                  tap1: "epicerie",
                  title1: "Accessoirces",
                  icon2: "assets/icon/maisonbureau.png",
                  tap2: "maison-bureau",
                  title2: "Maison et bureau",
                ),
                Padding(padding: EdgeInsets.only(bottom: 30.0))
              ],
            ),
          ),
        ],
      ),
    );

    /// FlashSale component
    var FlashSell = FutureBuilder<VenteFlashApi>(
        future: _venteFlash,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            VenteFlashApi venteFlashApi = snapshot.data;
            return Container(
                height: 390.0,
                decoration: BoxDecoration(
                /// To set Gradient in flashSale background
                gradient: LinearGradient(colors: [
                Colors.red.withOpacity(0.8),
                  Color(0xFF86A8E7),
                Color(0xFF91EAE4)
              ]),
          ),
          // To set FlashSale Scrolling horizontal
          child:   ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                      EdgeInsets.only(left: mediaQueryData.padding.left + 20),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/img/flashsaleicon.png",
                          height: deviceSize.height * 0.087,
                        ),
                        Text(
                          "Vente",
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Flash",
                          style: TextStyle(
                            fontFamily: "Sans",
                            fontSize: 28.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(top: mediaQueryData.padding.top + 30),
                        ),
                        Text(
                          "Fini dans :",
                          style: TextStyle(
                            fontFamily: "Sans",
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2.0),
                        ),
                        CountdownFormatted(
                          duration: Duration(seconds: venteFlashApi.secondes),
                          builder: (BuildContext ctx, String remaining) {
                            return Text(
                              '$remaining',
                              style: TextStyle(
                              fontFamily: "Sans",
                              fontSize: 19.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),);
                          },
                        ),
                      ],
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 40.0)),
                Container(
                  height: 200,
                  child: Row(
                    children: List.generate(venteFlashApi.produits.length, (index)=>
                        flashSaleItem(
                          produit: venteFlashApi.produits[index],
                        ),),
                  )
                )
                /// Get a component flashSaleItem class

              ],
            ));
          }else  {
           return   Padding(
               padding: EdgeInsets.only(
                   top: 0));
          }
        },
      );


    /// Category Component in bottom of flash sale
    var categorieBanniere = Container(
      height: 120.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 2.0),
            child: CategoryItemValue(
              image: "assets/categorie/Maison.jpg",
              title: "",
              tap: "maison-bureau",
              nomImage: "Maison.jpg",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 1),
            child:  CategoryItemValue(
              image: "assets/categorie/mobile1.jpg",
              title: "",
              tap:"jeux-videos-consoles",
              nomImage: "mobile1.jpg",
            ),
          ),

        ],
      ),
    );


    /// Category Component in bottom of flash sale
    var ZoneAchat = Container(
      height: 190.0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              "Zone d'achat",
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Sans"),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      BrandItem(
                        image: "assets/zone/cocody.jpg",
                        title: "Cocody",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                      ),
                      BrandItem(
                        image: "assets/zone/plateau.jpg",
                        title: "Plateau",
                      ),
                    ],
                  ),
                ),

                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    BrandItem(
                      image: "assets/zone/attecoube.jpg",
                      title: "Attecoubé",
                    )
                  ],
                ),

                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    BrandItem(
                      image: "assets/zone/adjame.jpg",
                      title: "Adjamé",
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    BrandItem(
                      image: "assets/zone/abobo.jpg",
                      title: "Abobo",
                    ),

                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    BrandItem(
                      image: "assets/zone/yopougon.jpg",
                      title: "Yopougon",
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    BrandItem(
                      image: "assets/zone/bingerville.jpg",
                      title: "Bingerville"
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    BrandItem(
                      image: "assets/zone/songon.jpg",
                      title: "Songon",
                    ),

                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    BrandItem(
                      image: "assets/zone/anyama.jpg",
                      title: "Anyama"
                    ),

                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    BrandItem(
                        image: "assets/zone/yopougon.jpg",
                        title: "Yopougon"
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      BrandItem(
                          image: "assets/zone/koumassi.jpg",
                          title: "Koumassi"
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                      ),
                      BrandItem(
                          image: "assets/zone/marcory.jpg",
                          title: "Marcory"
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    BrandItem(
                      image: "assets/zone/port-bouet.jpg",
                      title: "Port-bouet",
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    BrandItem(
                        image: "assets/zone/treichville.jpg",
                        title: "Treichville"
                    ),

                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    BrandItem(
                        image: "assets/zone/zone-3.jpg",
                        title: "Zone 3"
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    BrandItem(
                        image: "assets/zone/zone-4.jpg",
                        title: "Zone 4"
                    ),

                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    BrandItem(
                        image: "assets/zone/treichville.jpg",
                        title: "Treichville"
                    ),

                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    BrandItem(
                        image: "assets/zone/grand-bassam.jpg",
                        title: "Grand-bassam"
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
              ],
            ),
          )
        ],
      ),
    );

    var Banniere = Container(
      height: 310.0,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0,11.0, 0, 0),
        child:  FutureBuilder<List<Slide>>(
            future: futureSlideBanniere,
            builder: (context,snasphost){
              if(snasphost.hasData){
                return ListView(
                  children: List.generate(snasphost.data.length, (index)=> BanniereGoci(image: snasphost.data[index].link,)),
                );
              }else {
                return Center(child: CircularProgressIndicator(),);
              }
            }),
      ),
    );
    ///  Grid item in bottom of Category
    var Grid = Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              "Meilleurs offres",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: FutureBuilder<List<Produit>>(
                future: listsProduits,
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    return ListView(
                      children: List.generate(snapshot.data.length, (index) => ProductGrid(snapshot.data[index])),scrollDirection: Axis.horizontal,);
                  }else {
                    return Center(child :CircularProgressIndicator() ) ;
                  }
                }
            ),
          )
          /// To set GridView item
        ],
      ),
    );

    return Scaffold(
      /// Use Stack to costume a appbar
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: mediaQueryData.padding.top + 58.5)),
                /// Call var imageSlider
                imageSlider,
                /// Call var categoryIcon
                categoryIcon,
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                /// Call var a FlashSell, i am sorry Typo :v
                FlashSell,
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                categorieBanniere,
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                /// Call a Grid variable, this is item list in Recomended item
                Grid,
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                ZoneAchat,
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
               // Banniere
              ],
            ),
          ),

          /// Get a class AppbarGradient
          /// This is a Appbar in home activity
          AppbarGradient(),
        ],
      ),
    );
  }
}

/// Component FlashSaleItem



