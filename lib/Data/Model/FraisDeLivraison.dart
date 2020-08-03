import 'dart:core';

class FraisDeLivraison {
  final List<String> lieux;
  final DetailLieu detailsLieu;

  const FraisDeLivraison({
    this.detailsLieu,
    this.lieux
  });
}


class DetailLieu {
  final double min ;
  final double max;
  final int prix;
  final int parAticle;

  DetailLieu({this.min, this.max, this.prix, this.parAticle});
}

List<FraisDeLivraison> fraisDeLivraisonData = [
  FraisDeLivraison(
    lieux : [
      "Marcory","Abobo","Adjame",
      "Treichville","Port-Bouet",
      "Zone 4","Zone 3",
      "Grand-Bassam","Cocody",
      "Plateau","Attecoube",
      "Yopougon","Bingerville","Songon"
    ],
    detailsLieu:
      DetailLieu(
        min : 0.001,
        max: 2.5,
        prix: 1000,
        parAticle: 400
      )

  ),
  FraisDeLivraison(
      lieux : [
        "Marcory","Abobo","Adjame",
        "Treichville","Port-Bouet",
        "Zone 4","Zone 3",
        "Grand-Bassam","Cocody",
        "Plateau","Attecoube",
        "Yopougon","Bingerville","Songon"
      ],
      detailsLieu:
      DetailLieu(
          min : 2.6,
          max: 10,
          prix: 1500,
          parAticle: 500
      )

  ),
  FraisDeLivraison(
      lieux : [
        "Marcory","Abobo","Adjame",
        "Treichville","Port-Bouet",
        "Zone 4","Zone 3",
        "Grand-Bassam","Cocody",
        "Plateau","Attecoube",
        "Yopougon","Bingerville","Songon"
      ],
      detailsLieu:
      DetailLieu(
          min : 10.1,
          max: 1000000000000000000000000000000000000000000000000000000000000000000000000.0,
          prix: 4500,
          parAticle: 800
      )
  ),
  FraisDeLivraison(
      lieux: ["Koumassi"],
      detailsLieu:
        DetailLieu(
            min : 0.001,
            max: 2.5,
            prix: 1000,
            parAticle: 300
        )

  ),
  FraisDeLivraison(
      lieux: ["Koumassi"],
      detailsLieu:
        DetailLieu(
            min : 2.6,
            max: 10,
            prix: 1500,
            parAticle: 400
        )
  ),
  FraisDeLivraison(
      lieux: ["Koumassi"],
      detailsLieu:
        DetailLieu(
            min : 10.1,
            max: 1000000000000000000000000000000000000000000000000000000000000000000000000.0,
            prix: 3500,
            parAticle: 700
        )
  ),

//Fin Koumassi

  //Abidjan j+2
  FraisDeLivraison(
      lieux : [
        "Aboisso", "Bonoua", "Grand-Bassam", "Agboville","Akoupé", "Anyama","Azaguié", "N'Djem", "N'Douci", "Sikensi", "Songon", "Tiassalé"
      ],
      detailsLieu:
      DetailLieu(
          min : 0.001,
          max: 1,
          prix: 2500,
          parAticle: 0
      )

  ),
  FraisDeLivraison(
      lieux : [
        "Aboisso", "Bonoua", "Grand-Bassam", "Agboville","Akoupé", "Anyama","Azaguié", "N'Djem", "N'Douci", "Sikensi", "Songon", "Tiassalé"
      ],
      detailsLieu:
      DetailLieu(
          min : 1.1,
          max: 3,
          prix: 3500,
          parAticle: 0
      )

  ),
  FraisDeLivraison(
      lieux : [
        "Aboisso", "Bonoua", "Grand-Bassam", "Agboville","Akoupé", "Anyama","Azaguié", "N'Djem", "N'Douci", "Sikensi", "Songon", "Tiassalé"
      ],
      detailsLieu:
      DetailLieu(
          min : 3.1,
          max: 5,
          prix: 4500,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Aboisso", "Bonoua", "Grand-Bassam", "Agboville","Akoupé", "Anyama","Azaguié", "N'Djem", "N'Douci", "Sikensi", "Songon", "Tiassalé"
      ],
      detailsLieu:
      DetailLieu(
          min : 5.1,
          max: 10,
          prix: 5500,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Aboisso", "Bonoua", "Grand-Bassam", "Agboville","Akoupé", "Anyama","Azaguié", "N'Djem", "N'Douci", "Sikensi", "Songon", "Tiassalé"
      ],
      detailsLieu:
      DetailLieu(
          min : 10.1,
          max: 20,
          prix: 7500,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Aboisso", "Bonoua", "Grand-Bassam", "Agboville","Akoupé", "Anyama","Azaguié", "N'Djem", "N'Douci", "Sikensi", "Songon", "Tiassalé"
      ],
      detailsLieu:
      DetailLieu(
          min : 20.1,
          max: 30,
          prix: 8500,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Aboisso", "Bonoua", "Grand-Bassam", "Agboville","Akoupé", "Anyama","Azaguié", "N'Djem", "N'Douci", "Sikensi", "Songon", "Tiassalé"
      ],
      detailsLieu:
      DetailLieu(
          min : 30.1,
          max: 40,
          prix: 9500,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Aboisso", "Bonoua", "Grand-Bassam", "Agboville","Akoupé", "Anyama","Azaguié", "N'Djem", "N'Douci", "Sikensi", "Songon", "Tiassalé"
      ],
      detailsLieu:
      DetailLieu(
          min : 40.1,
          max: 50,
          prix: 10000,
          parAticle: 0
      )
  ),

  //Fin Abijan  J+2

  // Debut Principales villes de Côte d'Ivoire en J+2
  FraisDeLivraison(
      lieux : [
        "Meagui","Odienné", "San-Pedro", "Soubré", "Abengourou", "Didiévie","Bokanda","Agnibilékrou", "Daoukro", "Dimbokro", "Divo", "Gagnoa", "Daloa", "Yamoussoukro", "Adzopé", "Duékoué", "Man", "Ferkéssédougou", "Korhogo", "Bouaké", "Séguéla", "Bondoukou"
      ],
      detailsLieu:
      DetailLieu(
          min : 0.001,
          max: 1,
          prix: 3000,
          parAticle: 0
      )

  ),
  FraisDeLivraison(
      lieux : [
        "Meagui","Odienné", "San-Pedro", "Soubré", "Abengourou", "Didiévie","Bokanda","Agnibilékrou", "Daoukro", "Dimbokro", "Divo", "Gagnoa", "Daloa", "Yamoussoukro", "Adzopé", "Duékoué", "Man", "Ferkéssédougou", "Korhogo", "Bouaké", "Séguéla", "Bondoukou"
      ],
      detailsLieu:
      DetailLieu(
          min : 1.1,
          max: 3,
          prix: 4000,
          parAticle: 0
      )

  ),
  FraisDeLivraison(
      lieux : [
        "Meagui","Odienné", "San-Pedro", "Soubré", "Abengourou", "Didiévie","Bokanda","Agnibilékrou", "Daoukro", "Dimbokro", "Divo", "Gagnoa", "Daloa", "Yamoussoukro", "Adzopé", "Duékoué", "Man", "Ferkéssédougou", "Korhogo", "Bouaké", "Séguéla", "Bondoukou"
      ],
      detailsLieu:
      DetailLieu(
          min : 3.1,
          max: 5,
          prix: 5000,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Meagui","Odienné", "San-Pedro", "Soubré", "Abengourou", "Didiévie","Bokanda","Agnibilékrou", "Daoukro", "Dimbokro", "Divo", "Gagnoa", "Daloa", "Yamoussoukro", "Adzopé", "Duékoué", "Man", "Ferkéssédougou", "Korhogo", "Bouaké", "Séguéla", "Bondoukou"
      ],
      detailsLieu:
      DetailLieu(
          min : 5.1,
          max: 10,
          prix: 6000,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Meagui","Odienné", "San-Pedro", "Soubré", "Abengourou", "Didiévie","Bokanda","Agnibilékrou", "Daoukro", "Dimbokro", "Divo", "Gagnoa", "Daloa", "Yamoussoukro", "Adzopé", "Duékoué", "Man", "Ferkéssédougou", "Korhogo", "Bouaké", "Séguéla", "Bondoukou"
      ],
      detailsLieu:
      DetailLieu(
          min : 10.1,
          max: 20,
          prix: 8000,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Meagui","Odienné", "San-Pédro", "Soubré", "Abengourou", "Didiévie","Bokanda","Agnibilékrou", "Daoukro", "Dimbokro", "Divo", "Gagnoa", "Daloa", "Yamoussoukro", "Adzopé", "Duékoué", "Man", "Ferkéssédougou", "Korhogo", "Bouaké", "Séguéla", "Bondoukou"
      ],
      detailsLieu:
      DetailLieu(
          min : 20.1,
          max: 30,
          prix: 8500,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Meagui","Odienné", "San-Pédro", "Soubré", "Abengourou", "Didiévie","Bokanda","Agnibilékrou", "Daoukro", "Dimbokro", "Divo", "Gagnoa", "Daloa", "Yamoussoukro", "Adzopé", "Duékoué", "Man", "Ferkéssédougou", "Korhogo", "Bouaké", "Séguéla", "Bondoukou"
      ],
      detailsLieu:
      DetailLieu(
          min : 30.1,
          max: 40,
          prix: 10500,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Meagui","Odienné", "San-Pédro", "Soubré", "Abengourou", "Didiévie","Bokanda","Agnibilékrou", "Daoukro", "Dimbokro", "Divo", "Gagnoa", "Daloa", "Yamoussoukro", "Adzopé", "Duékoué", "Man", "Ferkéssédougou", "Korhogo", "Bouaké", "Séguéla", "Bondoukou"
      ],
      detailsLieu:
      DetailLieu(
          min : 40.1,
          max: 50,
          prix: 11000,
          parAticle: 0
      )
  ),
  //Fin Principales villes de cote d'ivoire en J +2

  //Debut villes secondaire
  FraisDeLivraison(
      lieux : [
        "Boudiali","Niankara","M’bahiakro","Méagui","Mbengue","Krindjabo", "Gabiadj","Ferkéssedougou","Ferkéssedougou","Dabou","Djébonoua","Adiaké","Ouangolo","Sakassou","Tiébissou","Zuénoula", "Aniassué", "Bangolo", "Béoumi", "Biankouma", "Bloléquin", "Bongouanou", "Bonon", "Botro", "Bouaflé", "Bouna", "Boundiali", "Danané", "N'Djébonoua", "Gabiadji", "Grand-Lahou", "Guibéroua",
        "Guiglo", "Guitri", "Issia", "Kani", "Kasséré", "Katiola", "Kong", "Kononfla", "Koun Fao", "Kouto", "Lakota", "M'Bemgué", "Madiani", "Mahapleu", "Niablé", "Niakaramadougou", "Odiéné", "Ouangolodougou",
        "Oumé", "Saioua", "Sangouine", "Sinfra", "Tabou", "Tafiré", "Tanda", "Tiebissou", "Tingréla", "Touba", "Toulépleu", "Toumodi", "Vavoua", "Zouan-Houien" ,"Zoukougbeu", "Zuenoula"
      ],
      detailsLieu:
      DetailLieu(
          min : 0.001,
          max: 1,
          prix: 3500,
          parAticle: 0
      )

  ),
  FraisDeLivraison(
      lieux : [
        "Boudiali","Niankara","M’bahiakro","Méagui","Mbengue","Krindjabo", "Gabiadj","Ferkéssedougou","Ferkéssedougou","Dabou","Djébonoua","Adiaké","Ouangolo","Sakassou","Tiébissou","Zuénoula", "Aniassué", "Bangolo", "Béoumi", "Biankouma", "Bloléquin", "Bongouanou", "Bonon", "Botro", "Bouaflé", "Bouna", "Boundiali", "Danané", "N'Djébonoua", "Gabiadji", "Grand-Lahou", "Guibéroua",
        "Guiglo", "Guitri", "Issia", "Kani", "Kasséré", "Katiola", "Kong", "Kononfla", "Koun Fao", "Kouto", "Lakota", "M'Bemgué", "Madiani", "Mahapleu", "Niablé", "Niakaramadougou", "Odiéné", "Ouangolodougou",
        "Oumé", "Saioua", "Sangouine", "Sinfra", "Tabou", "Tafiré", "Tanda", "Tiebissou", "Tingréla", "Touba", "Toulépleu", "Toumodi", "Vavoua", "Zouan-Houien" ,"Zoukougbeu", "Zuenoula"
      ],
      detailsLieu:
      DetailLieu(
          min : 1.1,
          max: 3,
          prix: 4500,
          parAticle: 0
      )

  ),
  FraisDeLivraison(
      lieux : [
        "Boudiali","Niankara","M’bahiakro","Méagui","Mbengue","Krindjabo", "Gabiadj","Ferkéssedougou","Ferkéssedougou","Dabou","Djébonoua","Adiaké","Ouangolo","Sakassou","Tiébissou","Zuénoula", "Aniassué", "Bangolo", "Béoumi", "Biankouma", "Bloléquin", "Bongouanou", "Bonon", "Botro", "Bouaflé", "Bouna", "Boundiali", "Danané", "N'Djébonoua", "Gabiadji", "Grand-Lahou", "Guibéroua",
        "Guiglo", "Guitri", "Issia", "Kani", "Kasséré", "Katiola", "Kong", "Kononfla", "Koun Fao", "Kouto", "Lakota", "M'Bemgué", "Madiani", "Mahapleu", "Niablé", "Niakaramadougou", "Odiéné", "Ouangolodougou",
        "Oumé", "Saioua", "Sangouine", "Sinfra", "Tabou", "Tafiré", "Tanda", "Tiebissou", "Tingréla", "Touba", "Toulépleu", "Toumodi", "Vavoua", "Zouan-Houien" ,"Zoukougbeu", "Zuenoula"
      ],
      detailsLieu:
      DetailLieu(
          min : 3.1,
          max: 5,
          prix: 5500,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Boudiali","Niankara","M’bahiakro","Méagui","Mbengue","Krindjabo", "Gabiadj","Ferkéssedougou","Ferkéssedougou","Dabou","Djébonoua","Adiaké","Ouangolo","Sakassou","Tiébissou","Zuénoula", "Aniassué", "Bangolo", "Béoumi", "Biankouma", "Bloléquin", "Bongouanou", "Bonon", "Botro", "Bouaflé", "Bouna", "Boundiali", "Danané", "N'Djébonoua", "Gabiadji", "Grand-Lahou", "Guibéroua",
        "Guiglo", "Guitri", "Issia", "Kani", "Kasséré", "Katiola", "Kong", "Kononfla", "Koun Fao", "Kouto", "Lakota", "M'Bemgué", "Madiani", "Mahapleu", "Niablé", "Niakaramadougou", "Odiéné", "Ouangolodougou",
        "Oumé", "Saioua", "Sangouine", "Sinfra", "Tabou", "Tafiré", "Tanda", "Tiebissou", "Tingréla", "Touba", "Toulépleu", "Toumodi", "Vavoua", "Zouan-Houien" ,"Zoukougbeu", "Zuenoula"
      ],
      detailsLieu:
      DetailLieu(
          min : 5.1,
          max: 10,
          prix: 6500,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Boudiali","Niankara","M’bahiakro","Méagui","Mbengue","Krindjabo", "Gabiadj","Ferkéssedougou","Ferkéssedougou","Dabou","Djébonoua","Adiaké","Ouangolo","Sakassou","Tiébissou","Zuénoula", "Aniassué", "Bangolo", "Béoumi", "Biankouma", "Bloléquin", "Bongouanou", "Bonon", "Botro", "Bouaflé", "Bouna", "Boundiali", "Danané", "N'Djébonoua", "Gabiadji", "Grand-Lahou", "Guibéroua",
        "Guiglo", "Guitri", "Issia", "Kani", "Kasséré", "Katiola", "Kong", "Kononfla", "Koun Fao", "Kouto", "Lakota", "M'Bemgué", "Madiani", "Mahapleu", "Niablé", "Niakaramadougou", "Odiéné", "Ouangolodougou",
        "Oumé", "Saioua", "Sangouine", "Sinfra", "Tabou", "Tafiré", "Tanda", "Tiebissou", "Tingréla", "Touba", "Toulépleu", "Toumodi", "Vavoua", "Zouan-Houien" ,"Zoukougbeu", "Zuenoula"
      ],
      detailsLieu:
      DetailLieu(
          min : 10.1,
          max: 20,
          prix: 9000,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Boudiali","Niankara","M’bahiakro","Méagui","Mbengue","Krindjabo", "Gabiadj","Ferkéssedougou","Ferkéssedougou","Dabou","Djébonoua","Adiaké","Ouangolo","Sakassou","Tiébissou","Zuénoula", "Aniassué", "Bangolo", "Béoumi", "Biankouma", "Bloléquin", "Bongouanou", "Bonon", "Botro", "Bouaflé", "Bouna", "Boundiali", "Danané", "N'Djébonoua", "Gabiadji", "Grand-Lahou", "Guibéroua",
        "Guiglo", "Guitri", "Issia", "Kani", "Kasséré", "Katiola", "Kong", "Kononfla", "Koun Fao", "Kouto", "Lakota", "M'Bemgué", "Madiani", "Mahapleu", "Niablé", "Niakaramadougou", "Odiéné", "Ouangolodougou",
        "Oumé", "Saioua", "Sangouine", "Sinfra", "Tabou", "Tafiré", "Tanda", "Tiebissou", "Tingréla", "Touba", "Toulépleu", "Toumodi", "Vavoua", "Zouan-Houien" ,"Zoukougbeu", "Zuenoula"
      ],
      detailsLieu:
      DetailLieu(
          min : 20.1,
          max: 30,
          prix: 9500,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Boudiali","Niankara","M’bahiakro","Méagui","Mbengue","Krindjabo", "Gabiadj","Ferkéssedougou","Ferkéssedougou","Dabou","Djébonoua","Adiaké","Ouangolo","Sakassou","Tiébissou","Zuénoula", "Aniassué", "Bangolo", "Béoumi", "Biankouma", "Bloléquin", "Bongouanou", "Bonon", "Botro", "Bouaflé", "Bouna", "Boundiali", "Danané", "N'Djébonoua", "Gabiadji", "Grand-Lahou", "Guibéroua",
        "Guiglo", "Guitri", "Issia", "Kani", "Kasséré", "Katiola", "Kong", "Kononfla", "Koun Fao", "Kouto", "Lakota", "M'Bemgué", "Madiani", "Mahapleu", "Niablé", "Niakaramadougou", "Odiéné", "Ouangolodougou",
        "Oumé", "Saioua", "Sangouine", "Sinfra", "Tabou", "Tafiré", "Tanda", "Tiebissou", "Tingréla", "Touba", "Toulépleu", "Toumodi", "Vavoua", "Zouan-Houien" ,"Zoukougbeu", "Zuenoula"
      ],
      detailsLieu:
      DetailLieu(
          min : 30.1,
          max: 40,
          prix: 12500,
          parAticle: 0
      )
  ),
  FraisDeLivraison(
      lieux : [
        "Boudiali","Niankara","M’bahiakro","Méagui","Mbengue","Krindjabo", "Gabiadj","Ferkéssedougou","Dabou","Djébonoua","Adiaké","Ouangolo","Sakassou","Tiébissou","Zuénoula", "Aniassué", "Bangolo", "Béoumi", "Biankouma", "Bloléquin", "Bongouanou", "Bonon", "Botro", "Bouaflé", "Bouna", "Boundiali", "Danané", "N'Djébonoua", "Gabiadji", "Grand-Lahou", "Guibéroua",
        "Guiglo", "Guitri", "Issia", "Kani", "Kasséré", "Katiola", "Kong", "Kononfla", "Koun Fao", "Kouto", "Lakota", "M'Bemgué", "Madiani", "Mahapleu", "Niablé", "Niakaramadougou", "Odiéné", "Ouangolodougou",
        "Oumé", "Saioua", "Sangouine", "Sinfra", "Tabou", "Tafiré", "Tanda", "Tiebissou", "Tingréla", "Touba", "Toulépleu", "Toumodi", "Vavoua", "Zouan-Houien" ,"Zoukougbeu", "Zuenoula"
      ],
      detailsLieu:
      DetailLieu(
          min : 40.1,
          max: 50,
          prix: 13000,
          parAticle: 0
      )
  ),

  //fin villes secondaire
];