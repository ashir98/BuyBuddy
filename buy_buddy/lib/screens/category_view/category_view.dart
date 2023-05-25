// ignore_for_file: must_be_immutable

import 'package:buy_buddy/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:buy_buddy/models/category_model/category_model.dart';
import 'package:buy_buddy/models/products_model/products_model.dart';
import 'package:buy_buddy/widgets/product_card.dart';
import 'package:flutter/material.dart';


class CategoryView extends StatefulWidget {
  CategoryModel categoryModel;
  CategoryView({required this.categoryModel ,super.key});

  

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {


  List<ProductModel> topProductsList= [];

  bool isLoading = false;
    getCategoryList()async{

    setState(() {
      isLoading = true;
    });

    topProductsList = await FirebaseFirestoreHelper.instance.getCategoryProducts(widget.categoryModel.id);
    topProductsList.shuffle();
    setState(() {
      isLoading = false;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    getCategoryList();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: isLoading? Center(child: CircularProgressIndicator(),): Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.categoryModel.name,
              style: TextStyle(
                fontSize: 22
              ),
            ),

            SizedBox(height: 10,),
            GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.65),
                        itemCount: topProductsList.length,
                        itemBuilder: (context, index) {
                          ProductModel singleProduct = topProductsList[index];
                          return ProductCard(
                            prodName: singleProduct.name,
                            prodImage: singleProduct.image,
                            prodPrice: singleProduct.price,
                            onPress: singleProduct,
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}