// To parse this JSON data, do
//
//     final truckDataModel = truckDataModelFromJson(jsonString);

import 'dart:convert';

TruckDataModel truckDataModelFromJson(String str) => TruckDataModel.fromJson(json.decode(str));

String truckDataModelToJson(TruckDataModel data) => json.encode(data.toJson());

class TruckDataModel {
  TruckDataModel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.active,
  });

  int id;
  String nameEn;
  String nameAr;
  bool active;

  TruckDataModel copyWith({
    int id,
    String nameEn,
    String nameAr,
    bool active,
  }) =>
      TruckDataModel(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameAr: nameAr ?? this.nameAr,
        active: active ?? this.active,
      );

  factory TruckDataModel.fromJson(Map<String, dynamic> json) => TruckDataModel(
    id: json["id"] == null ? null : json["id"],
    nameEn: json["nameEN"] == null ? null : json["nameEN"],
    nameAr: json["nameAR"] == null ? null : json["nameAR"],
    active: json["active"] == null ? null : json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nameEN": nameEn == null ? null : nameEn,
    "nameAR": nameAr == null ? null : nameAr,
    "active": active == null ? null : active,
  };
}
