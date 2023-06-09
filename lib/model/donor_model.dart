class Donor {
  String name;
  String phone;
  String blood;

  Donor({required this.name, required this.phone, required this.blood});

  Map<String, dynamic> toJson() {
    return {"name": name, "phone": phone, "blood": blood};
  }
}
