class FlightModel {
  final String airline;
  final String from;
  final String to;
  final String duration;
  final double price;
  final String departureTime;
  final String arrivalTime;
  final String departureAirport;
  final String arrivalAirport;
  final String departureDate;
  final String arrivalDate;

  FlightModel({
    required this.airline,
    required this.from,
    required this.to,
    required this.duration,
    required this.price,
    this.departureTime = '07:47',
    this.arrivalTime = '14:30',
    this.departureAirport = 'CGK',
    this.arrivalAirport = 'NRT',
    this.departureDate = 'Jan 20, 2025',
    this.arrivalDate = 'Jan 20, 2025',
  });
}
