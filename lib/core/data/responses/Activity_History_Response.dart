class ActivityHistoryResponse {
  final String status;
  final String message;
  final List<ActivityData> data;
  final ActivityPagination pagination;

  ActivityHistoryResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory ActivityHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ActivityHistoryResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map(
                (item) =>
                    ActivityData.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      pagination: ActivityPagination.fromJson(
        json['pagination'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class ActivityData {
  final int id;
  final String action;
  final ActivityActor actor;
  final ActivitySubject subject;
  final Map<String, dynamic> meta;
  final String createdAt;

  ActivityData({
    required this.id,
    required this.action,
    required this.actor,
    required this.subject,
    required this.meta,
    required this.createdAt,
  });

  factory ActivityData.fromJson(Map<String, dynamic> json) {
    return ActivityData(
      id: json['id'] ?? 0,
      action: json['action'] ?? '',
      actor: ActivityActor.fromJson(
        json['actor'] as Map<String, dynamic>? ?? {},
      ),
      subject: ActivitySubject.fromJson(
        json['subject'] as Map<String, dynamic>? ?? {},
      ),
      meta: _parseMeta(json['meta']),
      createdAt: json['created_at'] ?? '',
    );
  }

  static Map<String, dynamic> _parseMeta(dynamic meta) {
    if (meta is Map<String, dynamic>) {
      return meta;
    }

    return {};
  }
}

class ActivityActor {
  final int id;
  final String username;
  final String name;

  ActivityActor({
    required this.id,
    required this.username,
    required this.name,
  });

  factory ActivityActor.fromJson(Map<String, dynamic> json) {
    return ActivityActor(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class ActivitySubject {
  final String type;
  final int id;

  ActivitySubject({
    required this.type,
    required this.id,
  });

  factory ActivitySubject.fromJson(Map<String, dynamic> json) {
    return ActivitySubject(
      type: json['type'] ?? '',
      id: json['id'] ?? 0,
    );
  }
}

class ActivityPagination {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final int from;
  final int to;
  final bool hasMorePages;

  ActivityPagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.from,
    required this.to,
    required this.hasMorePages,
  });

  factory ActivityPagination.fromJson(Map<String, dynamic> json) {
    return ActivityPagination(
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      perPage: json['per_page'] ?? 0,
      total: json['total'] ?? 0,
      from: json['from'] ?? 0,
      to: json['to'] ?? 0,
      hasMorePages: json['has_more_pages'] ?? false,
    );
  }
}