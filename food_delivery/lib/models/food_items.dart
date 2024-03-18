class FoodItems {
  final String id;
  final String name;
  final double price;
  final String imgUrl;
  final String category;
  final bool isFavorite;
  final String estimatedTime;
  final int numberOfSales;

  FoodItems(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.imgUrl,
      this.isFavorite = false,
      this.estimatedTime = '30 Mins',
      this.numberOfSales = 2});

  FoodItems copyWith({bool? isFavorite}) {
    return FoodItems(
      id: id,
      name: name,
      category: category,
      price: price,
      imgUrl: imgUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      estimatedTime: estimatedTime,
      numberOfSales: numberOfSales,
    );
  }
}

List<FoodItems> food = [
  FoodItems(
      id: '1',
      name: 'Beef Burger',
      category: 'burger',
      price: 6.99,
      imgUrl:
          'https://static.vecteezy.com/system/resources/previews/022/598/800/original/tasty-beef-burger-png.png'),
  FoodItems(
      id: '2',
      name: 'chicken Burger',
      category: 'burger',
      price: 6.99,
      imgUrl:
          'https://static.vecteezy.com/system/resources/previews/034/763/818/non_2x/ai-generated-fried-chicken-burger-free-png.png'),
  FoodItems(
      id: '3',
      name: 'grilled chicken',
      category: 'grilled',
      price: 13.99,
      imgUrl:
          'https://i.pinimg.com/originals/93/0c/b3/930cb346ec8724e5672600ae8387f91b.png'),
  FoodItems(
      id: '4',
      name: 'lazania pasta',
      category: 'pasta',
      price: 7.99,
      imgUrl:
          'https://www.grisspasta.com/image.png?v=fca8addf74e68655ceeb7a2a'),
  FoodItems(
      id: '5',
      name: 'margareta pizza',
      category: 'pizza',
      price: 11.99,
      imgUrl:
          'https://upload.wikimedia.org/wikipedia/commons/e/ee/Eq_it-na_pizza-margherita_sep2005_sml-2.png'),
];
