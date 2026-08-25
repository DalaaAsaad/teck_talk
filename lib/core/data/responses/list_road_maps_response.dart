class ListRoadMapsResponse {
  final String status;
  final String message;
  final List<RoadMap> data;

  ListRoadMapsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ListRoadMapsResponse.fromJson(Map<String, dynamic> json) {
    return ListRoadMapsResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => RoadMap.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class RoadMap {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  RoadMap({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoadMap.fromJson(Map<String, dynamic> json) {
    return RoadMap(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
