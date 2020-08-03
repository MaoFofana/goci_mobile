import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gociapp/Data/Api/OrderApi.dart';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/Data/Model/FraisDeLivraison.dart';
import 'package:gociapp/Data/Model/SendCommand.dart';
import 'package:gociapp/UI/AcountUIComponent/MyOrders.dart';
import 'package:gociapp/UI/BottomNavigationBar.dart';
import 'package:gociapp/UI/Component/TextFormField.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';

class delivery extends StatefulWidget {
  SendCommand sendCommand;
  delivery({this.sendCommand});
  @override
  _deliveryState createState() => _deliveryState(this.sendCommand);
}

class _deliveryState extends State<delivery> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController nomController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  LocalStorage dataStorage = new LocalStorage("data");
  LocalStorage panierStorage  = new LocalStorage('panier');
  bool commandeSend;
  SendCommand sendCommand;
  String notification;
  String   addresse = "";
  ProgressDialog progressDialog ;

  _deliveryState(this.sendCommand);
  static var _txtCustom = TextStyle(
    color: Colors.black54,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Gotik",
  );
  @override
  void initState() {
      notification = "";
      this.commandeSend = false;
      if(dataStorage.getItem("id") != null){
        emailController.text =  dataStorage.getItem('email');
        nomController.text = dataStorage.getItem("name");
        cityController.text = dataStorage.getItem('city');
        numberController.text = dataStorage.getItem("phone");
      }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    progressDialog = new ProgressDialog(context,type: ProgressDialogType.Normal);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                      new bottomNavigationBar()));
            },
            child: Icon(Icons.arrow_back)),
        elevation: 0.0,
        title: Text(
          "Information personnelle",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
         iconTheme : IconThemeData(color: Color(0xFFCD0007)),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: mediaQueryData.size.height + 210.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 0.0, right: 0.0),
            child:commandeSend == false ? Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30.0 , right: 5.0),
                  child: Text(
                    "Donnez-nous les informations neccessaire pour la livraison",
                    style: TextStyle(
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Colors.black54,
                        fontFamily: "Gotik"),
                  ) ,
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                TextFromField(
                  icon: Icons.person,
                  password: false,
                  email: "Nom et prenom",
                  inputType: TextInputType.text,
                  controller: nomController,
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFromField(
                  icon: Icons.email,
                  password: false,
                  email: "Votre email",
                  inputType: TextInputType.emailAddress,
                  controller: emailController,
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFromField(
                  icon: Icons.person,
                  password: false,
                  email: "Numero",
                  inputType: TextInputType.number,
                  controller: numberController,
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    height: 60.0,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white,
                        boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
                    padding: const EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.transparent,
                      ),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              labelText: "Zone géographique",
                              labelStyle: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Sans',
                                  letterSpacing: 0.3,
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w600),
                              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    addresse = newValue;
                                    sendCommand.shipping = 0.0;
                                    //Je fais le tours des tarif
                                    fraisDeLivraisonData.forEach((frais) {
                                      //Je verifie si les lieux sont egaux
                                      frais.lieux.forEach((lieu) {
                                        if(lieu == newValue){
                                            // je verifie si le poids du plus lours produit remplie les conditions
                                            if((sendCommand.poids <= frais.detailsLieu.max) && (sendCommand.poids >= frais.detailsLieu.min)){
                                              //s'il remplie les conditiion allord le frais principale est le prox du frais du lieux
                                              sendCommand.shipping =  (sendCommand.shipping + frais.detailsLieu.prix);
                                            }
                                            // je fais le tours des articles
                                            sendCommand.orderContent.paniers.forEach((elementArticle) {
                                              double poidsArticle = double.parse(elementArticle.produit.poids);
                                              // je verifie a qu'elle poids  correspond le poids d'un article
                                              if((poidsArticle <= frais.detailsLieu.max) && (poidsArticle >= frais.detailsLieu.min)){
                                                //j'ajoute les frais des article de meme nature en multipliant le prix fois la quantite
                                                sendCommand.shipping += (elementArticle.quantite * frais.detailsLieu.parAticle);
                                              }

                                            });


                                        }

                                      });

                                    });
                                    state.didChange(newValue);
                                  });
                                },
                                items: currencies.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                value: addresse.isNotEmpty ? addresse : null,
                                hint: Text('Zone géographique'),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFromField(
                  icon: Icons.add_location,
                  password: false,
                  email: "Votre quartier",
                  inputType: TextInputType.text,
                  controller: cityController,
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                (  dataStorage.getItem("id") == null )?
                TextFromField(
                  icon: Icons.vpn_key,
                  password: true,
                  email: "Cree un mot de passe",
                  inputType: TextInputType.text,
                  controller: passwordController,
                ) : Text(""),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                  child: Container(
                    height:230,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.1),
                            blurRadius: 4.5,
                            spreadRadius: 1.0,
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.monetization_on, size: 34,color: Colors.red,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Produits : " +sendCommand.orderContent.total.toString() + " FCFA",
                              style: _txtCustom.copyWith(
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5.0)),
                            Text(
                              "Frais : " + sendCommand.shipping.toString() + " FCFA" ,
                              style: _txtCustom.copyWith(
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5.0)),
                            Text(
                              "Total : "  + (sendCommand.orderContent.total + sendCommand.shipping).toString() + " FCFA",
                              style: _txtCustom.copyWith(
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5.0)),

                            Padding(padding: EdgeInsets.only(top: 2.0)),
                            Text(
                              "Vos données personnelles seront \n utilisées pour appuyer votre "
                                  "\nexpérience sur ce notre plateforme\n E-Commerce"
                                  ", pour gérer l'accès\n à votre compte et à"
                                  " d'autres fins \ndécrites dans "
                                  "notre politique de\n confidentialité.\n En envoyant votre commande\n vous acceptez"
                                  " notre polititique \nde confidentialité ",
                              style: _txtCustom.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0,
                                  color: Colors.black38),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                notification != null ?Text(notification.toString()) : Text(''),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                InkWell(
                  onTap: () async {
                    sendCommand.password = passwordController.text;
                    sendCommand.city = cityController.text;
                    sendCommand.address = addresse;
                    sendCommand.phone = numberController.text;
                    sendCommand.email = emailController.text;
                    sendCommand.name = nomController.text;
                    sendCommand.total = (sendCommand.shipping + sendCommand.orderContent.total).toString();
                    progressDialog.update(message: "Envoie de la commande..........");
                    progressDialog.show();
                    var resultat = await sendOrder(sendCommand);
                    progressDialog.hide();
                      if(resultat == "valider"){
                        setState(() {
                          this.commandeSend = true;
                          notification = "Commande valider avec success";
                        });
                      }else {
                        setState(() {
                          notification = resultat;
                        });
                      }

                  },
                  child: Container(
                    height: 55.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                        color: colorGoci,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Center(
                      child: Text(
                        "Envoyer la commande",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.5,
                            letterSpacing: 1.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,)
              ],
            ) : Padding(
              padding: const EdgeInsets.only(
                  top: 48.0, bottom: 30.0, left: 25.0, right: 25.0),
                child:Center(
                  child: Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset("assets/img/bag.png"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Votre commande a été envoyez",
                                style: _txtCustom.copyWith(
                                    fontWeight: FontWeight.w700),
                              ),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
                              Text(
                                "Nous vous ferons un retour bientot" ,
                                style: _txtCustom.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                    color: Colors.black38),
                              ),
                              Padding(padding: EdgeInsets.only(top: 7.0)),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Cliqué ici pour voir votre commandes" ,
                                    style: _txtCustom.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                        color: Colors.black38),
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      Navigator.of(context).push(PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => new order()));
                                    },
                                    icon: Icon(Icons.arrow_forward, size: 35.0, color: colorGoci,),
                                  ),
                                ],
                              )

                            ],
                          )
                        ],
                      )
                  ),
                )
              ),
          ),
        ),
      ),
    );
  }
}
