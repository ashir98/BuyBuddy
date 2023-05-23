import 'package:buy_buddy/constants/app_colors.dart';
import 'package:buy_buddy/constants/asset_images.dart';
import 'package:buy_buddy/constants/routes.dart';
import 'package:buy_buddy/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:buy_buddy/models/category_model/category_model.dart';
import 'package:buy_buddy/models/products_model/products_model.dart';
import 'package:buy_buddy/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<CategoryModel> categoryList = [];
  List<ProductModel> topProductsList= [];

  bool isLoading = false;

  getCategoryList()async{

    setState(() {
      isLoading = true;
    });

    categoryList = await FirebaseFirestoreHelper.instance.getCategories();
    topProductsList = await FirebaseFirestoreHelper.instance.getTopSellingProducts();
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
      onTap:() => FocusScope.of(context).unfocus(),
      child: Scaffold(
    
        appBar: AppBar(
          title: Image.asset(AssetImages().appLogo, width: 130,),
        ),
    
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.primaryColor.withOpacity(0.1),
                    contentPadding: EdgeInsets.all(18),
                    prefixIcon: Icon(Icons.search,color: AppColor.primaryColor.withOpacity(0.5),),
                    hintText: "Search products",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  
                ),
        
                SizedBox(height: size.width*0.05,),
        
                Text(
                  "Category",
                  style: TextStyle(fontSize: size.width * 0.07, fontWeight: FontWeight.w600),
                ),
        
        
                SizedBox(height: 15,),
        
        
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: isLoading? CircularProgressIndicator():Row(
                    children: categoryList.map((e) => Card(
                      surfaceTintColor:AppColor.primaryColor,
                      shadowColor: AppColor.primaryColor,
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: e.image,
                          fadeInDuration: Duration(milliseconds: 300),
                        ),
                      ),
                    )).toList(),
        
                  ),
                ),
        
                Padding(
                  padding: const EdgeInsets.only(top:15),
                  child: Text(
                    "Top Selling",
                    style: TextStyle(fontSize: size.width * 0.07, fontWeight: FontWeight.w600),
                  ),
                ),    
        
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.65),
                  itemCount: topProductsList.length,
                  itemBuilder: (context, index) {
                    ProductModel singleProduct =topProductsList[index];
                    return  Card(
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
                              image: singleProduct.image,
                              fadeInDuration: Duration(milliseconds: 300),
                            )
                          ),
                          Text(singleProduct.name, style: TextStyle(fontSize: size.width*0.055),),
                          Text("Price: Rs.${singleProduct.price}", style: TextStyle(fontSize: size.width*0.045, color: Colors.green),),
                          OutlinedButton(
                            onPressed: () {
                              Routes.push(ProductDetail(singleProduct: singleProduct), context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColor.primaryColor
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                            ),
    
    
    
                            child: Text("Buy", style: TextStyle(color: AppColor.primaryColor),),
                          )
                        ],
                      )
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



