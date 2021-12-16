import 'package:door/Auth/login.dart';
import 'package:door/private.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('The door is open! Welcome...'),
            ElevatedButton(onPressed: ()=> Get.to(const MyApp()), child: const Text('Private')),
            ElevatedButton(onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Get.offAll(const Login());
            }, child: const Text('logout')),
          ],
        ),
      ),
    );
  }
}
