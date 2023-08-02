import 'package:flutter/material.dart';
import 'package:recrutment_page/Backend.dart';

void main() {
  runApp(MaterialApp(
    home: RecruitmentApp(),
  ));
}

class RecruitmentApp extends StatefulWidget {
  const RecruitmentApp({super.key});

  @override
  State<RecruitmentApp> createState() => _RecruitmentAppState();
}

class _RecruitmentAppState extends State<RecruitmentApp> {
  late TextEditingController title = TextEditingController();
  late TextEditingController description = TextEditingController();

  Widget build(BuildContext context) {
    DateTime? deadline;
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
                    Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      width: 500,
                                      height: 700,
                                      child: Dialog(
                                        child: Scaffold(
                                          body: Column(
                                            children: [
                                              TextField(
                                                controller: title,
                                                decoration: InputDecoration(
                                                    hintText: "Title"),
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              TextField(
                                                controller: description,
                                                decoration: InputDecoration(
                                                    hintText: "Description"),
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    deadline =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime.now(),
                                                            lastDate:
                                                                DateTime.now());
                                                  },
                                                  child: const Text(
                                                      "Select deadline")),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              TextButton(
                                                  onPressed: () async {
                                                    await Backend().post_offer(
                                                        title: title.text,
                                                        desc: description.text,
                                                        deadline: deadline ??
                                                            DateTime.now());
                                                    Navigator.of(context).pop();
                                                    setState(() {});
                                                  },
                                                  child: const Text('Post'))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: const Text("Post an offer")),
                        const SizedBox(
                          height: 700,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Column(
                      children: [
                        const Text("List of Offers"),
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
                                          offers
                                              .elementAt(index)["title"]
                                              .toString()),
                                      Text("descriptrion :" +
                                          offers
                                              .elementAt(index)["description"]
                                              .toString()),
                                      Text(offers
                                          .elementAt(index)["start"]
                                          .toString()),
                                      Text(offers
                                          .elementAt(index)["deadline"]
                                          .toString()),
                                    ],
                                  )),
                                );
                              }),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("List of Applications"),
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
                                          apps.elementAt(
                                              index)["applicant_name"]),
                                      Text("Candidate email :" +
                                          apps.elementAt(
                                              index)["applicant_email"]),
                                      Text("date :" +
                                          ((apps.elementAt(index)["deadline"] ==
                                                  null)
                                              ? "null"
                                              : DateTime
                                                      .fromMicrosecondsSinceEpoch(
                                                          offers.elementAt(
                                                              index)["start"])
                                                  .toString())),
                                      Text(" Status :" +
                                          apps.elementAt(index)["status"]),
                                      (apps.elementAt(index)["status"] ==
                                              "unviewed")
                                          ? TextButton(
                                              onPressed: () async {
                                                await Backend().accept_app(
                                                    id: apps.elementAt(
                                                        index)["id"]);
                                                setState(() {});
                                              },
                                              child: const Text("Proceeed"))
                                          : const SizedBox(),
                                      TextButton(
                                          onPressed: () async {
                                            await Backend().delete_app(
                                                id: apps
                                                    .elementAt(index)["id"]);
                                            setState(() {});
                                          },
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
              ],
            ),
          );
        });
  }
}
