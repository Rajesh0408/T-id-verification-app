import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController unameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorText = '';
  bool isPasswordVisible = false;
  String? uname;
  String? password;
  String? jwt;
  String? tid;
  bool logging = false;

  Future<bool> authenticateUser(String username, String password) async {
    print(username);
    print(password);
    final response = await http.post(
      Uri.parse('https://techofes-website-api.onrender.com/api/login'),
      body: jsonEncode(<String, String>{
        'email': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print(response.statusCode);

      // Successful authentication, parse JWT token from response
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      jwt = jsonResponse['token'];
      tid = jsonResponse['user']['t_id'];
      print(tid);
      setState(() {
        logging = false;
      });
      return true;
    } else {
      print(response.body);
      setState(() {
        logging = false;
      });
      // Authentication failed
      // throw Exception('Failed to authenticate user');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('T-id verfication app'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(tid==null? '': 'Tid: $tid', ),
                  ),

                  const Text(
                    "LogIn",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome back ! Login with your credentials",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (_value) {
                    uname = _value.toString();
                  },
                  controller: unameController,
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      hintText: 'Email'),
                ),
              ),
              SizedBox(height: 15),
              logging
                  ? CircularProgressIndicator(
                color: Colors.blue,
              )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (_value) {
                    password = _value.toString();
                  },
                  controller: passwordController,
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      hintText: 'Password'),
                ),
              ),
              SizedBox(height: 25),

              Container(
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {

                    uname = unameController.text;
                    password = passwordController.text;

                    if (uname!.length == 0 || password!.length == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill the above details"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      setState(() {
                        logging = true;
                      });
                      if (await authenticateUser(uname!, password!)) {
                        unameController.clear();
                        passwordController.clear();
                        uname = null;
                        password= null;
                        //   //NavBar(userId,password);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("LogIn successful"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter the details correctly"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },

                  color: Colors.blue, // Changed to green
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
