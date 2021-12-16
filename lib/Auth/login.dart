import 'dart:convert';
import 'dart:developer';

import 'package:door/Auth/register.dart';
import 'package:door/Widgets/heading.dart';
import 'package:door/Widgets/input.dart';
import 'package:door/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {

 const Login({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    login(email, password) async {

      const url = 'http://192.168.1.64:8000/login';

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password
        }),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var parse = jsonDecode(response.body);
      if(parse['token'] == null){
        log('No token received!');
      } else {
        await prefs.setString('token', parse['token']);
      } 
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            MyHeading(text: 'Login'),
            MyInput(controller: emailController, hintText: 'Enter your email address', secret: false,),
            MyInput(controller: passwordController, hintText: 'Enter your password', secret: true,),
            ElevatedButton(onPressed: () async {
              await login(emailController.text, passwordController.text);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? token = prefs.getString('token');
              log('Button Pressed: $token token recieved from login');
              if(token != null){
                Get.offAll(const Home());
              }
            }, child: const Text('Login')),
            TextButton(onPressed: (){
              Get.to(const Register());
            }, child: const Text('Register')),
          ],
        ),
      ),
    );
  }
}