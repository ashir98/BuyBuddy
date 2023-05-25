// ignore_for_file: must_be_immutable

import 'package:buy_buddy/constants/app_colors.dart';
import 'package:buy_buddy/models/products_model/products_model.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  ProductModel singleProduct;
  ProductDetail({required this.singleProduct, super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  bool isFav = true;
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          
          children: [
            Image.network(widget.singleProduct.image,width: 300,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.singleProduct.name, style: const TextStyle(fontSize: 25),),
                IconButton(
                  icon: Icon(
                    isFav
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      isFav = !isFav;
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 10,),
            Text(
              widget.singleProduct.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 15,),
        
            Row(
              children: [
        
                ElevatedButton(
                  onPressed: () {
                    if(quantity>1){
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  child: const Icon(Icons.remove, color: Colors.white,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("$quantity",style: const TextStyle(fontSize: 25),),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: const Icon(Icons.add,color: Colors.white,),
                )
                
        
              ],
            ),

            const SizedBox(height: 50,),
        
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: const Text("Add to cart" ,style: TextStyle(color: Colors.white),),
                ),
        
                OutlinedButton(
                  
                  onPressed: () {
                    
                  },
        
                  style: OutlinedButton.styleFrom(
                    
                    side: BorderSide(
                      color: AppColor.primaryColor
                    )
                  ),
                  child: Text("Buy", style: TextStyle(color: AppColor.primaryColor),),
                )                  
              ],
            )
          ],
        ),
      ),
    );
  }
}