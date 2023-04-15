// To parse this JSON data, do
//
//     final kamusModel = kamusModelFromJson(jsonString);

import 'dart:convert';

KamusModel kamusModelFromJson(String str) =>
    KamusModel.fromJson(json.decode(str));

String kamusModelToJson(KamusModel data) => json.encode(data.toJson());

class KamusModel {
  KamusModel({
    required this.status,
    required this.waktu,
    required this.typo,
    required this.kamus,
  });

  bool status;
  double waktu;
  String typo;
  List<Kamus> kamus;

  factory KamusModel.fromJson(Map<String, dynamic> json) => KamusModel(
        status: json["status"],
        waktu: json["waktu"].toDouble(),
        typo: json["typo"],
        kamus: List<Kamus>.from(json["kamus"].map((x) => Kamus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "waktu": waktu,
        "typo": typo,
        "kamus": List<dynamic>.from(kamus.map((x) => x.toJson())),
      };
}

class Kamus {
  Kamus({
    this.kamusId,
    this.kamusIstilah,
    this.kamusDetail,
  });

  String? kamusId;
  String? kamusIstilah;
  String? kamusDetail;

  factory Kamus.fromJson(Map<String, dynamic> json) => Kamus(
        kamusId: json["kamus_id"],
        kamusIstilah: json["kamus_istilah"],
        kamusDetail: json["kamus_detail"],
      );

  Map<String, dynamic> toJson() => {
        "kamus_id": kamusId,
        "kamus_istilah": kamusIstilah,
        "kamus_detail": kamusDetail,
      };
}
