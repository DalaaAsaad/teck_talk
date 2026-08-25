import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';

class LanguageOption {
  const LanguageOption({
    required this.name,
    required this.apiValue,
    required this.short,
    this.version,
  });

  final String name;
  final String apiValue;
  final String short;
  final String? version;
}

class CompilerUiMessage {
  const CompilerUiMessage(this.text, {this.isError = false});
  final String text;
  final bool isError;
}

class CompilerController extends GetxController {
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final AuthRepository _authRepository = AuthRepository();

  // ============ Editors ============
  final TextEditingController codeController = TextEditingController(
    text:
        '# Write your code here\n'
        'def main():\n'
        '    name = input("Enter name: ")\n'
        '    age = int(input("Enter age: "))\n'
        '    print(f"Hello {name}, you are {age} years old")\n'
        '\n'
        'if __name__ == "__main__":\n'
        '    main()',
  );
  final TextEditingController inputController = TextEditingController(
    text: 'Ahmed\n25',
  );

  final FocusNode codeFocusNode = FocusNode();
  final RxBool codeFocused = false.obs;

  final RxBool isLoading = false.obs;
  final RxString output = ''.obs;
  final RxString errorMessage = ''.obs;

  final Rx<LanguageOption?> selectedLanguage = Rx<LanguageOption?>(null);

  final List<LanguageOption> languages = const [
    LanguageOption(name: 'Python', apiValue: 'python', short: 'PY'),
    LanguageOption(name: 'C', apiValue: 'c', short: 'C', version: 'GCC 15'),
    LanguageOption(
      name: 'C++',
      apiValue: 'cpp',
      short: 'C++',
      version: 'G++ 15',
    ),
    LanguageOption(
      name: 'Java',
      apiValue: 'java',
      short: 'JV',
      version: 'OpenJDK 25',
    ),
    LanguageOption(
      name: 'C#',
      apiValue: 'csharp',
      short: 'C#',
      version: '.NET SDK 9',
    ),
    LanguageOption(
      name: 'F#',
      apiValue: 'fsharp',
      short: 'F#',
      version: '.NET SDK 9',
    ),
    LanguageOption(name: 'PHP', apiValue: 'php', short: 'PHP', version: '8.5'),
    LanguageOption(name: 'Ruby', apiValue: 'ruby', short: 'RB', version: '4.0'),
    LanguageOption(
      name: 'Haskell',
      apiValue: 'haskell',
      short: 'HS',
      version: 'GHC 9.12',
    ),
    LanguageOption(name: 'Go', apiValue: 'go', short: 'GO', version: '1.26'),
    LanguageOption(
      name: 'Rust',
      apiValue: 'rust',
      short: 'RS',
      version: '1.93',
    ),
    LanguageOption(
      name: 'TypeScript',
      apiValue: 'typescript',
      short: 'TS',
      version: 'Deno',
    ),
  ];

  final RxString consoleTab = 'input'.obs;

  final Rx<CompilerUiMessage?> uiMessage = Rx<CompilerUiMessage?>(null);

  void _emitMessage(String text, {bool isError = false}) {
    uiMessage.value = CompilerUiMessage(text, isError: isError);
  }

  @override
  void onInit() {
    super.onInit();
    codeFocusNode.addListener(() {
      codeFocused.value = codeFocusNode.hasFocus;
    });
  }

  @override
  void onClose() {
    codeController.dispose();
    inputController.dispose();
    codeFocusNode.dispose();
    super.onClose();
  }

  void selectLanguage(LanguageOption lang) {
    selectedLanguage.value = lang;
  }

  void setConsoleTab(String tab) {
    consoleTab.value = tab;
  }

  void copyCode() {
    Clipboard.setData(ClipboardData(text: codeController.text));
    _emitMessage('Code copied');
  }

  void copyOutput() {
    Clipboard.setData(ClipboardData(text: output.value));
    _emitMessage('Output copied');
  }

  void clearCode() {
    codeController.clear();
    output.value = '';
    errorMessage.value = '';
  }

  Future<void> runCode() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (selectedLanguage.value == null) {
      _emitMessage('Please select a programming language first', isError: true);
      return;
    }
    if (codeController.text.trim().isEmpty) {
      _emitMessage('Please write your code first', isError: true);
      return;
    }

    isLoading.value = true;
    output.value = '';
    errorMessage.value = '';

    final token = await _sharedPrefs.getAuthToken();
    if (token == null || token.isEmpty) {
      errorMessage.value = 'Please sign in again';
      isLoading.value = false;
      consoleTab.value = 'output';
      return;
    }

    try {
      final result = await _authRepository.compilerCode(
        code: codeController.text,
        input: inputController.text,
        token: token,
        language: selectedLanguage.value!.apiValue,
      );

      result.fold((left) => errorMessage.value = left, (right) {
        if (right.data.result.error.isNotEmpty) {
          errorMessage.value = right.data.result.error;
        } else {
          output.value = right.data.result.output;
        }
      });
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
    } finally {
      isLoading.value = false;
      consoleTab.value = 'output';
    }
  }
}
