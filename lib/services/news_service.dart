import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/news_response.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/theme/app_theme.dart';

class NewsService extends ChangeNotifier {
  List<Article> headlines = [];
  List<Category> categorias = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];
  // ignore: non_constant_identifier_names
  final String _api_key = 'da323390053846e9b7a4da0dd6a97947';
  final String _country = 'us';
  final String _baseUrl = "newsapi.org";
  Map<String, List<Article>> categoryAcrticles = {};
  String _selectedCategory = 'business';
  Color active = Apptheme.theme.colorScheme.secondary;

  get selectedCategory => _selectedCategory;
  set setSelectedCategory(String val) {
    _selectedCategory = val;
    notifyListeners();
    getArticlesByCategory().then((value) {
      notifyListeners();
    });
  }

  NewsService() {
    getTopHeadlines();
    for (var element in categorias) {
      categoryAcrticles[element.name] = [];
    }
    getArticlesByCategory();
  }

  Future getTopHeadlines() async {
    final url = Uri.https(_baseUrl, '/v2/top-headlines',
        {'country': _country, 'apiKey': _api_key});
    final res = await http.get(url);
    if (res.statusCode != 200) return null;
    headlines.addAll(NewsResponse.fromJson(res.body).articles);
    notifyListeners();
  }

  Future getArticlesByCategory() async {
    if (categoryAcrticles[selectedCategory]!.isNotEmpty) return;
    final url = Uri.https(_baseUrl, '/v2/top-headlines', {
      'country': _country,
      'apiKey': _api_key,
      'category': _selectedCategory
    });
    final res = await http.get(url);
    if (res.statusCode != 200) return null;
    categoryAcrticles[selectedCategory]!
        .addAll(NewsResponse.fromJson(res.body).articles);
  }
}
