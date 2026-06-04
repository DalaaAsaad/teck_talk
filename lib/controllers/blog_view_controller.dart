import 'package:get/get.dart';

class BlogViewController extends GetxController {
  final RxBool isSaved = false.obs;
  final RxBool isFavorite = false.obs;

  final RxMap<String, int> engagement = <String, int>{
    'likes': 24500,
    'views': 50000,
    'bookmarks': 206,
  }.obs;

  final RxMap<String, String> metadata = <String, String>{
    'Publication Date': 'October 15, 2023',
    'Category': 'Healthcare',
    'Reading Time': '10 Min',
    'Author Name': 'Dr. Emily Walker',
  }.obs;

  final RxList<String> tableOfContents = <String>[
    'Introduction',
    'AI in Diagnostic Imaging',
    'Predictive Analytics and Disease Prevention',
    'Personalized Treatment Plans',
    'Drug Discovery and Research',
    'AI in Telemedicine',
    'Ethical Considerations',
    'The Future of AI in Healthcare',
    'Conclusion',
  ].obs;

  final RxMap<String, String> contentMap = <String, String>{
    'Introduction':
        'Artificial Intelligence (AI) has emerged as a transformative force in the healthcare industry, reshaping patient care, diagnostics, and research. In this section we explore the profound impact of AI in healthcare, from revolutionizing diagnostic accuracy to enhancing patient outcomes.',

    'AI in Diagnostic Imaging':
        'AI is reshaping diagnostic imaging by helping medical teams interpret scans faster and with greater consistency.',

    'Predictive Analytics and Disease Prevention':
        'One of the most prominent applications of AI in healthcare is in diagnostic imaging. AI algorithms have demonstrated remarkable proficiency in interpreting medical images such as X-rays, MRIs, and CT scans. They can identify anomalies and deviations that might be overlooked by the human eye. This is particularly valuable in early disease detection.',

    'Personalized Treatment Plans':
        'Machine learning models can help tailor treatment plans based on patient history, imaging, and real-time data.',

    'Drug Discovery and Research':
        'AI accelerates drug discovery by screening compounds, identifying candidates, and reducing research time.',

    'AI in Telemedicine':
        'Telemedicine benefits from AI-powered triage, symptom analysis, and better remote monitoring workflows.',

    'Ethical Considerations':
        'Responsible AI adoption in healthcare requires privacy, fairness, transparency, and human oversight.',

    'The Future of AI in Healthcare':
        'The next generation of healthcare systems will likely combine clinicians and AI assistants for better decisions.',

    'Conclusion':
        'AI will continue to influence healthcare delivery, improving outcomes, efficiency, and access to care.',
  }.obs;

  final String heroImage = 'assets/images/png/blog_image.png';

  final String title = 'The Rise of Artificial';

  final String subTitle = 'Intelligence in Healthcare';

  void toggleSaved() {
    isSaved.toggle();

    if (isSaved.value) {
      engagement['bookmarks'] = (engagement['bookmarks'] ?? 0) + 1;
    } else {
      engagement['bookmarks'] = (engagement['bookmarks'] ?? 1) - 1;
    }
  }

  void toggleFavorite() {
    isFavorite.toggle();

    if (isFavorite.value) {
      engagement['likes'] = (engagement['likes'] ?? 0) + 1;
    } else {
      engagement['likes'] = (engagement['likes'] ?? 1) - 1;
    }
  }

  Future<void> onReadFullBlog() async {}

  String formatEngagement(int? value) {
    final number = value ?? 0;

    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    }

    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(number >= 10000 ? 0 : 1)}k';
    }

    return number.toString();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
