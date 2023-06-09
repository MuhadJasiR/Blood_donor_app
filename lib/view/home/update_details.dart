import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase_auth/controller/add_blood_data.dart';
import 'package:firbase_auth/view/auth/widget/text_field.dart';
import 'package:flutter/material.dart';

class UpdateDetails extends StatelessWidget {
  UpdateDetails({super.key});

  final CollectionReference donor =
      FirebaseFirestore.instance.collection("donor");

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    FireBaseDonor.nameController.text = args["name"];
    FireBaseDonor.phoneController.text = args["phone"];
    FireBaseDonor.bloodController.text = args["blood"];
    final docId = args["id"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextInputField(
                  controller: FireBaseDonor.nameController,
                  icon: Icons.person,
                  isObscure: false,
                  labelText: "Enter name"),
              const SizedBox(
                height: 10,
              ),
              TextInputField(
                  controller: FireBaseDonor.phoneController,
                  icon: Icons.phone,
                  isObscure: false,
                  labelText: "Enter number"),
              const SizedBox(
                height: 10,
              ),
              TextInputField(
                  controller: FireBaseDonor.bloodController,
                  icon: Icons.bloodtype,
                  isObscure: false,
                  labelText: "Enter Group"),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(200, 40)),
                onPressed: () async {
                  await FireBaseDonor().updateDonor(docId);
                  Navigator.pop(context);
                },
                child: const Text("Update"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
