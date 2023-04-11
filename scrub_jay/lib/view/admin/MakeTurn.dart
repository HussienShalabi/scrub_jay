import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

import '../widgets/DriverInfoCard.dart';
import '../widgets/HeaderWidget.dart';
import 'AdminDrawer.dart';

class MakeTurn extends StatefulWidget {
  const MakeTurn({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MakeTurnState();
  }
}

class _MakeTurnState extends State<MakeTurn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text(
            'initial turn'.tr,
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
          child: Stack(
            children: [
              Container(
                height: 100,
                child: const HeaderWidget(100, false, Icons.house_rounded),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(25, 80, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: 600,
                        child: ReorderableListView.builder(
                          itemBuilder: (context, index) {
                            return  DriverInfoCard(
                              key: Key(index.toString()),
                              leadingIcon: Icons.taxi_alert_rounded,
                              title: "data",
                              driverPhoneNumber: 05975,
                            );
                          },
                          itemCount: 5,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) newIndex--;
                            });
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
