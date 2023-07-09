// ignore_for_file: deprecated_member_use

import 'package:buy_buddy/utils/app_colors.dart';
import 'package:buy_buddy/utils/asset_images.dart';
import 'package:buy_buddy/utils/routes.dart';
import 'package:buy_buddy/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:buy_buddy/models/category_model/category_model.dart';
import 'package:buy_buddy/models/products_model/products_model.dart';
import 'package:buy_buddy/provider/app_provider.dart';
import 'package:buy_buddy/screens/categories_screen/categories_screen.dart';
import 'package:buy_buddy/screens/category_view/category_view.dart';
import 'package:buy_buddy/screens/product_details/product_details.dart';
import 'package:buy_buddy/utils/sizebox.dart';
import 'package:buy_buddy/widgets/cards/carousel_card.dart';
import 'package:buy_buddy/widgets/cards/product_card.dart';
import 'package:buy_buddy/widgets/textfields/custom_searchBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:badges/badges.dart' as badges;
import 'package:card_swiper/card_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ///variables, lists, controllers
  bool isLoading = false;
  List<CategoryModel> categoryList = [];
  List<ProductModel> topProductsList = [];
  List<ProductModel> filteredProducts = [];
  TextEditingController searchController = TextEditingController();
  Icon customIcon = Icon(EneftyIcons.search_normal_2_outline,color: AppColor.secondaryColor);
  Widget customText = Image.asset(AssetImages().appLogo,width: 160);


  ///fetch categories and products
  getProductData() async {
    setState(() {
      isLoading = true;
    });

    categoryList = await FirebaseFirestoreHelper.instance.getCategories();
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

    ///mediaquery
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        //appbar here
        appBar: AppBar(
          title: customText,
          surfaceTintColor: Colors.transparent,
          actions: [

            ///badge code here
            Consumer<AppProvider>(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: badges.Badge(
                  showBadge: value.cartProdcutList.isEmpty ? false : true,
                  badgeStyle: badges.BadgeStyle(
                    padding: const EdgeInsets.all(5),
                    badgeColor: AppColor.secondaryColor,
                  ),
                  badgeContent: Text(
                    value.badgeNum.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: Icon(EneftyIcons.shopping_bag_bold,color: AppColor.iconColor),
                ),
              ),
            )
          ],
        ),


        ///body here
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //top titles
                      Row(
                        children: [
                          Text("Hot Deals",style: TextStyle(color: AppColor.titleColor,fontSize: size.width * 0.065,fontWeight: FontWeight.w600)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("50% OFF",style: TextStyle(color: AppColor.secondaryColor,fontSize: size.width * 0.065,fontWeight: FontWeight.w600))
                        ],
                      ),

                      5.ph,




                      ///carousel slider here
                      SizedBox(
                        width: double.infinity,
                        height: 170,
                        child: Swiper(
                          physics: const BouncingScrollPhysics(),
                          autoplay: true,
                          autoplayDisableOnInteraction: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Routes.push(ProductDetail(singleProduct: topProductsList[index]),context),
                              child: CarouselCard(
                                image: topProductsList[index].image,
                              ),
                            );
                          },
                          pagination: SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                  size: 5,
                                  activeSize: 6,
                                  color: Colors.grey,
                                  activeColor: AppColor.primaryColor)),
                          control: SwiperControl(
                              color: AppColor.secondaryColor,
                              size: 20,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10)),
                        ),
                      ),


                      20.ph,

                    
                      //category title here & see more
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Categories",style: TextStyle(fontSize: size.width * 0.065,fontWeight: FontWeight.w600,)),
                          GestureDetector(
                              onTap: () {
                                Routes.push(const CategoryScreen(), context);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("See more",style: TextStyle(color: AppColor.secondaryColor,fontWeight: FontWeight.bold,fontSize: 15)),
                                  Icon(EneftyIcons.arrow_right_3_bold,color: AppColor.secondaryColor,size: 20)
                                ],
                              ))
                        ],
                      ),

                      5.ph,



                      ///category card grid here
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 8,
                          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 2,),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Routes.push(CategoryView(categoryModel: categoryList[index]),context),
                              child: Card(
                                elevation: 0,
                                color: AppColor.imgBgColor,
                                child: SizedBox(
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: SizedBox(
                                            height: 45,
                                            width: 80,
                                            child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image: categoryList[index].image,
                                              fadeInDuration: const Duration(milliseconds: 300),
                                            ),
                                          ),
                                        ),
                                        2.ph,

                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              categoryList[index].name,
                                              style: TextStyle(
                                                fontSize: 10.5,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.subTitleColor,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),


                      20.ph,




                      ///top selling and icon
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Top Selling",style: TextStyle(fontSize: size.width * 0.065,fontWeight: FontWeight.w600,)),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(FontAwesomeIcons.fire,color: AppColor.secondaryColor,size: 22)
                        ],
                      ),

                      5.ph,


                      ///top selling gridview cards
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.65),
                        itemCount: filteredProducts.isEmpty? topProductsList.length: filteredProducts.length,
                        itemBuilder: (context, index) {
                          ProductModel singleProduct = filteredProducts.isEmpty? topProductsList[index]: filteredProducts[index];
                          return ProductCard(
                            prodName: singleProduct.name,
                            prodImage: singleProduct.image,
                            prodPrice: singleProduct.price,
                            prodCategory: singleProduct.status,
                            onPress: singleProduct,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),



        ///floating action button here
        floatingActionButton: FloatingActionButton(
          splashColor: AppColor.secondaryColor.withAlpha(80),
          backgroundColor: AppColor.secondaryLightColor,
          onPressed: () {
            setState(() {
              if (customIcon.icon == EneftyIcons.search_normal_2_outline) {
                customIcon = Icon(Icons.cancel,color: AppColor.secondaryColor);

                ///search bar code here
                customText = SearchBar(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      filteredProducts = topProductsList
                          .where((product) => product.name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                          .toList();
                    });
                  },
                );
              } else {
                filteredProducts.clear();
                searchController.clear();
                customIcon = Icon(EneftyIcons.search_normal_2_outline,color: AppColor.secondaryColor);
                customText = customText = Image.asset(AssetImages().appLogo,width: 160);
              }
            });
          },
          child: customIcon,
        ),
      ),
    );
  }
}
