import 'package:cocktail/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:cocktail/models/cocktail_model.dart';
import 'package:cocktail/services/cock_provider.dart';
import 'package:cocktail/screens/search_screen.dart';
import 'package:cocktail/widgets/cocktail_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final ApiService apiService;

  HomeScreen({required this.apiService});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Cocktail> futureCocktail;

  @override
  void initState() {
    super.initState();
    futureCocktail = widget.apiService.fetchCocktailsByLetter('m');
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktails'),
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
           },
         ),
        //title: Text('Cocktails'),
       // backgroundColor: Color.fromARGB(255, 158, 56, 16),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(apiService: widget.apiService),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Implementa la lógica para el botón de corazón aquí
            },
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Implementa la lógica para el botón de inicio (home) aquí
            },
          ),
        ],
      ),
      body: Container(
        //color: Color.fromARGB(255, 128, 70, 66),//para fondo
        child: FutureBuilder(
          future: futureCocktail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return PageView.builder(
                itemCount: snapshot.data?.drinks.length ?? 0,
                itemBuilder: (context, index) {
                  return CocktailCard(
                    cocktail: snapshot.data!.drinks[index],
                    apiService: widget.apiService,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
