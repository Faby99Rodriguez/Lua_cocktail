import 'package:cocktail/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocktail/services/cock_provider.dart';

class CocktailCard extends StatelessWidget {
  final Map<String, String?> cocktail;
  final ApiService apiService;

  CocktailCard({required this.cocktail, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 163, 136, 48), // Puedes cambiar el color según tu preferencia
      //color: Color.fromARGB(255, 2, 75, 88),
      //elevation: 100, // Agrega sombra para resaltar el card
      child: InkWell(
        onTap: () {
          // Navegar a la pantalla de detalles cuando se hace clic
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(cocktail: cocktail, apiService: apiService),
            ),
          );
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
                child: CachedNetworkImage(
                  imageUrl: cocktail['strDrinkThumb'] ?? '',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(80.0),
                child: Text(
                  cocktail['strDrink'] ?? '',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}