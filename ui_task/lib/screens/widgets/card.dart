import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class card extends StatelessWidget {
  final String title;
  final String content;
  final String image;
  final String date;
  final String name;
  final String avatar;

  const card(
      {super.key,
      required this.title,
      required this.content,
      required this.image,
      required this.date,
      required this.name,
      required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                width: 120,
                height: 120,
                image: AssetImage(
                  image,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(

                  maxLines: 2,
                  content,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      child: CircleAvatar(foregroundImage: AssetImage(avatar),),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      name,
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(
                      width: 20,
                      child: Center(child: Text('•',style:TextStyle(color: Colors.grey, fontSize: 15) ,)),
                    ),
                    Text(
                      date,
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
