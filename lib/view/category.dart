import 'package:flutter/material.dart';
import 'package:project/helper/newsapi_network.dart';
import 'package:project/model/article_model.dart';
import 'package:project/widgets/appbar.dart';
import 'package:project/widgets/article.dart';

class CategoryNews extends StatefulWidget {
  final String? category;
   CategoryNews({
     Key? key,
     required this.category
  }) : super(key: key) ;

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  late Future<List<Article>> _articleFuture;

  @override
  void initState() {
    _articleFuture = getNewsByCategory(this.widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BeritaAppBar(),
      body: FutureBuilder<List<Article>>(
        future: _articleFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ArticleTile(
                  author: snapshot.data![index].author!,
                  title: snapshot.data![index].title!,
                  description: snapshot.data![index].description!,
                  url: snapshot.data![index].url!,
                  urlToImage: snapshot.data![index].urlToImage!,
                  publishedAt: snapshot.data![index].publishedAt!,
                  content: snapshot.data![index].content!,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
