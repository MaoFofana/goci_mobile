import 'package:gociapp/Data/Model/OrderContent.dart';

class SendCommand{
  String id;
  String total;
  double shipping;
   double poids;
   OrderContent orderContent;
   String name;
   String address;
   String city;
   String phone;
   String email;
   String password;
  SendCommand({this.id, this.total, this.shipping,this.poids, this.orderContent, this.email, this.name, this.phone, this.address,this.city, this.password});


}