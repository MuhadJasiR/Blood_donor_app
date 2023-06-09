import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase_auth/model/donor_model.dart';
import 'package:flutter/cupertino.dart';

class FireBaseDonor {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController bloodController = TextEditingController();
  final CollectionReference donor =
      FirebaseFirestore.instance.collection("donor");
  addDonor() {
    final data = Donor(
            name: nameController.text.trim(),
            phone: phoneController.text.trim(),
            blood: bloodController.text.trim())
        .toJson();

    donor.add(data);
  }

  updateDonor(docId) {
    final data = Donor(
            name: nameController.text.trim(),
            phone: phoneController.text.trim(),
            blood: bloodController.text.trim())
        .toJson();

    donor.doc(docId).update(data);
  }

  delete(docId) {
    donor.doc(docId).delete();
  }

  dispose() {
    nameController.clear();
    phoneController.clear();
    bloodController.clear();
  }
}
