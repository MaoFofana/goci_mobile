import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gociapp/Data/Api/Auth.dart';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/Data/Model/User.dart';
import 'package:gociapp/UI/Component/ButtomBlackBottom.dart';
import 'package:gociapp/UI/Component/TextFormField.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';


class settingAcount extends StatefulWidget {
  @override
  _settingAcountState createState() => _settingAcountState();
}

class _settingAcountState extends State<settingAcount> {
  //Edditing controller
  TextEditingController emailController = new TextEditingController();
  TextEditingController nomController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController oldPassword = new TextEditingController();
  TextEditingController newPassword = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  
  //LocalStorage
  LocalStorage storage = new LocalStorage('data');
  ProgressDialog progressDialog ;
  
  var tap = 0;
  String notification = "";
  String passwordNotif;
  String  address = "";

  /// Set AnimationController to initState
  @override
  void initState() {
    emailController.text =  storage.getItem('email');
    nomController.text = storage.getItem("name");
    address = storage.getItem("address") != null ? storage.getItem("address") : "";
    cityController.text = storage.getItem('city');
    phoneController.text = storage.getItem("phone");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context,type: ProgressDialogType.Normal);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.size.height;
    mediaQueryData.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Votre compte",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFFCD0007)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: mediaQueryData.size.height,
          /// Set Background image in layout
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/backgroundgirl.png"),
                fit: BoxFit.cover,
              )),
          child: Container(
            /// Set gradient color in image
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.2),
                  Color.fromRGBO(0, 0, 0, 0.3)
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),
            /// Set component layout
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      alignment: AlignmentDirectional.topCenter,
                      child: Column(
                        children: <Widget>[
                          /// padding logo
                          Padding(
                              padding: EdgeInsets.only(
                                  top:
                                  mediaQueryData.padding.top)),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                /// To set white line (Click to open code)
                                Container(
                                  color: Colors.white,
                                  height: 0.2,
                                  width: 80.0,
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 5.0, right: 5.0),

                                  /// navigation to home screen if user click "OR SKIP" (Click to open code)
                                  child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      "Informations personnelles",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Sans",
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ),

                                /// To set white line (Click to open code)
                                Container(
                                  color: Colors.white,
                                  height: 0.2,
                                  width: 80.0,
                                )
                              ],
                            ),
                          ),
                          Text(
                            '$notification',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Sans"),
                          ),
                          /// TextFromField Email
                          TextFromField(
                            icon: Icons.account_box,
                            password: false,
                            email: "Votre nom",
                            inputType: TextInputType.text,
                            controller: nomController,

                          ),
                          Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: 5.0)),
                          TextFromField(
                            icon: Icons.email,
                            password: false,
                            email: "Votre email",
                            inputType: TextInputType.emailAddress,
                            controller: emailController,
                          ),

                          Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: 5.0)),
                          TextFromField(
                            icon: Icons.phone_android,
                            password: false,
                            email: "Numero de telephone",
                            inputType: TextInputType.number,
                            controller: phoneController,
                          ),

                          Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: 5.0)),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                              height: 60.0,
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.0),
                                  color: Colors.white,
                                  boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
                              padding:
                              EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
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
                                          onChanged: (String newValue) {
                                            setState(() {
                                              address = newValue;
                                              storage.deleteItem("address");
                                              storage.setItem("address", address);
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: currencies.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          value: address.isNotEmpty ? address : null,
                                          hint: Text('Zone géographique'),
                                          isDense: true,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),

                          Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: 5.0)),
                          /// TextFromField Password
                          TextFromField(
                            icon: Icons.add_location,
                            password: false,
                            email: "Quartier ",
                            inputType: TextInputType.text,
                            controller: cityController,
                          ),
                          InkWell(
                              splashColor: Colors.yellow,
                              onTap: () async {
                                progressDialog.update(message: "Modification.........");
                                progressDialog.show();
                                
                                User user = new User(
                                  email: emailController.text,
                                  city: cityController.text,
                                  nom : nomController.text,
                                  address: address,
                                  id: storage.getItem("id") != null ? storage.getItem('id').toString() : null,
                                  phone: phoneController.text
                                );

                                var resultat = await inscriptionOrUpdate(user);
                                progressDialog.hide();
                                if(resultat == "valider"){
                                  setState(()  {
                                    notification = "Modification enregistrer";
                                  });
                                }else {
                                  setState(()  {
                                    notification = "Modification non effectuer";
                                  });
                                }
                                return tap;
                              },
                              child: buttonBlackBottom("Modifier vos information"),)
                        ],
                      ),
                    ),
                  ],
                ),

                /// Set Animaion after user click buttonLogin

              ],
            ),
          ),
        ),
      ),
    );
  }
}

