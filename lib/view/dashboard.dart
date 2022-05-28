import 'package:flutter/material.dart';
import 'package:project/helper/shared_preferences.dart';
import 'package:project/view/login_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        actions: [
          IconButton(
            onPressed: () {
              SharedPreference().setLogout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            FutureBuilder(
              future: SharedPreference().getFirstname(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return Text("Hello, ${snapshot.data}", style: TextStyle(fontSize: 24),);
              },
            )
          ],
        ),
      ),
    );
  }
}