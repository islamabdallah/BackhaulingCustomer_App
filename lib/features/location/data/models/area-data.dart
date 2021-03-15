import 'dart:convert';

AreaDataModel areaDataModelFromJson(String str) => AreaDataModel.fromJson(json.decode(str));

String areaDataModelToJson(AreaDataModel data) => json.encode(data.toJson());

class AreaDataModel {
  AreaDataModel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.active,
  });

  int id;
  String nameEn;
  String nameAr;
  bool active;

  AreaDataModel copyWith({
    int id,
    String nameEn,
    String nameAr,
    bool active,
  }) =>
      AreaDataModel(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameAr: nameAr ?? this.nameAr,
        active: active ?? this.active,
      );

  factory AreaDataModel.fromJson(Map<String, dynamic> json) => AreaDataModel(
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
