import 'package:tech_talk/core/data/responses/blog_info_response.dart';

class UserBlogsResponse {
  final String status;
  final String message;
  final List<BlogInfoData> data;
  final UserBlogsPagination? pagination;

  UserBlogsResponse({
    required this.status,
    required this.message,
    required this.data,
    this.pagination,
  });

  factory UserBlogsResponse.fromJson(Map<String, dynamic> json) {
    return UserBlogsResponse(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => BlogInfoData.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] != null
          ? UserBlogsPagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class UserBlogsPagination {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final bool hasMorePages;

  UserBlogsPagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.hasMorePages,
  });

  factory UserBlogsPagination.fromJson(Map<String, dynamic> json) {
    return UserBlogsPagination(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 20,
      total: json['total'] ?? 0,
      hasMorePages: json['has_more_pages'] ?? false,
    );
  }
}