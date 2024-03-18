import 'package:flutter/material.dart';
import 'package:food_delivery/models/category_items.dart';
import 'package:food_delivery/models/food_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? selectedCategoryIndex;
  late List<FoodItems> filteredFood;

  @override
  void initState() {
    super.initState();
    filteredFood = food;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.menu),
                        )),
                  ),
                  const Column(
                    children: [
                      Text(
                        'current location',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Tulkarm, Palestine',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.notifications),
                      )),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://www.shutterstock.com/image-vector/delicious-homemade-burger-chili-bbq-600nw-1804330342.jpg',
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                  ),
                  hintText: 'find your food...',
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (selectedCategoryIndex == null ||
                                selectedCategoryIndex != index) {
                              // setState(() {
                              selectedCategoryIndex = index;
                              // });
                            } else {
                              selectedCategoryIndex = null;
                              filteredFood = food;
                            }
                          });
                          if (selectedCategoryIndex != null) {
                            final selectedCategory =
                                categories[selectedCategoryIndex!];
                            filteredFood = food.where((foodItem) => foodItem.category == selectedCategory.name).toList();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: index == selectedCategoryIndex
                                ? Colors.orangeAccent
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  categories[index].assetPath,
                                  height: 50,
                                  color: index == selectedCategoryIndex
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  categories[index].name,
                                  style: TextStyle(
                                    color: index == selectedCategoryIndex
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                ),
                itemCount: filteredFood.length,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        children: [
                          Image.network(
                            filteredFood[index].imgUrl,
                            height: 85,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            filteredFood[index].name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            filteredFood[index].category,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '\$ ${filteredFood[index].price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      PositionedDirectional(
                          top: 0,
                          end: 0,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                filteredFood[index] = filteredFood[index].copyWith(isFavorite: !filteredFood[index].isFavorite);

                                final selectedFoodItem = food.firstWhere((item) => item.id == filteredFood[index].id);

                                final selectedFoodItemIndex = food.indexOf(selectedFoodItem);

                                food[selectedFoodItemIndex] = filteredFood[index];
                              });
                            },
                            icon: Icon(
                              filteredFood[index].isFavorite == false
                                  ? Icons.favorite_border
                                  : Icons.favorite,
                              color: Colors.deepOrange,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
