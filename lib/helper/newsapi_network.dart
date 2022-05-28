import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/model/article_model.dart';

Future<List<Article>> getNews() async {
  List<Article> news = [];

  // This API key shouldn't be stored here
  Uri url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=id&apiKey=70932467ba784f28ac5f0cb94d26a9f9");

  var response = await http.get(url);

  var jsonData = jsonDecode(response.body);

  if (jsonData['status'] == "ok") {
    jsonData["articles"].forEach(
          (element) {
        if (element['title'] != null &&
            element['urlToImage'] != null &&
            element['description'] != null) {
          Article articleModel = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      },
    );
  }

  return news;
}

Future<List<Article>> getNewsByCategory(String? category) async {
  List<Article> news = [];

  Uri url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?category=$category&country=id&apiKey=70932467ba784f28ac5f0cb94d26a9f9");

  var response = await http.get(url);

  var jsonData = jsonDecode(response.body);

  if (jsonData['status'] == "ok") {
    jsonData["articles"].forEach(
          (element) {
        if (element['title'] != null &&
            element['urlToImage'] != null &&
            element['description'] != null) {
          Article articleModel = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            // publishedAt: element['publishedAt'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      },
    );
  }

  return news;
}

Future<List<Article>> getNewsBySearchQuery(String? query) async {
  List<Article> news = [];

  String urlEncodedQuery = Uri.encodeQueryComponent(query!);

  Uri url = Uri.parse(
      "https://newsapi.org/v2/everything?qInTitle=$urlEncodedQuery&apiKey=70932467ba784f28ac5f0cb94d26a9f9");

  var response = await http.get(url);

  var jsonData = jsonDecode(response.body);

  if (jsonData['status'] == "ok") {
    jsonData["articles"].forEach(
          (element) {
        if (element['title'] != null &&
            element['urlToImage'] != null &&
            element['description'] != null) {
          Article articleModel = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );

          news.add(articleModel);
        }
      },
    );
  }

  return news;
}
