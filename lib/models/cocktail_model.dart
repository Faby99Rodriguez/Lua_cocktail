import 'dart:convert';


// Definición de la clase Cocktail
class Cocktail {
  // Lista de mapas que representan bebidas
  List<Map<String, String?>> drinks;

  // Constructor de la clase Cocktail
  Cocktail({
    required this.drinks,
  });

  // Factory constructor para construir una instancia de Cocktail desde una cadena JSON cruda
  factory Cocktail.fromRawJson(String str) => Cocktail.fromJson(json.decode(str));

  // Factory constructor para construir una instancia de Cocktail desde un mapa JSON
  factory Cocktail.fromJson(Map<String, dynamic> json) => Cocktail(
        // Mapeo de la lista de bebidas desde el JSON, convirtiendo cada elemento a un mapa de String a String opcional
        drinks: List<Map<String, String?>>.from(json["drinks"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
      );
}
