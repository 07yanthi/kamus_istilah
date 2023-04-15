// To parse this JSON data, do
//
//     final jenisBudaya = jenisBudayaFromJson(jsonString);

import 'dart:convert';

JenisBudaya jenisBudayaFromJson(String str) =>
    JenisBudaya.fromJson(json.decode(str));

String jenisBudayaToJson(JenisBudaya data) => json.encode(data.toJson());

class JenisBudaya {
  JenisBudaya({
   required this.status,
   required this.jenis,
  });

  bool status;
  List<Jeni> jenis;

  factory JenisBudaya.fromJson(Map<String, dynamic> json) => JenisBudaya(
        status: json["Status"],
        jenis: List<Jeni>.from(json["jenis"].map((x) => Jeni.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "jenis": List<dynamic>.from(jenis.map((x) => x.toJson())),
      };
}

class Jeni {
  Jeni({
    required this.idJenis,
    required this.namaJenis,
    required this.fotoJenis,
  });

  String idJenis;
  String namaJenis;
  String fotoJenis;

  factory Jeni.fromJson(Map<String, dynamic> json) => Jeni(
        idJenis: json["id_jenis"],
        namaJenis: json["nama_jenis"],
        fotoJenis: json["foto_jenis"],
      );

  Map<String, dynamic> toJson() => {
        "id_jenis": idJenis,
        "nama_jenis": namaJenis,
        "foto_jenis": fotoJenis,
      };
}
