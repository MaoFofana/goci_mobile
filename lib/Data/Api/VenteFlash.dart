import 'dart:convert';
import 'dart:developer';
import 'package:gociapp/Data/GlobalVariable.dart';
import 'package:gociapp/Data/Model/VenteFlashApi.dart';
import 'package:http/http.dart' as http;

Future<VenteFlashApi>  getVenteFlash() async {
  final response = await http.get(baseUrl + "venteflash");
  log(response.body);
  if (response.statusCode == 200) {
    var  venteFlash = json.decode(response.body);
    VenteFlashApi venteFlashApi = VenteFlashApi.fromJson(venteFlash);
    return venteFlashApi ;
  }else {
    return null;
  }

}

