import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/category_model.dart';

class CeramicController extends GetxController {
  RxList<Category> categories = <Category>[].obs;
  RxList<SubCategory> subcategories = <SubCategory>[].obs;
  RxList<Product> products = <Product>[].obs;

  Future<void> fetchAllCategories() async {
    final url = Uri.parse('http://esptiles.imperoserver.in/api/API/Product/DashBoard');
    final response = await http.post(url, body: {
      "CategoryId": "0",
      "DeviceManufacturer": "Google",
      "DeviceModel": "Android SDK built for x86",
      "DeviceToken": " ",
      "PageIndex": "1"
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.containsKey('Result') && data['Result'].containsKey('Category')) {
        final List categoriesData = data['Result']['Category'];

        categories.value = categoriesData.map<Category>((e) => Category.fromJson(e)).toList();
      } else {
        print('Error in fetch all categori');
      }
    } else {
      print('Failed to fetch categories.');
    }
  }


  Future<void> fetchCeramicSubcategories() async {
    final url = Uri.parse('http://esptiles.imperoserver.in/api/API/Product/DashBoard');
    final response = await http.post(url, body: {
      "CategoryId": "56",
      "PageIndex": "1",
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("SUB CATEGORIES====${data}");
      if (data.containsKey('Result') && data['Result'].containsKey('Category')) {
        final List categoriesData = data['Result']['Category'][0]["SubCategories"];
        subcategories.value = categoriesData.map<SubCategory>((e) => SubCategory.fromJson(e)).toList();
      } else {
        print('Error in subcategories');
      }
    } else {
      print('Failed to fetch categories. HTTP status code: ${response.statusCode}');
    }
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse('http://esptiles.imperoserver.in/api/API/Product/ProductList');
    final response = await http.post(url, body: {
      "PageIndex": "1",
      "SubCategoryId": "71",
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("PRODUCTS=====${data}");
      if (data.containsKey('Result')) {
        final List categoriesData = data['Result'];
        products.value = categoriesData.map<Product>((e) => Product.fromJson(e)).toList();
      } else {
        print('Error in fetch product');
      }
    }
    else {
      print('Failed to fetch categories. HTTP status code: ${response.statusCode}');
    }
  }
}