import 'dart:convert';
import 'package:cocktail/models/cocktail_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Cocktail> fetchCocktailsByLetter(String letter) async {
    final Uri uri = Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/search.php?f=$letter');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Cocktail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load cocktails');
    }
  }
  
  Future<Cocktail> fetchCocktailsByName(String name) async {
    final Uri uri = Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$name');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Cocktail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load cocktails');
    }
  }


  Future<Cocktail> fetchCocktailDetails(String id) async {
    final Uri uri = Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Cocktail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load cocktail details');
    }
  }

  Future<void> agregarFavorito(String nombre, String imagen) async {
  final response = await http.post(
    Uri.parse('https://ing-salvador.onrender.com/favoritos/agregar'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'nombre': nombre, 'imagen': imagen}),
  );

  if (response.statusCode == 201) {
    // Favorito agregado con éxito
    print('Cocktail favorito agregado correctamente');
  } else {
    // Error al agregar favorito
    print('Error al agregar cocktail favorito: ${response.statusCode}');
  }
}
 
   Future<void> quitarFavorito(String id) async {
  final response = await http.delete(
    Uri.parse('https://ing-salvador.onrender.com/favoritos/quitar/$id'),
  );

  if (response.statusCode == 200) {
    // Favorito eliminado con éxito
    print('Cocktail favorito eliminado correctamente');
  } else {
    // Error al eliminar favorito
    print('Error al quitar cocktail favorito: ${response.statusCode}');
  }
}

}

