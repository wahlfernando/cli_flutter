import 'dart:convert';

class PhoneModel {
  int? ddd;
  String? phone;
  PhoneModel({
    this.ddd,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'ddd': ddd,
      'phone': phone,
    };
  }

  factory PhoneModel.fromMap(Map<String, dynamic> map) {
    return PhoneModel(
      ddd: map['ddd']?.toInt(),
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneModel.fromJson(String source) =>
      PhoneModel.fromMap(json.decode(source));
}
