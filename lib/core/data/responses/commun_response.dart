class CommunResponse<T> {
  late String message;
  int? statusCode;
  T? data;

  CommunResponse.fromjson(dynamic json) {
    if (json == null) {
      statusCode = null;
      message = 'Empty response';
      data = null;
      return;
    }

    statusCode = json['statusCode'];
    final response = json['response'];

    if (statusCode.toString().startsWith('2')) {
      // 🔥 حماية من أي نوع غير Map
      if (response is T) {
        data = response;
      } else if (response is Map<String, dynamic>) {
        data = response as T;
      } else {
        data = null;
      }

      message = json['message']?.toString() ?? '';
    } else {
      if (response is Map<String, dynamic>) {
        message = response['message']?.toString() ?? '';
      } else if (response != null && response.toString().isNotEmpty) {
        message = response.toString();
      } else {
        switch (statusCode) {
          case 400:
            message = '400 bad request';
            break;
          case 401:
            message = '401 Not Auth';
            break;
          case 403:
            message = '403 Forbidden';
            break;
          case 404:
            message = '404 Not found';
            break;
          case 405:
            message = '405 Method not allowed';
            break;
          case 500:
            message = '500 Server error';
            break;
          case 503:
            message = '503 Unavailable';
            break;
          default:
            message = 'Something went wrong';
        }
      }
    }
  }

  bool get getstatuscode => statusCode?.toString().startsWith('2') ?? false;

  String get getMessage => message;
}
