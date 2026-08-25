import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';

enum UmlState { idle, loading, result }

class UmlController extends ChangeNotifier {
  UmlController({
    SharedPreferenceRepository? sharedPrefs,
    AuthRepository? authRepository,
  })  : _sharedPrefs = sharedPrefs ?? SharedPreferenceRepository(),
        _authRepository = authRepository ?? AuthRepository();

  final int maxLength = 500;

  String _description = '';
  UmlState _state = UmlState.idle;
  Uint8List? _diagramImage;
  bool _exportPressed = false;
  String? _errorMessage;

  final SharedPreferenceRepository _sharedPrefs;
  final AuthRepository _authRepository;

  String get description => _description;
  int get charCount => _description.length;
  bool get canGenerate => _description.trim().isNotEmpty;
  UmlState get state => _state;
  Uint8List? get diagramImage => _diagramImage;
  bool get exportPressed => _exportPressed;
  String? get errorMessage => _errorMessage;

  void onDescriptionChanged(String value) {
    _description = value;
    notifyListeners();
  }

  Future<void> generateDiagram() async {
    if (!canGenerate) return;
    _state = UmlState.loading;
    _diagramImage = null;
    _errorMessage = null;
    _exportPressed = false;
    notifyListeners();

    try {
      final token = _sharedPrefs.getAuthToken();

      if (token == null) {
        _errorMessage = 'Session expired. Log in again.';
        _state = UmlState.idle;
        notifyListeners();
        return;
      }

      _diagramImage = await _authRepository.generateUmlImage(
        token: token,
        description: _description,
      );

      _state = UmlState.result;
    } catch (e) {
      _errorMessage = "Couldn't generate the diagram. Try again.";
      _state = UmlState.idle;
      debugPrint('UML generation error: $e');
    }

    notifyListeners();
  }

  void regenerate() => generateDiagram();

  void exportPng() {
    if (_diagramImage == null) return;
    _exportPressed = true;
    notifyListeners();
    debugPrint('Exporting PNG…');
  }
}