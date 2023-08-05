import 'package:flutter/material.dart';
import 'package:ui_task/screens/widgets/card.dart';
import 'package:ui_task/screens/widgets/filter.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 15),
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.grey.shade100),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Discover',
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
            ),
            const Text(
              'News from all around the world',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black38,
                  fontSize: 12),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black54,
                    size: 30,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Search',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Image(
                    image: AssetImage(
                      "assets/images/sliders-horizontal.png",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  filter(
                    filterType: 'All',
                    backGroundColor: Colors.blue.shade700,
                    textColor: Colors.white,
                  ),
                  filter(
                    filterType: 'Politic',
                    backGroundColor: Colors.grey.shade100,
                    textColor: Colors.grey,
                  ),
                  filter(
                    filterType: 'Sport',
                    backGroundColor: Colors.grey.shade100,
                    textColor: Colors.grey,
                  ),
                  filter(
                    filterType: 'Education',
                    backGroundColor: Colors.grey.shade100,
                    textColor: Colors.grey,
                  ),
                  filter(
                    filterType: 'Game',
                    backGroundColor: Colors.grey.shade100,
                    textColor: Colors.grey,
                  ),
                  filter(
                    filterType: 'technology',
                    backGroundColor: Colors.grey.shade100,
                    textColor: Colors.grey,
                  ),
                ],
              ),
            ),
             const SizedBox(height: 10,),

             const Expanded(
               child: SingleChildScrollView(
                 scrollDirection: Axis.vertical,
                 child: Column(
                  children: [
                    card(
                      title: 'Sports',
                      content: 'What training do volleyball players need? ',
                      image: 'assets/images/volley.png',
                      date: '27Feb,2023',
                      name: 'McKindney',
                      avatar: 'assets/images/avatar1.png',
                    ),
                    card(
                      title: 'Education',
                      content: 'secondary school places when do parents find out?',
                      image: 'assets/images/education.png',
                      date: '27Feb,2023',
                      name: 'Rosemary',
                      avatar: 'assets/images/avatar2.png',
                    ),
                    card(
                      title: 'World',
                      content: '6 houses destroyed in massive fire in assam\'s K.',
                      image: 'assets/images/fireman.png',
                      date: '27Feb,2023',
                      name: 'Aslam K',
                      avatar: 'assets/images/avatar3.png',
                    ),
                    card(
                      title: 'World',
                      content: 'at least 35 people killed in separate road crashes in AS',
                      image: 'assets/images/roadCrash.png',
                      date: '27Feb,2023',
                      name: 'Madison Jr',
                      avatar: 'assets/images/avatar4.png',
                    ),

                  ],
            ),
               ),
             ),
          ],
        ),
      ),
    );
  }
}
