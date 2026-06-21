class AircraftType {
  final String aircraft;

  AircraftType({required this.aircraft});

  factory AircraftType.fromJson(Map<String, dynamic> json) {
	return AircraftType(aircraft: json['aircraft'] ?? '');
  }
}

class Pagination {
  final int total;
  final int totalPages;
  final int currentPage;
  final int limit;
  final bool hasNextPage;
  final bool hasPrevPage;

  Pagination({
	required this.total,
	required this.totalPages,
	required this.currentPage,
	required this.limit,
	required this.hasNextPage,
	required this.hasPrevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
	return Pagination(
	  total: json['total'] ?? 0,
	  totalPages: json['totalPages'] ?? 0,
	  currentPage: json['currentPage'] ?? 1,
	  limit: json['limit'] ?? 10,
	  hasNextPage: json['hasNextPage'] ?? false,
	  hasPrevPage: json['hasPrevPage'] ?? false,
	);
  }
}

class AircraftTypesResponse {
  final String status;
  final String message;
  final List<AircraftType> aircraftTypes;
  final String search;
  final Pagination? pagination;

  AircraftTypesResponse({
	required this.status,
	required this.message,
	required this.aircraftTypes,
	required this.search,
	this.pagination,
  });

  factory AircraftTypesResponse.fromJson(Map<String, dynamic> json) {
	final data = json['data'] ?? {};
	final list = (data['aircraft_types'] as List<dynamic>?) ?? [];
	return AircraftTypesResponse(
	  status: json['status'] ?? '',
	  message: json['message'] ?? '',
	  aircraftTypes: list.map((e) => AircraftType.fromJson(e as Map<String, dynamic>)).toList(),
	  search: data['search'] ?? '',
	  pagination: data['pagination'] != null ? Pagination.fromJson(data['pagination'] as Map<String, dynamic>) : null,
	);
  }
}


