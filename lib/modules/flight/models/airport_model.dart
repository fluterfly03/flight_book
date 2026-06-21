class Airport {
  final String airportCode;
  final String city;
  final int flightCount;

  Airport({
    required this.airportCode,
    required this.city,
    required this.flightCount,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      airportCode: json['airport_code'] ?? '',
      city: json['city'] ?? '',
      flightCount: json['flight_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airport_code': airportCode,
      'city': city,
      'flight_count': flightCount,
    };
  }

  String get display => '$city ($airportCode)';
}