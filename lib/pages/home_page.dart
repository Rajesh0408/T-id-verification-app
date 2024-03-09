import 'package:flutter/material.dart';
import 'package:tid_verification/pages/signup_page.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('T-id verfication app'),
      ),
        body: Center(
          child: Row(

            children: [
              Padding(
                padding: const EdgeInsets.only(left:98.0),
                child: ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(),));
                }, child: Text("Signup")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 48.0),
                child: ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                }, child: Text("Login")),
              )
            ],
          ),
        ),
    );
  }
}
