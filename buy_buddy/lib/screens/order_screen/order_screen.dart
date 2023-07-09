import 'package:buy_buddy/utils/app_colors.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders", style: TextStyle(color: AppColor.primaryColor),),
        centerTitle: true,
      ),
    );
  }
}