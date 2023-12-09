import 'package:cocktail/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocktail/providers/cock_provider.dart';

class CocktailCard extends StatelessWidget {
  final Map<String, String?> cocktail;
  final ApiService apiService;

  CocktailCard({required this.cocktail, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// class CocktailCard extends StatelessWidget {
//   final Map<String, String?> cocktail;
//   final ApiService apiService;

//   CocktailCard({required this.cocktail, required this.apiService});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width * 0.8,
//             height: MediaQuery.of(context).size.height * 0.5,
//             child: CachedNetworkImage(
//               imageUrl: cocktail['strDrinkThumb'] ?? '',
//               placeholder: (context, url) => CircularProgressIndicator(),
//               errorWidget: (context, url, error) => Icon(Icons.error),
//             ),
//           ),
//           SizedBox(height: 16.0),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               cocktail['strDrink'] ?? '',
//               style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           // Puedes agregar más detalles aquí, como ingredientes, etc.
//         ],
//       ),
//     );
//   }
// }



// //gordo
// // class CocktailCard extends StatelessWidget {
// //   final Map<String, String?> cocktail;
// //   final ApiService apiService;

// //   CocktailCard({required this.cocktail, required this.apiService});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       child: Center(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Container(
// //               width: MediaQuery.of(context).size.width * 0.8,
// //               height: MediaQuery.of(context).size.height * 0.5,
// //               child: CachedNetworkImage(
// //                 imageUrl: cocktail['strDrinkThumb'] ?? '',
// //                 placeholder: (context, url) => CircularProgressIndicator(),
// //                 errorWidget: (context, url, error) => Icon(Icons.error),
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(80.0),
// //               child: Text(
// //                 cocktail['strDrink'] ?? '',
// //                 style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
