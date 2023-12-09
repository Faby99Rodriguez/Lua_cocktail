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
}

