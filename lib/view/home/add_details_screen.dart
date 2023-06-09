import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase_auth/controller/add_blood_data.dart';
import 'package:firbase_auth/view/auth/widget/text_field.dart';
import 'package:flutter/material.dart';

class AddBloodDetails extends StatelessWidget {
  AddBloodDetails({super.key});

  final CollectionReference donor =
      FirebaseFirestore.instance.collection("donor");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(donor.id.isNotEmpty ? "Add Details" : "Update Details"),
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
                  await FireBaseDonor().addDonor();
                  FireBaseDonor().dispose();
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
