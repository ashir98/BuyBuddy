import 'package:buy_buddy/constants/constants.dart';
import 'package:buy_buddy/models/category_model/category_model.dart';
import 'package:buy_buddy/models/products_model/products_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
          print(categoriesList);

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }


    Future<List<ProductModel>> getTopSellingProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> bestSellingProducts = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
          

      return bestSellingProducts;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }



    Future<List<ProductModel>> getCategoryProducts(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").doc(id).collection("products").get();

      List<ProductModel> categoryProducts = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
          

      return categoryProducts;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }  

}
