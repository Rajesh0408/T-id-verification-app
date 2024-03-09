import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../validation/regex.dart';
import 'home_page.dart';

class SignupPage extends StatefulWidget {
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  TextEditingController unameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phController = TextEditingController();
  TextEditingController CEGianController = TextEditingController();
  TextEditingController rollnoController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  String? errorText;
  String? email;
  int? ph;
  int? rollno;
  String? department;

  bool isPasswordVisible = false;
  String? uname;
  String? password;
  String? jwt;
  bool logging = false;
  List yearList =['1','2','3','4','5'];
  List isCEGianList = ['Yes','No'];
  bool? isCEGian;
  int? year;
  bool isEmailValid=false;
  bool isPhValid= false;

  Future<bool> authenticateUser(String username, String email, int ph,String password,bool isCEGian,int rollno,String department,int year) async {
    final response = await http.post(
      Uri.parse('https://techofes-website-api.onrender.com/api/t77admin/login'),
      body: jsonEncode(<String, String>{
        "name": username,
        "email": email,
        "phNo" : ph.toString(),
        "password": password,
        "isCegian": isCEGian.toString(),
        "rollNo": rollno.toString(),
        "dept": department,
        "year": year.toString()
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Successful authentication, parse JWT token from response
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        logging = false;
      });
      return true;
    } else {
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
      body: ListView(
        children: [
          Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      "SignUp",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
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
                      hintText: 'Name'),
                ),
              ),
              SizedBox(height: 5),
              logging
                  ? CircularProgressIndicator(
                color: Colors.blue,
              )
                  : Container(),

              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (_value) {
                    setState(() {
                      email = _value.toString();

                        isEmailValid=Validator.isEmailValid(_value);


                    });

                  },
                  controller: emailController,
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: isEmailValid? Colors.grey: Colors.red)
                      ),
                      hintText: 'Email Id',
                      errorText: isEmailValid? null: 'Invalid Email',
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (_value) {
                    setState(() {
                      ph = int.parse(_value);
                      isPhValid = _value.toString().length==10;
                    });

                  },

                  controller: phController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: isPhValid? Colors.grey: Colors.red),
                          borderRadius: BorderRadius.circular(10.0)),
                      hintText: 'Phone number',
                      errorText: isPhValid? null: 'Invalid Phone number'
                  ),
                ),
              ),
              SizedBox(height: 5),
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
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  padding: EdgeInsets.only(left: 10,top: 5 ),
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: DropdownButton<bool>(
                    value: isCEGian,
                    hint: const Text('Are you CEGian'),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: true,
                        child: Text('Yes'),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text('No'),
                      ),
                    ],
                    onChanged: (newValue) {
                      setState(() {
                        isCEGian = newValue;
                      });
                    },
                  ),

                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (_value) {
                    rollno = int.parse(_value);
                  },
                  controller: rollnoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      hintText: 'Roll number'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (_value) {
                    department = _value.toString();
                  },
                  controller: departmentController,
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      hintText: 'Department'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  padding: EdgeInsets.only(left: 10,top: 5 ),
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.black),
                      ),
                  child: DropdownButton(

                      value: year,
                      hint: const Text(
                          'Year'),
                      isExpanded: true,
                      items: yearList.map((values) {
                        return DropdownMenuItem(
                            value: values,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(values),
                            ));
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          year = int.parse(newVal.toString());
                        });

                      }),
                ),
              ),
              SizedBox(height: 13,),
              Container(
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {


                    // uname = unameController.text;
                    // password = passwordController.text;

                    if (uname!.length == 0 || password!.length == 0 || email==null || ph==null || password==null || isCEGian==null ||rollno==null || department==null ||year==null) {
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
                      if (await authenticateUser(uname!, email!,ph!, password!, isCEGian!, rollno!, department!, year! )) {
                        unameController.clear();
                        passwordController.clear();
                        emailController.clear();
                        phController.clear();
                        passwordController.clear();
                        isCEGian=null;
                        rollnoController.clear();
                        departmentController.clear();
                        year=null;
                        email=null;
                        ph=null;
                        rollno=null;
                        department=null;
                        uname = null;
                        password= null;
                        //   //NavBar(userId,password);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("SignUp successful"),
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
                    "SignUp",
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
    ],
      ),
    );
  }
}
