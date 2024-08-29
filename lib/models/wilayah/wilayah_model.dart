class WilayahModel {
  String code;
  String name;
  KoordinatModel coordinates;
  String googlePlaceId;

  WilayahModel({
    required this.code,
    required this.name,
    required this.coordinates,
    required this.googlePlaceId,
  });

  factory WilayahModel.fromJson(Map<String, dynamic> json) {
    return WilayahModel(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      coordinates: KoordinatModel.fromJson(json['coordinates']),
      googlePlaceId: json['google_place_id'] ?? '',
    );
  }
}

class KoordinatModel {
  String lat;
  String lng;

  KoordinatModel({
    required this.lat,
    required this.lng,
  });

  factory KoordinatModel.fromJson(Map<String, dynamic> json) {
    return KoordinatModel(
      lat: json['lat'] ?? '',
      lng: json['lng'] ?? '',
    );
  }
}
