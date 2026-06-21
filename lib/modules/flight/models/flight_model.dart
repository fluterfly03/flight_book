class FlightModel {
  final int? id;
  final String airlineName;
  final String airlineLogo;
  final String flightNumber;
  final String departureTime;
  final String departureAirport;
  final String departureCity;
  final String arrivalTime;
  final String arrivalAirport;
  final String arrivalCity;
  final String duration;
  final double priceAmount;
  final String priceCurrency;
  final String aircraftType;
  final int stops;

  FlightModel({
    this.id,
    required this.airlineName,
    required this.airlineLogo,
    required this.flightNumber,
    required this.departureTime,
    required this.departureAirport,
    required this.departureCity,
    required this.arrivalTime,
    required this.arrivalAirport,
    required this.arrivalCity,
    required this.duration,
    required this.priceAmount,
    required this.priceCurrency,
    required this.aircraftType,
    required this.stops,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      airlineName: json['airline_name'] ?? '',
      airlineLogo: json['airline_logo'] ?? '',
      flightNumber: json['flight_number'] ?? '',
      departureTime: json['departure']?['time'] ?? '',
      departureAirport: json['departure']?['airport_code'] ?? '',
      departureCity: json['departure']?['city'] ?? '',
      arrivalTime: json['arrival']?['time'] ?? '',
      arrivalAirport: json['arrival']?['airport_code'] ?? '',
      arrivalCity: json['arrival']?['city'] ?? '',
      duration: json['duration'] ?? '',
      priceAmount: (json['price']?['amount'] != null) ? double.tryParse(json['price']['amount'].toString()) ?? 0.0 : 0.0,
      priceCurrency: json['price']?['currency'] ?? '',
      aircraftType: json['aircraft_type'] ?? '',
      stops: json['stops'] != null ? int.tryParse(json['stops'].toString()) ?? 0 : 0,
    );
  }
}
