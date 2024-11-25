import 'package:flutter/material.dart';
import 'package:nhp/pro/favourite_provider.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favourite = Provider.of<FavouriteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite"),
      ),
      body: ListView.builder(
          itemCount: favourite.favourite.length,
          itemBuilder: (context, index) {
            final items = favourite.favourite[index];
            return ListTile(
              title: Text(items),
              trailing: IconButton(
                  onPressed: () {
                    favourite.removeFavourite(items);
                  },
                  icon: Icon(Icons.delete)),
            );
          }),
    );
  }
}
