import 'dart:convert';

class Cocktail {
  List<Map<String, String?>> drinks;

  Cocktail({
    required this.drinks,
  });

  factory Cocktail.fromRawJson(String str) => Cocktail.fromJson(json.decode(str));

  factory Cocktail.fromJson(Map<String, dynamic> json) => Cocktail(
        drinks: List<Map<String, String?>>.from(json["drinks"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
      );
}
