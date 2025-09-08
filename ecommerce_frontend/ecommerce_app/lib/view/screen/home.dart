import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/home/home_app_bar.dart';
import 'package:ecommerce_app/view/widget/home/offer_banner.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: ColorApp.bgColor,
        appBar: HomeAppBar(),
        body: OfferBanner());
  }
}
