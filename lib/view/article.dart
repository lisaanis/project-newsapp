import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleView extends StatefulWidget {
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleView(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

@override
class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.topCenter,
                                child: Text(
                                  widget.title!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: _buidImageItem(widget.urlToImage),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "About the News",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  // decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(5),
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //         color: Color.fromARGB(36, 0, 0, 0),
                                  //         spreadRadius: 0.5,
                                  //         blurRadius: 20,
                                  //         offset: Offset(0,
                                  //             0),
                                  //       )
                                  //     ]),
                                  margin: EdgeInsets.only(top: 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  "Author: ",
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  "Published at: ",
                                                  textAlign: TextAlign.right,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  widget.author!,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  "${widget.publishedAt!.substring(0, 10)}",
                                                  textAlign: TextAlign.left,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  "Description",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    widget.content!,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromARGB(64, 19, 18, 18))
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10
                                ),
                                margin: EdgeInsets.only(top: 15),
                                child: TextButton(
                                  onPressed: () {
                                    _launchURL(widget.url!);
                                  },
                                  child: Text(
                                    "Visit the link",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _launchURL(String link) async {
    var url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch';
    }
  }

  Widget _buidImageItem(String? imageUrl) {
    if (imageUrl?.isEmpty ?? true || imageUrl == null) {
      return ClipRRect(
        child: Image.asset(
          "assets/images/no-image.png",
          height: 200,
          fit: BoxFit.cover,
        ),
      );
    }
    return ClipRRect(
      child: Image.network(
        imageUrl ?? "",
        height: 220,
        fit: BoxFit.cover,
      ),
    );
  }
}
