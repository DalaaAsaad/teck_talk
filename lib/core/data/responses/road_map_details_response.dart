class RoadMapDetailsResponse {
  final String status;
  final String message;
  final RoadMapDetails data;

  RoadMapDetailsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RoadMapDetailsResponse.fromJson(Map<String, dynamic> json) {
    return RoadMapDetailsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: RoadMapDetails.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class RoadMapDetails {
  final int id;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;
  final List<RoadMapNode> nodes;

  RoadMapDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.nodes,
  });

  factory RoadMapDetails.fromJson(Map<String, dynamic> json) {
    return RoadMapDetails(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      nodes:
          (json['nodes'] as List?)
              ?.map((e) => RoadMapNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'nodes': nodes.map((e) => e.toJson()).toList(),
    };
  }
}

class RoadMapNode {
  final int id;
  final int roadMapId;
  final String title;
  final int stepNumber;
  final String url;
  final String createdAt;
  final String updatedAt;

  RoadMapNode({
    required this.id,
    required this.roadMapId,
    required this.title,
    required this.stepNumber,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoadMapNode.fromJson(Map<String, dynamic> json) {
    return RoadMapNode(
      id: json['id'] ?? 0,
      roadMapId: json['road_map_id'] ?? 0,
      title: json['title'] ?? '',
      stepNumber: json['step_number'] ?? 0,
      url: json['url'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'road_map_id': roadMapId,
      'title': title,
      'step_number': stepNumber,
      'url': url,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
