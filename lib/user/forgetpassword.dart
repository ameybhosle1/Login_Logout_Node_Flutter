import 'package:flutter/material.dart';

class Forget extends StatefulWidget {
  Forget({Key key}) : super(key: key);

  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
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
                        bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(value);
                        if (!emailValid) {
                          return 'Email NOt Valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Email',
                        hintText: 'Eg. Ameybhosle3@gmail.com',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) => _email = value,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                      },
                      color: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      child: Text("Sign In With Email"),
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
