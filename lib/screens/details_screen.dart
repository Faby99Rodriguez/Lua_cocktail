import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocktail/models/cocktail_model.dart';
import 'package:cocktail/providers/cock_provider.dart';
import 'package:flutter/material.dart';


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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cocktail['strDrink'] ?? ''),
      ),
      body: FutureBuilder(
        future: futureCocktailDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return _buildCocktailDetails(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildCocktailDetails(Cocktail cocktailDetails) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: CachedNetworkImage(
              imageUrl: widget.cocktail['strDrinkThumb'] ?? '',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Ingredients:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          _buildIngredientsList(cocktailDetails),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Instructions:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
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
    );
  }

  Widget _buildIngredientsList(Cocktail cocktailDetails) {
    List<Widget> ingredientsWidgets = [];

    for (int i = 1; i <= 15; i++) {
      String ingredient = cocktailDetails.drinks[0]['strIngredient$i'] ?? '';
      String measure = cocktailDetails.drinks[0]['strMeasure$i'] ?? '';

      if (ingredient.isNotEmpty) {
        ingredientsWidgets.add(Text('$measure $ingredient'));
      }
    }

    return Column(children: ingredientsWidgets);
  }
}
