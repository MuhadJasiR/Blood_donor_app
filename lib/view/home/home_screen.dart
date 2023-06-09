import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase_auth/controller/add_blood_data.dart';
import 'package:firbase_auth/view/home/add_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeScreen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Are you sure!"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              FirebaseAuth.instance
                                  .signOut()
                                  .then((value) => Navigator.pop(context));
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(color: Colors.red),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"))
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return AddBloodDetails();
              },
            ));
          },
          label: const Icon(Icons.add)),
      body: StreamBuilder(
          stream: donor.snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final DocumentSnapshot donorSnap = snapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white12,
                      child: Text(donorSnap["blood"]),
                    ),
                    onTap: () {},
                    title: Text(
                      donorSnap["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(donorSnap["phone"]),
                    trailing: SizedBox(
                      width: 100.0, // Adjust the width as needed
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pushNamed(context, "/update",
                                  arguments: {
                                    "name": donorSnap["name"],
                                    "phone": donorSnap["phone"],
                                    "blood": donorSnap["blood"],
                                    "id": donorSnap.id
                                  });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Are you Sure!"),
                                    content: const Text(
                                        "your data will get deleted"),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            await FireBaseDonor()
                                                .delete(donorSnap.id);
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Yes",
                                            style: TextStyle(color: Colors.red),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No")),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          }),
    );
  }
}
