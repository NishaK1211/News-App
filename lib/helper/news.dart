import 'dart:convert';

import 'package:news_app/models/article_models.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=in&apiKey=bd094d39641f4fcfac624a0699356902';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      // ignore: unnecessary_statements
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel article = ArticleModel(title:element['title'],
        author: element['author'],
        description:element['description'],
        url : element['url'],
        urlToImage: element['urlToImage'],
       // publishedAt: element['publishedAt'],
        content: element['content']

          );
          news.add(article);
        }
      }) ;
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=bd094d39641f4fcfac624a0699356902';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      // ignore: unnecessary_statements
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel article = ArticleModel(title:element['title'],
              author: element['author'],
              description:element['description'],
              url : element['url'],
              urlToImage: element['urlToImage'],
              // publishedAt: element['publishedAt'],
              content: element['content']

          );
          news.add(article);
        }
      }) ;
    }
  }
}


