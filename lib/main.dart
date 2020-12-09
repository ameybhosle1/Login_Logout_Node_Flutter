import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user/register.dart';
import 'user/signin.dart';
import 'package:http/http.dart' as http;
import './home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: My(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  final myController = TextEditingController();
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    login() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      if (token != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }
    }

    login();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          elevation: 0,
          actions: [IconButton(icon: Icon(Icons.message), onPressed: () {})],
          // leading: IconButton(
          //   icon: Icon(Icons.ac_unit),
          //   onPressed: () {
          //     Scaffold.of(context).openDrawer();
          //   },
          //   tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          // ),
          title: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Text(
              'Receipe',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 10.0,
                      child: Text('Your Name'),
                    ),
                  ],
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Register'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Sign In'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  // color: Colors.greenAccent,
                  height: 100.0,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: -20.0,
                        child: Container(
                          margin: EdgeInsets.all(12.0),
                          padding: EdgeInsets.all(12.0),
                          height: 54,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextField(
                            // key: myController,
                            controller: myController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                // padding: EdgeInsets.fromLTRB(0.0, -1.0, 0.0, 0.0),
                                icon: Icon(Icons.alarm),
                                onPressed: () {},
                              ),
                              labelText: 'Enter Receipe',
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                    overflow: Overflow.visible,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0)),
                      color: Colors.greenAccent),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 100.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      // ListTile(),
                      Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.red,
                        //   // image: ,
                        //   borderRadius: BorderRadius.circular(20.0),
                        // ),
                        margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        width: 160.0,
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text('Button'),
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.red,
                        //   // image: ,
                        //   borderRadius: BorderRadius.circular(20.0),
                        // ),
                        margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        width: 160.0,
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text('Button'),
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.red,
                        //   // image: ,
                        //   borderRadius: BorderRadius.circular(20.0),
                        // ),
                        margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        width: 160.0,
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text('Button'),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 250,
                        color: Colors.red[600],
                        child: const Center(child: Text('Entry A')),
                      ),
                      Container(
                        height: 250,
                        color: Colors.red[500],
                        child: const Center(child: Text('Entry B')),
                      ),
                      Container(
                        height: 250,
                        color: Colors.yellow[100],
                        child: const Center(child: Text('Entry C')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.assessment), label: 'News'),
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'Stocks')
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
