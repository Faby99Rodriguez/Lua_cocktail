import 'package:cocktail/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cocktail/models/cocktail_model.dart'; // Asegúrate de importar el modelo correcto

class FavoritosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: Consumer<FavoritosProvider>(
        builder: (context, favoritosProvider, _) {
          final favoritos = favoritosProvider.favoritos;

          if (favoritos.isEmpty) {
            return Center(
              child: Text('No hay favoritos'),
            );
          }

          return ListView.builder(
            itemCount: favoritos.length,
            itemBuilder: (context, index) {
              final cocktail = favoritos[index];

              return ListTile(
                title: Text(cocktail.strDrink ?? ''),
                leading: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(cocktail.strDrinkThumb ?? ''),
                    ),
                  ),
                ),
                // Puedes personalizar el diseño del elemento de la lista aquí
              );
            },
          );
        },
      ),
    );
  }
}
