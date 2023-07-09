import 'package:buy_buddy/utils/app_colors.dart';
import 'package:buy_buddy/utils/asset_images.dart';
import 'package:buy_buddy/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:buy_buddy/models/products_model/products_model.dart';
import 'package:buy_buddy/provider/app_provider.dart';
import 'package:buy_buddy/widgets/cards/cart_card.dart';
import 'package:buy_buddy/widgets/cards/product_card.dart';
import 'package:buy_buddy/widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  ///variables
  List<ProductModel> topProductsList = [];
  bool isLoading = false;


  ///fetch products data function
  getProductData() async {
    setState(() {
      isLoading = true;
    });

    topProductsList =await FirebaseFirestoreHelper.instance.getTopSellingProducts();
    topProductsList.shuffle();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getProductData();
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
  }

  @override
  Widget build(BuildContext context) {

    ///provider instance
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      
      ////appbar here
      appBar: AppBar(
        title: Text("My Cart",style: TextStyle(color: AppColor.primaryColor),),
        centerTitle: true,
      ),

      ///body here
      body: appProvider.cartProdcutList.isEmpty? isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 230,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),

                          ///illustration and text here
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(AssetImages().emptyCartImage,width: 200),
                              Text("Your cart is Empty!",style: TextStyle(fontSize: 20, color: AppColor.primaryColor, fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24,),

                      Text("Empty cart? Discover new favorites!",style: TextStyle(color: AppColor.titleColor,fontSize: 20,fontWeight: FontWeight.bold),),
                      const SizedBox(
                        height: 5,
                      ),


                      ///discover products gridview here
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.65),
                        itemCount: topProductsList.length,
                        itemBuilder: (context, index) {
                          ProductModel singleProduct = topProductsList[index];
                          return ProductCard(
                            prodName: singleProduct.name,
                            prodImage: singleProduct.image,
                            prodPrice: singleProduct.price,
                            prodCategory: singleProduct.status,
                            onPress: singleProduct,
                          );
                        },
                      ),
                    ],
                  ),
                )


          //// if there are items in cart then that code is here    
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: appProvider.cartProdcutList.length,
                      itemBuilder: (context, index) {
                        return CartCard(
                            singleProduct: appProvider.cartProdcutList[index]);
                      },
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppColor.subTitleColor)),
                            Text("Rs.${appProvider.totalPrice()}",style: TextStyle(color: AppColor.primaryColor, fontSize: 18, fontWeight: FontWeight.bold))
                          ],
                        ),

                        const SizedBox(width: 10,),

                        Expanded(
                          child: PrimaryButton(
                            onPressed:() {
                              
                            }, 
                            title: "Proceed to checkout", 
                            backgroundColor: AppColor.secondaryColor
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 8,)
                ],
              ),
            ),
    );
  }
}
