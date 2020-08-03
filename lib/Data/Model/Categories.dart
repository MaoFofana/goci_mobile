
import 'package:gociapp/Data/Model/ImageApi.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Categories {
  final int id ;
  final String name;
  final String slug;
  final String  clothing;
  final int parent;
  final String description;
  final ImageApi image;

  Categories(this.id, this.name, this.slug, this.clothing, this.parent, this.description, this.image);

}