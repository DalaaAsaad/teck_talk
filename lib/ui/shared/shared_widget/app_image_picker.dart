import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class AppImagePicker {
  AppImagePicker._();
  static final AppImagePicker instance = AppImagePicker._();

  final ImagePicker _picker = ImagePicker();

  Future<bool> _ensurePermission() async {
    PermissionStatus status = await Permission.photos.status;
    if (status.isGranted) return true;

    final requestStatus = await Permission.photos.request();
    if (requestStatus.isGranted) return true;

    AppSnackBar.error('Cannot access gallery.', title: 'Permission denied');
    return false;
  }

  Future<XFile?> pickImage({
    int imageQuality = 85,
    double? maxWidth,
    double? maxHeight,
  }) async {
    if (!await _ensurePermission()) return null;

    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );
      if (picked == null) return null;
      return _normalizeExtension(picked);
    } catch (e) {
      AppSnackBar.error('Failed to pick image: $e');
      return null;
    }
  }

  Future<List<XFile>> pickMultiImage({int imageQuality = 85}) async {
    if (!await _ensurePermission()) return [];

    try {
      final List<XFile> picked = await _picker.pickMultiImage(
        imageQuality: imageQuality,
      );
      final normalized = <XFile>[];
      for (final file in picked) {
        normalized.add(await _normalizeExtension(file));
      }
      return normalized;
    } catch (e) {
      AppSnackBar.error('Failed to pick images: $e');
      return [];
    }
  }

  Future<XFile> _normalizeExtension(XFile file) async {
    final path = file.path;
    final ext = path.split('.').last.toLowerCase();
    if (ext == 'jpg') {
      final newPath = path.replaceAll(
        RegExp(r'\.jpg$', caseSensitive: false),
        '.jpeg',
      );
      final newFile = await File(path).copy(newPath);
      return XFile(newFile.path);
    }
    return file;
  }
}