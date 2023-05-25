// ignore_for_file: must_be_immutable

import 'package:buy_buddy/constants/app_colors.dart';
import 'package:buy_buddy/constants/routes.dart';
import 'package:buy_buddy/models/products_model/products_model.dart';
import 'package:buy_buddy/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductCard extends StatelessWidget {

  String prodName;
  String prodImage;
  String prodPrice;
  ProductModel onPress; 
  ProductCard({super.key, 

    required this.prodName,
    required this.prodImage,
    required this.prodPrice,
    required this.onPress
  });

  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
                      shadowColor: AppColor.primaryColor,
                      surfaceTintColor: AppColor.primaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: size.width*0.4,
                            child: FadeInImage.memoryNetwork(
                              height: 120,
                              width: 100,
                              placeholder: kTransparentImage,
                              image: prodImage,
                              fadeInDuration: const Duration(milliseconds: 300),
                            )
                          ),
                          Text(prodName, style: TextStyle(fontSize: size.width*0.055),),
                          Text("Price: Rs.$prodPrice", style: TextStyle(fontSize: size.width*0.045, color: Colors.green),),
                          OutlinedButton(
                            onPressed: () {
                              Routes.push(ProductDetail(singleProduct: onPress), context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColor.primaryColor
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                            ),
    
    
    
                            child: Text("Buy", style: TextStyle(color: AppColor.primaryColor),),
                          )
                        ],
                      )
                    );
  }
}