import 'package:buy_buddy/models/products_model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductDetail extends StatelessWidget {
  ProductModel singleProduct;
  ProductDetail({required this.singleProduct, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(singleProduct.image,width: 300,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(singleProduct.name, style: TextStyle(fontSize: 25),),
                Icon(Icons.favorite_rounded, color: Colors.red,)
              ],
            ),
            SizedBox(height: 10,),
            Text(singleProduct.description, textAlign: TextAlign.justify, style: TextStyle(fontSize: 15),)
          ],
        ),
      ),
    );
  }
}