import 'package:flutter/material.dart';
import 'package:food_delivery/models/food_items.dart';

class favoritesPage extends StatefulWidget {
  const favoritesPage({super.key});

  @override
  State<favoritesPage> createState() => _favoritesPageState();
}

class _favoritesPageState extends State<favoritesPage> {
  @override
  Widget build(BuildContext context) {
    final favoriteFood = food.where((food) => food.isFavorite).toList();
    return Scaffold(
      body: favoriteFood.isEmpty?
      Center(child: Text('No favorites addedgit'),)
          : ListView.builder(
              itemCount: favoriteFood.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(favoriteFood[index].imgUrl,
                            height: 100, width: 70, fit: BoxFit.fill),
                        title: Text(
                          favoriteFood[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            '${favoriteFood[index].category} - \$${favoriteFood[index].price}'),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              favoriteFood[index] = favoriteFood[index]
                                  .copyWith(
                                      isFavorite:
                                          !favoriteFood[index].isFavorite);

                              final selectedFoodItem = food.firstWhere(
                                  (item) => item.id == favoriteFood[index].id);

                              final selectedFoodItemIndex =
                                  food.indexOf(selectedFoodItem);

                              food[selectedFoodItemIndex] = favoriteFood[index];
                            });
                          },
                          icon: Icon(Icons.favorite),
                          color: Colors.orangeAccent,
                        ),
                      )),
                );
              },
            ),
    );
  }
}
