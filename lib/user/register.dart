import 'dart:convert';
import 'package:flutter_receipe/user/otp.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './signin.dart';
// void main() => runApp(MyApp());

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input Validation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username, _email, _password = "";
  final _formKey = GlobalKey<FormState>();

  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Validation"),
      ),
      body: Column(
        children: [
          HomePageBody(),
          SizedBox(
            height: 100.0,
          ),
          SignIN(),
        ],
      ),
    );
  }

  Widget HomePageBody() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              NameInput(),
              SizedBox(
                height: 16,
              ),
              EmailInput(),
              SizedBox(
                height: 16,
              ),
              PasswordInput(),
              SizedBox(
                height: 16,
              ),
              SubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget SignIN() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: FlatButton(
            child: Text('Already ? Have Account'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget NameInput() {
    return TextFormField(
      focusNode: _usernameFocusNode,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "e.g Morgan",
      ),
      textInputAction: TextInputAction.next,
      validator: (name) {
        Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(name))
          return 'Invalid username';
        else
          return null;
      },
      onSaved: (name) => _username = name,
      onFieldSubmitted: (_) {
        fieldFocusChange(context, _usernameFocusNode, _emailFocusNode);
      },
    );
  }

  Widget EmailInput() {
    return TextFormField(
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "e.g abc@gmail.com",
      ),
      textInputAction: TextInputAction.next,
      validator: (email) =>
          EmailValidator.validate(email) ? null : "Invalid email address",
      onSaved: (email) => _email = email,
      onFieldSubmitted: (_) {
        fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
      },
    );
  }

  Widget PasswordInput() {
    return TextFormField(
      focusNode: _passwordFocusNode,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: Icon(Icons.lock),
      ),
      textInputAction: TextInputAction.done,
      validator: (password) {
        Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(password))
          return 'Invalid password';
        else
          return null;
      },
      onSaved: (password) => _password = password,
    );
  }

  RaisedButton SubmitButton() {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          // onclick(_username, _email, _password);
          String body = json.encode(
              {'uname': _username, 'email': _email, 'password': _password});
          String url = 'http://10.0.2.2:1200/regiters';
          final http.Response response = await http.post(url,
              headers: {"Content-Type": "application/json"}, body: body);
          if (jsonDecode(response.body)['token'] == "1") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => OTP()));
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignIn(),
              ),
            );
          }
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // prefs.setString(key, value)
          // toastMessage(
          //     "Username: $_username\nEmail: $_email\nPassword: $_password");
        }
      },
      child: Text(
        "Submit",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

// Future<Widget> onclick(
//     String _username, String _email, String _password) async {
//   String body =
//       json.encode({'uname': _username, 'email': _email, 'password': _password});
//   String url = 'http://10.0.2.2:1200/regiters';
//   final http.Response response = await http.post(url,
//       headers: {"Content-Type": "application/json"}, body: body);
//   if (response.body == 0) {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Register()));
//   }
//   ;
// }

void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      fontSize: 16.0);
}

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
