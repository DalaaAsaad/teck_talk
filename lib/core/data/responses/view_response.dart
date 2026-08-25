class ViewResponse {
  String? status;
  String? message;
  ViewRecordData? data;

  ViewResponse({this.status, this.message, this.data});

  ViewResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['data'] != null) {
      data = ViewRecordData.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }
}

class ViewRecordData {
  bool? viewRecorded;
  bool? alreadyViewed;
  String? type;
  int? id;
  int? viewsCount;

  ViewRecordData({
    this.viewRecorded,
    this.alreadyViewed,
    this.type,
    this.id,
    this.viewsCount,
  });

  ViewRecordData.fromJson(Map<String, dynamic> json) {
    viewRecorded = json['view_recorded'];
    alreadyViewed = json['already_viewed'];
    type = json['type'];
    id = json['id'];
    viewsCount = json['views_count'];
  }

  Map<String, dynamic> toJson() {
    return {
      'view_recorded': viewRecorded,
      'already_viewed': alreadyViewed,
      'type': type,
      'id': id,
      'views_count': viewsCount,
    };
  }
}
