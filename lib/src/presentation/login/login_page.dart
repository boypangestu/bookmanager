import 'dart:developer';

import 'package:bookmanager/src/sqlite/sql_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<Map<String, dynamic>> _journals = [];

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    await SQLHelper.getUser(_emailController.text, _passwordController.text);
    _refresh1();
  }

  void _refresh1() async {
    final data = await SQLHelper.getUser(
        _emailController.text, _passwordController.text);
    setState(() {
      _journals = data;
      // print(_journals);
      // _isLoading = false;
    });
  }

  void _users() async {
    SQLHelper.createdusers();
  }

  @override
  void initState() {
    super.initState();
    _users();

    // Loading the diary when the app starts
  }

  @override
  Widget build(BuildContext context) {
    final nohp = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Email';
        }
        return null;
      },
      controller: _emailController,
      // style: TextStyle(color: Colors.black54),
      // keyboardType: TextInputType.phone,
      autofocus: false,
      // initialValue: 'Enter Your Phone Number',
    );

    final password = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
      controller: _passwordController,

      style: TextStyle(color: Colors.black54),
      autofocus: false,
      // initialValue: 'some password',
    );

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              // color: Colors.cyanAccent,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 48.0),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your username',
                          hintText: 'Enter a search term'),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        // height: 48.0,
                        onPressed: () {
                          _login();
                          final datahasil = _journals;
                          print(datahasil[0]['id']);
                        },

                        // color: Colors.purple[200],
                        child: Container(
                            width: double.infinity,
                            child: Text('SIGN IN',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white))),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xffF7C01B)),
                      ),
                    )
                    // forgotLabel,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
