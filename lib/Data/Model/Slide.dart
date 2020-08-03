
class Slide {
  final int id;
  final String link;

  Slide({this.id, this.link});

  factory Slide.fromJson(Map<String , dynamic> json){
    return Slide(
      id : json['id'],
      link : json['link'],
    );
  }
}