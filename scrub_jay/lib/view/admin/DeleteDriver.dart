import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/DriverRequestCard.dart';
import '../widgets/HeaderWidget.dart';
import 'AdminDrawer.dart';

class DeleteDriver extends StatefulWidget {
  const DeleteDriver({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DeleteDriverState();
  }
}

class _DeleteDriverState extends State<DeleteDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text(
            "Delete a Driver".tr,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.5,
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary,
                    ])),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: <Widget>[
                  const Icon(Icons.notifications),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: const Text(
                        '5',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        drawer: AdminDrawer(),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 100,
                    child: const HeaderWidget(100, false, Icons.house_rounded),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(5, 80, 5, 10),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: 7,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => DriverRequestCard(
                              leadingIcon: Icons.person,
                              title: 'Nabhan',
                              driverPhoneNumber: 3156464,
                              trailing: Icons.restore_from_trash_rounded,)
                        ),

                      ],
                    ),
                  ),


                ],
              ),
            ],
          ),

        ));
  }
}
