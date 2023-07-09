// ignore_for_file: must_be_immutable

import 'package:buy_buddy/utils/app_colors.dart';
import 'package:buy_buddy/utils/constants.dart';
import 'package:buy_buddy/utils/routes.dart';
import 'package:buy_buddy/models/products_model/products_model.dart';
import 'package:buy_buddy/provider/app_provider.dart';
import 'package:buy_buddy/screens/checkout_screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:enefty_icons/enefty_icons.dart';

class ProductDetail extends StatefulWidget {
  ProductModel singleProduct;
  ProductDetail({required this.singleProduct, super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  ///variables
  bool isFav = true;
  int quantity = 1;


  @override
  Widget build(BuildContext context) {

    ///mediaquery instance
    final size = MediaQuery.of(context).size;
    
    ///provider instance
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(

      ///appbar here
      appBar: AppBar(
        title: Text("Product details",style: TextStyle(color: AppColor.primaryColor)),
        centerTitle: true,
      ),

      ///body here
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [

            ///product image here
            SizedBox(
              height: 280,
              child: Card(
                color: AppColor.imgBgColor,
                elevation: 0.2,
                child: Image.network(widget.singleProduct.image, width: 300),
              ),
            ),

            SizedBox(height: 8,),

            ////title ,price , favbtn
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                //product name and price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.singleProduct.name,style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                    Text("Rs.${widget.singleProduct.price}",style:TextStyle(fontSize: 20, color: AppColor.primaryColor, fontWeight: FontWeight.w500)),
                  ],
                ),

                ///fav button & product increment decrement
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Icon(
                        widget.singleProduct.isFav? EneftyIcons.heart_bold: EneftyIcons.heart_outline,
                        color: AppColor.primaryColor,
                        size: 30,
                      ),
                      onTap: () {
                        setState(() {
                          widget.singleProduct.isFav = !widget.singleProduct.isFav;
                        });

                        if (widget.singleProduct.isFav) {
                          appProvider.addToFav(widget.singleProduct);
                          showMessage("Added to Favourites!");
                        } else {
                          appProvider.removeFromFav(widget.singleProduct);
                          showMessage("Removed  from Favourites");
                        }
                      },
                    ),





                    // Row(
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         if (quantity > 1) {
                    //           setState(() {
                    //             quantity--;
                    //           });
                    //         }
                    //       },
                    //       child: Card(
                    //         color: AppColor.primaryColor,
                    //         child: Icon(Icons.remove,color: Colors.white,)
                    //       )
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 5),
                    //       child: Text(
                    //         "$quantity",
                    //         style: TextStyle(fontSize: size.width * 0.05),
                    //       ),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         setState(() {
                    //           quantity++;
                    //         });
                    //       },
                    //       child: Card(
                    //         color: AppColor.primaryColor,
                    //         child: Icon(Icons.add,color: Colors.white,)
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                )
              ],
            ),


            const SizedBox(
              height: 10,
            ),


            ///prod description
            const Text("Product Description",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 5,
            ),
            Text(widget.singleProduct.description,textAlign: TextAlign.justify,style: TextStyle(fontSize: 15, color: AppColor.subTitleColor)),
            
            const SizedBox(
              height: 15,
            ),


            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  child: Card(
                    elevation: 0,
                    color: AppColor.primaryColor,
                    child: Icon(Icons.remove,color: Colors.white,)
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "$quantity",
                    style: TextStyle(fontSize: size.width * 0.05),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: Card(
                    elevation: 0,
                    color: AppColor.primaryColor,
                    child: Icon(Icons.add,color: Colors.white,)
                  ),
                )
              ],
            ),

          
            
            ///product increment decrement and add to cart button
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [   

                  Consumer<AppProvider>(
                    builder: (context, value, child) => Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColor.secondaryColor),
                          onPressed: () {
                            ProductModel productModel =
                                widget.singleProduct.copyWith(quantity: quantity);
                            value.addToCart(productModel);
                            showMessage("Added to Cart!");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.cartShopping,
                                color: AppColor.cardBgColor,
                                size: 17,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Add to cart",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            side: BorderSide(color: AppColor.secondaryColor)),
                        onPressed: () {
                          ProductModel productModel =
                              widget.singleProduct.copyWith(quantity: quantity);
                          Routes.push(
                              CheckOut(
                                singleProduct: productModel,
                              ),
                              context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.dollarSign,
                              color: AppColor.secondaryColor,
                              size: 17,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Buy",
                              style: TextStyle(
                                  color: AppColor.secondaryColor, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
