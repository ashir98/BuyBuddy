// ignore_for_file: must_be_immutable

import 'package:buy_buddy/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  String image;
  CarouselCard({required this.image ,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(

      elevation: 0.3,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors:[
              AppColor.secondaryColor.withAlpha(70),
              AppColor.primaryColor.withAlpha(100),
            ],
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Upto \n50% off",
                      style: TextStyle(
                          fontSize: 30 ,
                          color: AppColor.primaryColor.withAlpha(250),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "On your favourite products",
                      style: TextStyle(color: AppColor.secondaryColor, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.network(
                  image,
                  width: 200,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
