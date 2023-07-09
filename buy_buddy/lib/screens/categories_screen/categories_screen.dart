import 'package:buy_buddy/utils/app_colors.dart';
import 'package:buy_buddy/utils/routes.dart';
import 'package:buy_buddy/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:buy_buddy/models/category_model/category_model.dart';
import 'package:buy_buddy/screens/category_view/category_view.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  ///variables & controller
  bool isLoading = false;
  List<CategoryModel> categoryList = [];
  TextEditingController searchController = TextEditingController();


  ///function to fetch categories
  getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoryList = await FirebaseFirestoreHelper.instance.getCategories();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///appbar here
      appBar: AppBar(
        title: Text("Categories",style: TextStyle(color: AppColor.primaryColor)),
        centerTitle: true,
      ),


      ///body here
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: categoryList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.05),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Routes.push(CategoryView(categoryModel: categoryList[index]),context);
                    },
                    child: Card(
                      elevation: 0,
                      color: AppColor.imgBgColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 4,
                              child: Align(
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: categoryList[index].image,
                                    fadeInDuration:
                                        const Duration(milliseconds: 300),
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 1,
                            child: Text(categoryList[index].name,style: TextStyle(color: AppColor.primaryColor, fontSize: 17)),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
