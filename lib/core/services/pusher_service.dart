import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/enum/request_type.dart';
import 'package:tech_talk/core/utils/network_util.dart'; // عدّل المسار حسب مكان NetworkUtil عندك

/// ============================================================
/// !! الثلاث قيم هون لازم تجيهن من مطوّر الباك إند - بلاهن الميزة
/// !! ما رح تشتغل. كل شي تاني بالملف جاهز وما بيحتاج تعديل.
/// ============================================================
class PusherConfig {
  /// من لوحة Pusher (App Keys) - سطر "key" بالضبط.
  static const String appKey = "5fc000b382a90f691def";

  /// من لوحة Pusher (App Keys) - سطر "cluster" (مثلاً "eu", "mt1", "ap2").
  static const String cluster = "eu";

  /// رابط الـ Broadcasting Auth بمشروع Laravel - الافتراضي القياسي
  /// بمعظم مشاريع Laravel هو '/broadcasting/auth'، بس تأكد من الباك إند.
  static const String authEndpointPath = '/broadcasting/auth';
}

/// بيدير اتصال Pusher الوحيد بالتطبيق. استدعي [connect] مرة وحدة بعد
/// تسجيل الدخول (أو وقت فتح التطبيق لو المستخدم already مسجّل)، و
/// [disconnect] وقت تسجيل الخروج.
class PusherService {
  PusherService._();
  static final PusherService instance = PusherService._();

  final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  bool _isConnected = false;

  /// بيسجّل Callback بينادى كل ما إشعار جديد يوصل Real-time. مرّر دالة
  /// بتاخد Map<String, dynamic> (نفس شكل NotificationModel.fromJson).
  Future<void> connect({
    required void Function(Map<String, dynamic> data) onNotificationReceived,
  }) async {
    if (_isConnected) return;

    final userId = _sharedPrefs.getUserId();
    if (userId == null) return;

    try {
      await _pusher.init(
        apiKey: PusherConfig.appKey,
        cluster: PusherConfig.cluster,
        onAuthorizer: _authorizer,
        onConnectionStateChange: (currentState, previousState) {
          // ignore: avoid_print
          print('Pusher connection: $previousState -> $currentState');
        },
        onError: (message, code, exception) {
          // ignore: avoid_print
          print('Pusher error: $message ($code)');
        },
      );

      await _pusher.connect();

      // اسم القناة الخاصة بالمستخدم - افتراض شائع بمشاريع Laravel، تأكد
      // الاسم الصحيح من الباك إند إذا مختلف (مثلاً "private-notifications.<id>").
      await _pusher.subscribe(
        channelName: 'private-user.$userId',
        onEvent: (event) {
          // اسم الحدث - افتراض شائع، تأكده من الباك إند إذا مختلف
          // (مثلاً "NotificationCreated" أو ".notification.created").
          if (event.eventName == 'notification.created' && event.data != null) {
            try {
              final Map<String, dynamic> data = Map<String, dynamic>.from(
                _decodeEventData(event.data!),
              );
              onNotificationReceived(data);
            } catch (e) {
              // ignore: avoid_print
              print('Could not parse Pusher event data: $e');
            }
          }
        },
      );

      _isConnected = true;
    } catch (e) {
      // ignore: avoid_print
      print('Pusher connect failed: $e');
    }
  }

  dynamic _decodeEventData(String raw) {
    return raw.startsWith('{') ? Uri.decodeFull(raw) : raw;
  }

  /// بيثبت هوية المستخدم للقناة الخاصة عبر توكن الـ Auth الحالي - نفس
  /// آلية Laravel Echo القياسية. لازم ترجع Map عادية (dynamic) حسب
  /// توثيق pusher_channels_flutter الرسمي - مافي كلاس PusherAuth
  /// بالمكتبة أصلاً (كان غلط مني بالنسخة السابقة).
  Future<dynamic> _authorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    final token = await _sharedPrefs.getAuthToken();

    final response = await NetworkUtil.sendRequest(
      type: RequestType.POST,
      route: PusherConfig.authEndpointPath,
      body: {'socket_id': socketId, 'channel_name': channelName},
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    // تشخيص مؤقت - شوف بالضبط شو رجع السيرفر
    print('🔐 BROADCASTING AUTH raw response: $response');

    final body = response['response'] ?? response;
    return {
      'auth': body['auth']?.toString() ?? '',
      'channel_data': body['channel_data']?.toString(),
    };
  }

  Future<void> disconnect() async {
    if (!_isConnected) return;
    await _pusher.disconnect();
    _isConnected = false;
  }
}
