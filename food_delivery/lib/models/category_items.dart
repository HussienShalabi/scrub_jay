class CategoryItem {
  final String id;
  final String name;
  final String assetPath;

  CategoryItem({required this.id,required this.name,required this.assetPath});
}

List<CategoryItem> categories = [
  CategoryItem(id: '1', name: 'burger', assetPath: 'assets/images/burger.png'),
  CategoryItem(id: '2', name: 'pizza', assetPath:'assets/images/pizza.png'),
  CategoryItem(id: '3', name: 'pasta', assetPath: 'assets/images/pasta.png'),
  CategoryItem(id: '4', name: 'grilled', assetPath: 'assets/images/grilled.png'),
  CategoryItem(id: '5', name: 'drinks', assetPath: 'assets/images/drinks.png'),
];
