import 'package:get/get.dart';

class PostModel {
  final String nameProfile;
  final String imageProfile;
  final String date;
  final String textPost;
  final int numFav;
  final int numComment;
  final int numSaved;
  final List<String> tags;
  final String? code;
  final String? codeLanguage;
  final List<String>? images;

  RxBool isFavorite = false.obs;
  RxBool isComment = false.obs;
  RxBool isSaved = false.obs;

  PostModel({
    required this.nameProfile,
    required this.imageProfile,
    required this.date,
    required this.textPost,
    required this.numFav,
    required this.numComment,
    required this.numSaved,
    required this.tags,
    this.code,
    this.codeLanguage,
    this.images,
  });
}
