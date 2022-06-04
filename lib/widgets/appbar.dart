import 'package:flutter/material.dart';
import 'package:project/view/search.dart';

class BeritaAppBar extends StatefulWidget implements PreferredSizeWidget {
  BeritaAppBar({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _BeritaAppBarState createState() => _BeritaAppBarState();
}

class _BeritaAppBarState extends State<BeritaAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.shade900,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Berita",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "News",
            style: TextStyle(color: Colors.blue),
          )
        ],
      ),
      actions: <Widget>[
        Opacity(
          opacity: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.account_balance_sharp),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search())),
          icon: Icon(
            Icons.search,
            size: 26,
          ),
        )
      ],
      centerTitle: true,
    );
  }
}
