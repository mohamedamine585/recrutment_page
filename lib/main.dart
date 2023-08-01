import 'package:flutter/material.dart';
import 'package:recrutment_page/Backend.dart';

void main() {
  runApp(RecruitmentApp());
}

class RecruitmentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Backend().connect(),
        builder: (context, snapshot) {
          List<Map<String, dynamic>> offers = snapshot.data?.first ?? [];
          List<Map<String, dynamic>> apps = snapshot.data?.elementAt(1) ?? [];

          return Scaffold(
            body: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 250,
                    ),
                    Container(
                      width: 600,
                      height: 700,
                      child: ListView.builder(
                          itemCount: offers.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Card(
                                  child: Column(
                                children: [
                                  Text("Job title : " +
                                      offers.elementAt(index)["title"]),
                                  Text("descriptrion :" +
                                      offers.elementAt(index)["description"]),
                                  Text((offers.elementAt(index)["start"] ==
                                          null)
                                      ? "null"
                                      : DateTime.fromMicrosecondsSinceEpoch(
                                              offers.elementAt(index)["start"])
                                          .toString()),
                                  Text((offers.elementAt(index)["deadline"] ==
                                          null)
                                      ? "null"
                                      : DateTime.fromMicrosecondsSinceEpoch(
                                              offers.elementAt(index)["start"])
                                          .toString()),
                                ],
                              )),
                            );
                          }),
                    ),
                    Container(
                      width: 600,
                      height: 700,
                      child: ListView.builder(
                          itemCount: apps.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Card(
                                  child: Column(
                                children: [
                                  Text("title" +
                                      apps.elementAt(index)["offer_title"]),
                                  Text("Candidate name :" +
                                      apps.elementAt(index)["applicant_name"]),
                                  Text("Candidate email :" +
                                      apps.elementAt(index)["applicant_email"]),
                                  Text("date :" +
                                      ((apps.elementAt(index)["deadline"] ==
                                              null)
                                          ? "null"
                                          : DateTime.fromMicrosecondsSinceEpoch(
                                                  offers.elementAt(
                                                      index)["start"])
                                              .toString())),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text("Proceeed")),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text("Refuse"))
                                ],
                              )),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
