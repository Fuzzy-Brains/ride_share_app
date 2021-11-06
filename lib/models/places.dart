// To parse this JSON data, do
//
//     final place = placeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

class Place {
  String placeId;
  String mainText;
  String secondaryText;

  Place({ required this.placeId, required this.mainText, required this.secondaryText });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    placeId: json["place_id"],
    mainText: json["structured_formatting"]["main_text"],
    secondaryText: json["structured_formatting"]["secondary_text"],
  );

  Map<String, dynamic> toJson() => {
    "place_id": placeId,
    "main_text": mainText,
    "secondary_text": secondaryText,
  };
}
