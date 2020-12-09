import 'dart:convert';
import 'dart:io';
import 'package:flutter_receipe/user/forgetpassword.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import './register.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('SIGN IN'),
        ),
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 30.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Email';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'Email NOt Valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Email',
                        hintText: 'Eg . ameybhosle3@gmail.com',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) => _email = value,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Password',
                        hintText: 'Eg . ameybhosle',
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onSaved: (value) => _password = value,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: FlatButton(
                          child: Text('Forgot Password'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Forget()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  ElevatedButton(
                    child: Text('SignIn'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        String body = json
                            .encode({'email': _email, 'password': _password});
                        String url = 'http://10.0.2.2:1200/sign';
                        final http.Response response = await http.post(url,
                            headers: {"Content-Type": "application/json"},
                            body: body);
                        print(jsonDecode(response.body));
                        if (jsonDecode(response.body)["token"] != null) {
                          print(jsonDecode(response.body)["token"]);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString(
                            'token',
                            jsonDecode(response.body)["token"],
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        } else {
                          toastMessage("Accound is not Registered");
                          sleep(Duration(milliseconds: 1000));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      fontSize: 16.0);
}
