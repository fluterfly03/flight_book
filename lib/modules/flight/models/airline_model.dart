class Airline {
  final String airline;

  Airline({
    required this.airline,
  });

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(
      airline: json['airline']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airline': airline,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'limit': limit,
      'hasNextPage': hasNextPage,
      'hasPrevPage': hasPrevPage,
    };
  }
}

class AirlinesResponse {
  final String status;
  final String message;
  final List<Airline> airlines;
  final String search;
  final Pagination? pagination;

  AirlinesResponse({
    required this.status,
    required this.message,
    required this.airlines,
    required this.search,
    this.pagination,
  });

  factory AirlinesResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return AirlinesResponse(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      airlines: (data['airlines'] as List<dynamic>? ?? [])
          .map(
            (e) => Airline.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),
      search: data['search']?.toString() ?? '',
      pagination: data['pagination'] != null
          ? Pagination.fromJson(
        data['pagination'] as Map<String, dynamic>,
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': {
        'airlines': airlines.map((e) => e.toJson()).toList(),
        'search': search,
        'pagination': pagination?.toJson(),
      },
    };
  }
}