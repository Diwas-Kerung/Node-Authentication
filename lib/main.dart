import 'package:door/Auth/login.dart';
import 'package:door/home.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

 main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String? token = prefs.getString('token'); 
   if(token != null){
     runApp(const DoorIn());
   } else {
     runApp(const Door());
   }
}

class Door extends StatelessWidget {
  const Door({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      home: const Login(),
    );
  }
}

class DoorIn extends StatelessWidget {
  const DoorIn({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      home: const Home(),
    );
  }
}


