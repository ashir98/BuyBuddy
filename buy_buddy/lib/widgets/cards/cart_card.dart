// ignore_for_file: must_be_immutable

import 'package:buy_buddy/utils/app_colors.dart';
import 'package:buy_buddy/utils/constants.dart';
import 'package:buy_buddy/models/products_model/products_model.dart';
import 'package:buy_buddy/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCard extends StatefulWidget {
  CartCard({super.key, required this.singleProduct});

  ProductModel singleProduct;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int quantity = 1;
  
  

  @override
  void initState() {
    quantity = widget.singleProduct.quantity??1;
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 0,
      color: AppColor.cardBgColor,
      child: SizedBox(
        height: size.height * 0.14,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Card(
                color: AppColor.imgBgColor,
                elevation: 0,
                child: Image.network(widget.singleProduct.image),
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.singleProduct.name,
                            style: TextStyle(fontSize: size.width * 0.05),
                          ),
                          Text(
                            "Rs.${widget.singleProduct.price}",
                            style: TextStyle(
                                fontSize: size.width * 0.04,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                                appProvider.updateQty(widget.singleProduct, quantity);
                              }
                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColor.primaryColor,
                              child: Icon(
                                Icons.remove,
                                color: AppColor.cardBgColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              appProvider.updateQty(widget.singleProduct, quantity);
                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColor.primaryColor,
                              child: Icon(
                                Icons.add,
                                color: AppColor.cardBgColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Add to wishlist",
                              style: TextStyle(
                                color: AppColor.secondaryColor,
                                fontSize: 15,
                              ),
                            ),
                          ),

                          Consumer<AppProvider>(
                            builder:(context, value, child) =>GestureDetector(
                              onTap: () {
                                value.removeFromCart(widget.singleProduct);
                                showMessage("Item removed!");
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColor.secondaryColor,
                                child: Icon(
                                  Icons.delete,
                                  color: AppColor.cardBgColor,
                                  size: size.width*0.05,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
