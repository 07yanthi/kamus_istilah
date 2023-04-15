// To parse this JSON data, do
//
//     final FavoritModel = FavoritModelFromJson(jsonString);

import 'dart:convert';

FavoritModel FavoritModelFromJson(String str) =>
    FavoritModel.fromJson(json.decode(str));

String FavoritModelToJson(FavoritModel data) => json.encode(data.toJson());

class FavoritModel {
  FavoritModel({
    required this.status,
    required this.waktu,
    required this.typo,
    required this.kamus,
  });

  bool status;
  double waktu;
  String typo;
  List<Favorit> kamus;

  factory FavoritModel.fromJson(Map<String, dynamic> json) => FavoritModel(
        status: json["status"],
        waktu: json["waktu"].toDouble(),
        typo: json["typo"],
        kamus:
            List<Favorit>.from(json["kamus"].map((x) => Favorit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "waktu": waktu,
        "typo": typo,
        "kamus": List<dynamic>.from(kamus.map((x) => x.toJson())),
      };
}

class Favorit {
  Favorit({
    this.kamusId,
    this.kamusIstilah,
    this.kamusDetail,
  });

  String? kamusId;
  String? kamusIstilah;
  String? kamusDetail;

  factory Favorit.fromJson(Map<String, dynamic> json) => Favorit(
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
