const String kServerBaseUrl = 'https://gradback.neotonicglobal.com';


String? resolveImageUrl(String? path) {
  if (path == null || path.trim().isEmpty) return null;

  final trimmed = path.trim();

  if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
    return trimmed;
  }

  final base = kServerBaseUrl.endsWith('/')
      ? kServerBaseUrl.substring(0, kServerBaseUrl.length - 1)
      : kServerBaseUrl;

  final relative = trimmed.startsWith('/') ? trimmed : '/$trimmed';

  return '$base$relative';
}
