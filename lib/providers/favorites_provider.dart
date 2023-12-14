
import 'package:cocktail/models/favorite_model.dart';
import 'package:flutter/material.dart';

class FavoritosProvider extends ChangeNotifier {
  List<CocktailFavorito> _favoritos = [];

  List<CocktailFavorito> get favoritos => _favoritos;

  bool esFavorito(String idDrink) {
    return _favoritos.any((favorito) => favorito.idDrink == idDrink);
  }

  void agregarFavorito(CocktailFavorito favorito) {
    _favoritos.add(favorito);
    notifyListeners();
  }

  void quitarFavorito(String idDrink) {
    _favoritos.removeWhere((favorito) => favorito.idDrink == idDrink);
    notifyListeners();
  }
}
