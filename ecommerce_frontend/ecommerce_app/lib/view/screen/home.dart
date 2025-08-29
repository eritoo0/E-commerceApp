import 'package:ecommerce_app/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeControllerImplement homeController = Get.put(HomeControllerImplement());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${homeController.username}"), // just to test
      ),
      body: Container(),
    );
  }
}
