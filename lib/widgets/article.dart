import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/view/article.dart';

class ArticleTile extends StatelessWidget {
  final String? author, title, description, url, urlToImage, publishedAt, content;

  ArticleTile(
      {Key? key,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,})
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              author: author,
              title: title,
              description: description,
              url: url,
              urlToImage: urlToImage,
              publishedAt: publishedAt,
              content: content,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
        child: Card(
          color: Colors.grey.shade900,
          elevation: 10,
          shadowColor: Colors.grey.shade300,
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(urlToImage!, fit: BoxFit.cover)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                      title!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              ),
              //),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  color: Colors.grey.shade300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Flex(direction: Axis.horizontal, children: [
                  Expanded(
                    child: Text(
                      description!,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  //),
                  //),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
