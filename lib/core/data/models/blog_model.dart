class BlogModel {
  final String nameProfile;
  final String imageProfile;
  final String imageBlog;
  final String date;
  final String titleBlog;
  final String textBlog;
  final List<String> tags;

  BlogModel({
    required this.nameProfile,
    required this.imageProfile,
    required this.imageBlog,
    required this.date,
    required this.titleBlog,
    required this.textBlog,
    required this.tags,
  });
}
