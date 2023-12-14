import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocktail/models/cocktail_model.dart';
import 'package:cocktail/services/cock_provider.dart';
import 'package:flutter/material.dart';

// Pantalla de detalles para mostrar información detallada sobre un cóctel
class DetailsScreen extends StatefulWidget {
  // Mapa que representa la información básica del cóctel
  final Map<String, String?> cocktail;
  
  // Servicio para obtener detalles adicionales del cóctel
  final ApiService apiService;

  // Constructor
  DetailsScreen({required this.cocktail, required this.apiService});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // Futuro para almacenar los detalles del cóctel
  late Future<Cocktail> futureCocktailDetails;

  // Método que se ejecuta al inicializar la pantalla
  @override
  void initState() {
    super.initState();
    // Inicializa el futuro para obtener los detalles del cóctel usando el id del cóctel
    futureCocktailDetails = widget.apiService.fetchCocktailDetails(widget.cocktail['idDrink'] ?? '');
  }

  // Método para construir la interfaz de usuario de la pantalla de detalles
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cocktail['strDrink'] ?? ''),
      ),
      body: Container(
        color: Color.fromARGB(255, 2, 75, 88),
        child: FutureBuilder(
          future: futureCocktailDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Muestra un indicador de carga mientras se obtienen los detalles del cóctel
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Muestra un mensaje de error si hay un problema al cargar los detalles
              return Center(child: Text('Error al cargar los detalles: ${snapshot.error}'));
            } else {
              // Construye la interfaz de usuario con los detalles del cóctel
              return _buildCocktailDetails(snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  // Método para construir la interfaz de usuario con los detalles del cóctel
  Widget _buildCocktailDetails(Cocktail cocktailDetails) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Muestra la imagen del cóctel usando CachedNetworkImage
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            child: CachedNetworkImage(
              imageUrl: widget.cocktail['strDrinkThumb'] ?? '',
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          // Sección para mostrar la lista de ingredientes
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
          // Sección para mostrar las instrucciones de preparación
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text('Instructions', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // Muestra las instrucciones de preparación del cóctel
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

  // Método para construir la lista de ingredientes del cóctel
  Widget _buildIngredientsList(Cocktail cocktailDetails) {
    List<Widget> ingredientsWidgets = [];

    // Itera sobre los ingredientes y medidas para construir widgets
    for (int i = 1; i <= 15; i++) {
      String ingredient = cocktailDetails.drinks[0]['strIngredient$i'] ?? '';
      String measure = cocktailDetails.drinks[0]['strMeasure$i'] ?? '';

      if (ingredient.isNotEmpty) {
        // Agrega un widget para mostrar la combinación de medida e ingrediente
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
