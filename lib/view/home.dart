import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/helper/data_category.dart';
import 'package:project/helper/newsapi_network.dart';
import 'package:project/helper/shared_preferences.dart';
import 'package:project/model/article_model.dart';
import 'package:project/model/category_model.dart';
import 'package:project/view/category.dart';
import 'package:project/view/login_page.dart';
import 'package:project/widgets/appbar.dart';
import 'package:project/widgets/article.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = [];
  late Future<List<Article>> _articleFuture;

  @override
  void initState() {
    _articleFuture = getNews();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BeritaAppBar(),
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].name,
                    );
                  },
                ),
              ),
              IconButton(
                padding: const EdgeInsets.only(bottom: 25),
                onPressed: () {
                  SharedPreference().setLogout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder<List<Article>>(
          future: this._articleFuture,
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
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      category: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(16, 20, 0, 5),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 250,
                    height: 70,
                    fit: BoxFit.cover,
                  )),
              Container(
                alignment: Alignment.center,
                width: 120,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black26, Colors.black],
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  categoryName,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
