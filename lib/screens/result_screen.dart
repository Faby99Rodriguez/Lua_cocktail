import 'package:cocktail/models/cocktail_model.dart';
import 'package:cocktail/providers/cock_provider.dart';
import 'package:cocktail/widgets/cocktail_card.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchTerm;

  SearchResultScreen({required this.searchTerm});

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final ApiService apiService = ApiService();
  late Future<Cocktail> futureCocktail;

  @override
  void initState() {
    super.initState();
    futureCocktail = apiService.fetchCocktailsByLetter(widget.searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: FutureBuilder(
        future: futureCocktail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.drinks.length ?? 0,
              itemBuilder: (context, index) {
                return CocktailCard(cocktail: snapshot.data!.drinks[index], apiService: apiService);
              },
            );
          }
        },
      ),
    );
  }
}
