class NotificationsListResponse {
  final String status;
  final String message;
  final List<NotificationModel> data;
  final NotificationPagination? pagination;

  NotificationsListResponse({
    required this.status,
    required this.message,
    required this.data,
    this.pagination,
  });

  factory NotificationsListResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsListResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] != null
          ? NotificationPagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class NotificationPagination {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final bool hasMorePages;

  NotificationPagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.hasMorePages,
  });

  factory NotificationPagination.fromJson(Map<String, dynamic> json) {
    return NotificationPagination(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 20,
      total: json['total'] ?? 0,
      hasMorePages: json['has_more_pages'] ?? false,
    );
  }
}

/// [actor]/[entity]/[context] بالـ API عامين (Map حرة الشكل حسب نوع
/// الإشعار)، فبنخليهم Map<String,dynamic> عامة ونستخرج منهم القيم
/// المعروفة بشكل دفاعي بدل موديلات صارمة.
class NotificationModel {
  final String id;
  final String type;
  final String title;
  final String body;
  final Map<String, dynamic> actor;
  final Map<String, dynamic> entity;
  final Map<String, dynamic> context;
  final String? readAt;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.actor,
    required this.entity,
    required this.context,
    this.readAt,
    required this.createdAt,
  });

  bool get isRead => readAt != null && readAt!.isNotEmpty;

  String? get actorName =>
      actor['name']?.toString() ?? actor['username']?.toString();
  String? get actorAvatarUrl => actor['avatar_url']?.toString();

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      actor: json['actor'] is Map
          ? Map<String, dynamic>.from(json['actor'])
          : {},
      entity: json['entity'] is Map
          ? Map<String, dynamic>.from(json['entity'])
          : {},
      context: json['context'] is Map
          ? Map<String, dynamic>.from(json['context'])
          : {},
      readAt: json['read_at']?.toString(),
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}
