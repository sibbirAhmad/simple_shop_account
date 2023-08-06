import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gson/gson.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_account/models/api_models.dart';
import 'package:simple_account/utils/sp.dart';
import 'package:simple_account/views/home_page.dart';


class Login extends StatelessWidget {
   const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: LoginSF(),
    );
  }
}

class LoginSF extends StatefulWidget {
   const LoginSF({super.key});

  @override
  State<LoginSF> createState() => _LoginSFState();
}

class _LoginSFState extends State<LoginSF> {

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  userLogin() async{
    var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1");
    http.Response response = await http.get(url);
    var js = json.decode(response.body);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('username', js['title']);
    SP.put("username", js['title']);
    print(prefs.get("username"));
    setState(() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
        return Home();
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Login your Hi',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50.0,),
            TextFormField(
              // onChanged: (val){ //Todo : Not prefffered
              //   _updateText(val);
              // },
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: "Enter username",
                prefixIcon: Icon(Icons.account_circle_outlined),
                // suffixIcon: Icon(Icons.clear),
                border: OutlineInputBorder(),


              ),
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              // onChanged: (val){ //Todo : Not prefffered
              //   _updateText(val);
              // },
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: "Enter password",
                prefixIcon: Icon(Icons.account_circle_outlined),
                // suffixIcon: Icon(Icons.clear),
                border: OutlineInputBorder(),


              ),
            ),
            SizedBox(height: 10.0,),
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () {
                userLogin();
                //Check login
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("My amazing message! O.o")));

              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      )
    );
  }
}

