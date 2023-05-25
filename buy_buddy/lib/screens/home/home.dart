import 'package:buy_buddy/constants/app_colors.dart';
import 'package:buy_buddy/constants/asset_images.dart';
import 'package:buy_buddy/constants/routes.dart';
import 'package:buy_buddy/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:buy_buddy/models/category_model/category_model.dart';
import 'package:buy_buddy/models/products_model/products_model.dart';
import 'package:buy_buddy/screens/category_view/category_view.dart';
import 'package:buy_buddy/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoryList = [];
  List<ProductModel> topProductsList = [];

  bool isLoading = false;

  getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    categoryList = await FirebaseFirestoreHelper.instance.getCategories();
    topProductsList =
        await FirebaseFirestoreHelper.instance.getTopSellingProducts();
    topProductsList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            AssetImages().appLogo,
            width: 130,
          ),
        ),
        body:isLoading
                      ? Center(child: const CircularProgressIndicator())
                      : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.primaryColor.withOpacity(0.1),
                      contentPadding: const EdgeInsets.all(18),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColor.primaryColor.withOpacity(0.5),
                      ),
                      hintText: "Search products",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),
                Text(
                  "Category",
                  style: TextStyle(
                      fontSize: size.width * 0.07, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                          children: categoryList
                              .map((e) => GestureDetector(
                                onTap: (){
                                  Routes.push(CategoryView(categoryModel: e), context);
                                  print(e.id);
                                },
                                child: Card(
                                      surfaceTintColor: AppColor.primaryColor,
                                      shadowColor: AppColor.primaryColor,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 70,
                                            width: 70,
                                            child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image: e.image,
                                              fadeInDuration:
                                                  const Duration(milliseconds: 300),
                                            ),
                                          ),
                                          Text(e.name)
                                        ],
                                      ),
                                    ),
                              ))
                              .toList(),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "Top Selling",
                    style: TextStyle(
                        fontSize: size.width * 0.07,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
