class GeolocationModel {
  final String lat;
  final String long;

  GeolocationModel({
    required this.lat,
    required this.long,
  });

  factory GeolocationModel.fromJson(Map<String, dynamic> json) {
    return GeolocationModel(
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
    };
  }
}
