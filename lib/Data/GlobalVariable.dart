import 'package:flutter/cupertino.dart';
import 'package:gociapp/Data/Model/Panier.dart';
//String baseUrl = "http://192.168.43.209:8000/api/";
String baseUrl = "http://apikeys.g0ci.com/api/";
List<String> listeImage = new  List();
int curentPageIndex = 0;
List<String> currencies = [
  "Adjame","Abobo",
  "Koumassi","Marcory",
  "Treichville","Port-Bouet",
  "Zone 4","Zone 3","Cocody",
  "Plateau","Attecoube",
  "Yopougon","Bingerville",
  "Adzopé", "Azaguié",
  "Aboisso" , "Abengourou",
  "Agnibilékrou", "Akoupé",
  "Bonoua","Bouaké" ,
  "Bangolo","Biankouma" ,
  "Bouaflé","Boudiali",
  "Bokanda","Béoumi",
  "Bonon" ,"Bongouanou",
  "Bondoukou","Didiévie",
  "Divo","Daoukro",
  "Dimbokro","Duékoué",
  "Daloa","Djébonoua" ,
  "Danané","Dabou",
  "Ferkéssedougou","Grand-Bassam",
  "Gabiadj","Guibéroua",
  "Gagnoa","Issia",
  "Kong","Krindjabo",
  "Katiola","Korhogo",
  "Lakota","Man",
  "Mbengue","Méagui",
  "M’bahiakro" ,"Niankara",
  "Niablé","Oumé" ,
  "Odienné","Ouangolo",
  "San-pédro","Sikensi",
  "Songon","Sakassou",
  "Soubré","Sinfra",
  "Tingréla","Touba",
  "Tafiré","Tiassalé",
  "Tiébissou","Tanda",
  "Vavoua","Yamoussoukro",
  "Zuénoula",
];


int valueItemChart = 0;

Color colorGoci = Color(0xFFCD0007);