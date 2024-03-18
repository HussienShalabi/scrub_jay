import 'package:flutter/material.dart';
import 'package:food_delivery/pages/HomePage.dart';
import 'package:food_delivery/pages/favorites_page.dart';
import 'package:food_delivery/pages/profile_page.dart';
class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int selectedIndex =0 ;
  void onItemTapped (int index){
    setState(() {
      selectedIndex = index ;
    });
  }
  List<Widget> widgetBuilder = [
    HomePage(),
    favoritesPage(),
    profilePage(),
  ] ;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: widgetBuilder[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.orangeAccent,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),

        ],
        onTap: onItemTapped,
      ),
    );
  }
}
