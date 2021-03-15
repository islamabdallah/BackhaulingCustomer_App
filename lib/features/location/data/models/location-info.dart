import 'dart:convert';
import 'area-data.dart';


LocationInfoModel locationInfoModelFromJson(String str) => LocationInfoModel.fromJson(json.decode(str));

String locationInfoModelToJson(LocationInfoModel data) => json.encode(data.toJson());

class LocationInfoModel {
  LocationInfoModel({
    this.gov,
    this.cities,
  });

  List<AreaDataModel> gov;
  List<AreaDataModel> cities;

  LocationInfoModel copyWith({
    List<AreaDataModel> gov,
    List<AreaDataModel> cities
  }) =>
      LocationInfoModel(
        gov: gov ?? this.gov,
        cities: cities ?? this.cities,
      );

  factory LocationInfoModel.fromJson(Map<String, dynamic> json) => LocationInfoModel(
    gov: json["gov"] == null ? null : List<AreaDataModel>.from(json["gov"].map((x) => AreaDataModel.fromJson(x))),
    cities: json["cities"] == null ? null : List<AreaDataModel>.from(json["cities"].map((x) => AreaDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gov": gov == null ? null : List<dynamic>.from(gov.map((x) => x.toJson())),
    "cities": cities == null ? null : List<dynamic>.from(cities.map((x) => x.toJson())),
  };
}

