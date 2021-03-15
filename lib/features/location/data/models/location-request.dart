// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);
import 'dart:convert';

LocationRequestModel locationRequestModelFromJson(String str) => LocationRequestModel.fromJson(json.decode(str));

String locationRequestModelToJson(LocationRequestModel data) => json.encode(data.toJson());

class LocationRequestModel {
  LocationRequestModel({
    this.userId,
    this.cityId,
    this.governorateId,
    this.longitude,
    this.latitude,
    this.name,
    this.detailedAddress,
    this.contactName,
    this.contactNumber,
  });

  String userId;
  int cityId;
  int governorateId;
  String longitude;
  String latitude;
  String name;
  String detailedAddress;
  String contactName;
  String contactNumber;

  LocationRequestModel copyWith({
    String userId,
    int cityId,
    int governorateId,
    String longitude,
    String latitude,
    String name,
    String detailedAddress,
    String contactName,
    String contactNumber,
  }) =>
      LocationRequestModel(
        userId: userId ?? this.userId,
        cityId: cityId ?? this.cityId,
        governorateId: governorateId ?? this.governorateId,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        name: name ?? this.name,
        detailedAddress: detailedAddress ?? this.detailedAddress,
          contactName: contactName ?? this.contactName,
          contactNumber: contactNumber ?? this.contactNumber
      );

  factory LocationRequestModel.fromJson(Map<String, dynamic> json) => LocationRequestModel(
    userId: json["userId"] == null ? null : json["userId"],
    cityId: json["cityId"] == null ? null : json["cityId"],
    governorateId: json["governorateId"] == null ? null : json["governorateId"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    name: json["name"] == null ? null : json["name"],
    detailedAddress: json["detailedAddress"] == null ? null : json["detailedAddress"],
    contactName: json["contactName"] == null ? null : json["contactName"],
    contactNumber: json["contactNumber"] == null ? null : json["contactNumber"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId == null ? null : userId,
     "cityId": cityId == null ? null : cityId,
    "governorateId": governorateId == null ? null : governorateId,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
    "name": name == null ? null : name,
    "detailedAddress": detailedAddress == null ? null : detailedAddress,
    "contactName": contactName == null ? null : contactName,
    "contactNumber": contactNumber == null ? null :contactNumber,
  };
}
