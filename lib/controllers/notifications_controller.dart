import 'package:get/get.dart';
import 'package:tech_talk/core/data/models/notification_model.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class NotificationsController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxInt unreadCount = 0.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;

  int _currentPage = 1;
  bool _hasMorePages = true;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
    loadUnreadCount();

  }

  Future<void> loadNotifications() async {
    isLoading.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      _currentPage = 1;
      final result = await _authRepository.getNotifications(
        token: token,
        page: _currentPage,
      );

      result.fold((error) => AppSnackBar.error(error), (response) {
        notifications.assignAll(response.data);
        _hasMorePages = response.pagination?.hasMorePages ?? false;
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreNotifications() async {
    if (isLoadingMore.value || !_hasMorePages) return;

    isLoadingMore.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) return;

      final nextPage = _currentPage + 1;
      final result = await _authRepository.getNotifications(
        token: token,
        page: nextPage,
      );

      result.fold((error) => AppSnackBar.error(error), (response) {
        notifications.addAll(response.data);
        _currentPage = nextPage;
        _hasMorePages = response.pagination?.hasMorePages ?? false;
      });
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> loadUnreadCount() async {
    final token = await _sharedPrefs.getAuthToken();
    if (token == null || token.isEmpty) return;

    final result = await _authRepository.getUnreadNotificationsCount(
      token: token,
    );
    result.fold((error) {}, (count) => unreadCount.value = count);
  }

  Future<void> markAsRead(NotificationModel notification) async {
    if (notification.isRead) return;

    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) return;

      final result = await _authRepository.markNotificationAsRead(
        notificationId: notification.id,
        token: token,
      );

      result.fold((error) => AppSnackBar.error(error), (_) {
        final index = notifications.indexWhere((n) => n.id == notification.id);
        if (index != -1) {
          notifications[index] = NotificationModel(
            id: notification.id,
            type: notification.type,
            title: notification.title,
            body: notification.body,
            actor: notification.actor,
            entity: notification.entity,
            context: notification.context,
            readAt: DateTime.now().toIso8601String(),
            createdAt: notification.createdAt,
          );
        }
        if (unreadCount.value > 0) unreadCount.value--;
      });
    } catch (e) {
      AppSnackBar.error('Something went wrong');
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) return;

      final result = await _authRepository.markAllNotificationsAsRead(
        token: token,
      );

      result.fold((error) => AppSnackBar.error(error), (_) {
        final now = DateTime.now().toIso8601String();
        notifications.assignAll(
          notifications.map(
            (n) => NotificationModel(
              id: n.id,
              type: n.type,
              title: n.title,
              body: n.body,
              actor: n.actor,
              entity: n.entity,
              context: n.context,
              readAt: n.readAt ?? now,
              createdAt: n.createdAt,
            ),
          ),
        );
        unreadCount.value = 0;
      });
    } catch (e) {
      AppSnackBar.error('Something went wrong');
    }
  }
}
