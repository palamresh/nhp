import 'package:flutter/material.dart';
import 'package:nhp/pro/favourite_provider.dart';
import 'package:nhp/pro/screen/favourite_screen.dart';
import 'package:provider/provider.dart';

class FavouriteItemScreen extends StatefulWidget {
  const FavouriteItemScreen({super.key});

  @override
  State<FavouriteItemScreen> createState() => _FavouriteItemScreenState();
}

class _FavouriteItemScreenState extends State<FavouriteItemScreen> {
  final List<String> items = [
    'Apple',
    'Banana',
    'Orange',
    'Grapes',
    'Mango',
  ];

  @override
  void initState() {
    Future.microtask(() {
      context.read<FavouriteProvider>().loadFavourite();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("FavouriteItemScreen"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavouriteScreen()));
              },
              icon: Icon(Icons.favorite))
        ],
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final isFavourite = provider.favourite.contains(items[index]);
            return ListTile(
              trailing: IconButton(
                  onPressed: () {
                    if (isFavourite) {
                      provider.removeFavourite(items[index]);
                    } else {
                      provider.addFavourite(items[index]);
                    }
                  },
                  icon: Icon(
                      color: isFavourite ? Colors.red : null,
                      isFavourite ? Icons.favorite : Icons.favorite_outline)),
              title: Text(items[index]),
            );
          }),
    );
  }
}
