import 'package:flutter/material.dart';
import 'package:flutter_receipe/user/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text('mndadhkfkjda'),
            FlatButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('token', null);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ),
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
