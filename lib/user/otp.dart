import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_receipe/user/register.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../main.dart';

class OTP extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _otp = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
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
                        labelText: 'Enter Otp',
                        hintText: 'Eg. 1234',
                      ),
                      keyboardType: TextInputType.text,
                      onSaved: (value) => _otp = value,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          String url = 'http://10.0.2.2:1200/otp';

                          String body = json.encode({'otp': _otp});
                          final http.Response response = await http.post(url,
                              body: body,
                              headers: {"Content-Type": "application/json"});
                          print(response.body);
                          if (jsonDecode(response.body)["otp"] == "1") {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            // await prefs.
                            toastMessage('Account Created');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyApp(),
                              ),
                            );
                          }
                        }
                      },
                      color: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      child: Text("Verify"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
