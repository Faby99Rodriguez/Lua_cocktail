import 'package:cocktail/models/cocktail_model.dart';
import 'package:cocktail/providers/cock_provider.dart';
import 'package:cocktail/widgets/cocktail_card.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final ApiService apiService;

  SearchScreen({required this.apiService});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  late Future<Cocktail> futureCocktail;

  @override
  void initState() {
    super.initState();
    // Inicialmente, puedes cargar una lista vacía o algún contenido predeterminado.
    futureCocktail = widget.apiService.fetchCocktailsByName('');
  }

  void _searchCocktails(String searchTerm) {
    setState(() {
      futureCocktail = widget.apiService.fetchCocktailsByName(searchTerm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Cocktails'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _searchCocktails,
              decoration: InputDecoration(labelText: 'Enter drink name'),
            ),
            SizedBox(height: 16.0),
            FutureBuilder(
              future: futureCocktail,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.drinks.length ?? 0,
                      itemBuilder: (context, index) {
                      return CocktailCard(cocktail: snapshot.data!.drinks[index], apiService: widget.apiService);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
