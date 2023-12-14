import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocktail/models/cocktail_model.dart';
import 'package:cocktail/models/favorite_model.dart';
import 'package:cocktail/providers/favorites_provider.dart';
import 'package:cocktail/services/cock_provider.dart'; // Importa el provider
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa provider para usar el Consumer

class DetailsScreen extends StatefulWidget {
  final Map<String, String?> cocktail;
  final ApiService apiService;

  DetailsScreen({required this.cocktail, required this.apiService});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<Cocktail> futureCocktailDetails;

  @override
  void initState() {
    super.initState();
    futureCocktailDetails = widget.apiService.fetchCocktailDetails(widget.cocktail['idDrink'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    // Usa el Consumer para obtener el FavoritosProvider
    return Consumer<FavoritosProvider>(
      builder: (context, favoritosProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.cocktail['strDrink'] ?? ''),
            actions: [
              // Agrega un IconButton para agregar/quitar de favoritos
              IconButton(
                icon: Icon(
                  favoritosProvider.esFavorito(widget.cocktail['idDrink'] ?? '')
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                onPressed: () {
                  // Llama a las funciones de agregar/quitar en base al estado actual
                  if (favoritosProvider.esFavorito(widget.cocktail['idDrink'] ?? '')) {
                    favoritosProvider.quitarFavorito(widget.cocktail['idDrink'] ?? '');
                  } else {
                    // Crea un CocktailFavorito con la información necesaria
                    CocktailFavorito favorito = CocktailFavorito(
                      idDrink: widget.cocktail['idDrink'] ?? '',
                      strDrink: widget.cocktail['strDrink'] ?? '',
                      strDrinkThumb: widget.cocktail['strDrinkThumb'] ?? '',
                    );
                    favoritosProvider.agregarFavorito(favorito);
                  }
                },
              ),
            ],
          ),
          body: Container(
            color: Color.fromARGB(255, 2, 75, 88),
            child: FutureBuilder(
              future: futureCocktailDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error al cargar los detalles: ${snapshot.error}'));
                } else {
                  return _buildCocktailDetails(snapshot.data!);
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCocktailDetails(Cocktail cocktailDetails) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            child: CachedNetworkImage(
              imageUrl: widget.cocktail['strDrinkThumb'] ?? '',
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text('Ingredients', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                ),
                _buildIngredientsList(cocktailDetails),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text('Instructions', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cocktailDetails.drinks[0]['strInstructions'] ?? '',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsList(Cocktail cocktailDetails) {
    List<Widget> ingredientsWidgets = [];

    for (int i = 1; i <= 15; i++) {
      String ingredient = cocktailDetails.drinks[0]['strIngredient$i'] ?? '';
      String measure = cocktailDetails.drinks[0]['strMeasure$i'] ?? '';

      if (ingredient.isNotEmpty) {
        ingredientsWidgets.add(
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.blueGrey)),
            ),
            child: Text('$measure $ingredient', style: TextStyle(fontSize: 16.0)),
          ),
        );
      }
    }

    return Column(children: ingredientsWidgets);
  }
}
