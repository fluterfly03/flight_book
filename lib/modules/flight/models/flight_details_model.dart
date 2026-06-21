class FlightDetailsResponse {
  final String status;
  final String message;
  final FlightDetailsData? data;

  FlightDetailsResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory FlightDetailsResponse.fromJson(Map<String, dynamic> json) {
    return FlightDetailsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null
          ? FlightDetailsData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class FlightDetailsData {
  final FlightDetail flightDetails;
  final List<Passenger> passengers;
  final BookingInfo bookingInfo;

  FlightDetailsData({
    required this.flightDetails,
    required this.passengers,
    required this.bookingInfo,
  });

  factory FlightDetailsData.fromJson(Map<String, dynamic> json) {
    return FlightDetailsData(
      flightDetails: FlightDetail.fromJson(
          json['flight_details'] as Map<String, dynamic>),
      passengers: (json['passengers'] as List<dynamic>?)
              ?.map((e) => Passenger.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      bookingInfo:
          BookingInfo.fromJson(json['booking_info'] as Map<String, dynamic>),
    );
  }
}

class FlightDetail {
  final int id;
  final String airlineName;
  final String airlineLogo;
  final String flightId;
  final String flightNumber;
  final DepartureArrival departure;
  final DepartureArrival arrival;
  final String duration;
  final String aircraftType;
  final int stops;
  final String terminal;
  final String gate;
  final String classType;

  FlightDetail({
    required this.id,
    required this.airlineName,
    required this.airlineLogo,
    required this.flightId,
    required this.flightNumber,
    required this.departure,
    required this.arrival,
    required this.duration,
    required this.aircraftType,
    required this.stops,
    required this.terminal,
    required this.gate,
    required this.classType,
  });

  factory FlightDetail.fromJson(Map<String, dynamic> json) {
    return FlightDetail(
      id: json['id'] ?? 0,
      airlineName: json['airline_name'] ?? '',
      airlineLogo: json['airline_logo'] ?? '',
      flightId: json['flight_id'] ?? '',
      flightNumber: json['flight_number'] ?? '',
      departure: DepartureArrival.fromJson(
          json['departure'] as Map<String, dynamic>),
      arrival:
          DepartureArrival.fromJson(json['arrival'] as Map<String, dynamic>),
      duration: json['duration'] ?? '',
      aircraftType: json['aircraft_type'] ?? '',
      stops: json['stops'] ?? 0,
      terminal: json['terminal'] ?? '',
      gate: json['gate'] ?? '',
      classType: json['class'] ?? '',
    );
  }
}

class DepartureArrival {
  final String time;
  final String airportCode;
  final String city;

  DepartureArrival({
    required this.time,
    required this.airportCode,
    required this.city,
  });

  factory DepartureArrival.fromJson(Map<String, dynamic> json) {
    return DepartureArrival(
      time: json['time'] ?? '',
      airportCode: json['airport_code'] ?? '',
      city: json['city'] ?? '',
    );
  }
}

class Passenger {
  final int passengerNumber;
  final String title;
  final String name;
  final String seat;
  final String profilePicture;

  Passenger({
    required this.passengerNumber,
    required this.title,
    required this.name,
    required this.seat,
    required this.profilePicture,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      passengerNumber: json['passenger_number'] ?? 0,
      title: json['title'] ?? '',
      name: json['name'] ?? '',
      seat: json['seat'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
    );
  }
}

class BookingInfo {
  final int totalPassengers;
  final String bookingReference;
  final String bookingDate;
  final String barcode;

  BookingInfo({
    required this.totalPassengers,
    required this.bookingReference,
    required this.bookingDate,
    required this.barcode,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) {
    return BookingInfo(
      totalPassengers: json['total_passengers'] ?? 0,
      bookingReference: json['booking_reference'] ?? '',
      bookingDate: json['booking_date'] ?? '',
      barcode: json['barcode'] ?? '',
    );
  }
}

