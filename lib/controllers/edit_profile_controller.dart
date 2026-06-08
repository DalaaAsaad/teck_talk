import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class EditProfileController extends GetxController {
  static const int bioMaxLength = 200;

  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController usernameController;
  late final TextEditingController bioController;
  late final TextEditingController facebookController;
  late final TextEditingController instagramController;
  late final TextEditingController xController;
  late final TextEditingController redditController;

  final RxInt bioLength = 0.obs;
  final RxString displayName = 'John Techson'.obs;
  final RxList<String> selectedInterests = <String>[].obs;
  final RxnString avatarImagePath = RxnString();

  final ImagePicker _imagePicker = ImagePicker();

  static const List<String> availableInterests = [
    'Web Dev',
    'AI/ML',
    'Mobile',
    'DevOps',
    'Cybersecurity',
    'UI/UX',
    'Data Science',
    'Blockchain',
    'Cloud',
  ];

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController(text: 'John');
    lastNameController = TextEditingController(text: 'Techson');
    usernameController = TextEditingController(text: 'john_techson');
    bioController = TextEditingController();
    facebookController = TextEditingController(
      text: 'facebook.com/johntechson',
    );
    instagramController = TextEditingController(
      text: 'instagram.com/johntechson',
    );
    xController = TextEditingController(text: 'x.com/johntechson');
    redditController = TextEditingController(text: 'reddit.com/johntechson');

    bioController.addListener(_onBioChanged);
    firstNameController.addListener(_onNameChanged);
    lastNameController.addListener(_onNameChanged);
    _onNameChanged();
  }

  void _onBioChanged() {
    bioLength.value = bioController.text.length;
  }

  void _onNameChanged() {
    final first = firstNameController.text.trim();
    final last = lastNameController.text.trim();
    final name = '$first $last'.trim();
    displayName.value = name.isEmpty ? 'User Name' : name;
  }

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
  }

  Future<void> pickAvatarImage() async {
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedImage == null) {
        return;
      }

      avatarImagePath.value = pickedImage.path;
      AppSnackBar.success('Avatar updated');
    } catch (_) {
      AppSnackBar.error('Unable to pick image');
    }
  }

  void saveProfile() {
    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        usernameController.text.trim().isEmpty) {
      AppSnackBar.error('Please complete all required fields');
      return;
    }
    AppSnackBar.success('Profile saved');
  }

  @override
  void onClose() {
    bioController.removeListener(_onBioChanged);
    firstNameController.removeListener(_onNameChanged);
    lastNameController.removeListener(_onNameChanged);

    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    bioController.dispose();
    facebookController.dispose();
    instagramController.dispose();
    xController.dispose();
    redditController.dispose();
    super.onClose();
  }
}
