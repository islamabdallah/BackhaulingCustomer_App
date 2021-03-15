import 'dart:convert';

import 'package:customerapp/features/request/data/models/location.dart';

LocationsModel locationsModelFromJson(String str) => LocationsModel.fromJson(json.decode(str));

String locationsModelToJson(LocationsModel data) => json.encode(data.toJson());
class LocationsModel {
  LocationsModel({
    this.data,
  });

  List<LocationModel> data;

  LocationsModel copyWith({
    List<LocationModel> data,
  }) =>
      LocationsModel(
        data: data ?? this.data,
      );

  factory LocationsModel.fromJson(Map<String, dynamic> json) => LocationsModel(
    data: json["data"] == null ? null : List<LocationModel>.from(json["data"].map((x) => LocationModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}