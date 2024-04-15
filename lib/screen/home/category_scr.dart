import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../design_strip/design_strip_scr.dart';
import 'ceramic_ctrl.dart';
class CeramicScr extends StatefulWidget {
  @override
  State<CeramicScr> createState() => _CeramicScrState();
}

class _CeramicScrState extends State<CeramicScr> {
  final CeramicController ceramicController = Get.put(CeramicController());
@override
  void initState() {
  ceramicController.fetchAllCategories();
  ceramicController.fetchCeramicSubcategories();
  ceramicController.fetchProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(onPressed: (){
        Get.to(()=>const TestStripScr());
      },child: Text("Design Strip"),),
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: Colors.white,),
            onPressed: () {
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list,color: Colors.white,),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            if (ceramicController.categories.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return Container(
              color: Colors.black,
              height: 50, // Set the desired height for the list view
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ceramicController.categories.length,
                itemBuilder: (context, index) {
                  final category = ceramicController.categories[index];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          category.name.toString(),
                          style: TextStyle(
                              fontSize: category.name == "Ceramic" ? 16 : 12,
                              color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),

    Expanded(
    child: Obx(() {
    return ListView.builder(
    itemCount: ceramicController.subcategories.length,
    itemBuilder: (context, index) {
    final subcategory = ceramicController.subcategories[index];

    return ListTile(
    title: Text(
    subcategory.name.toString(),
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Container(
    height: MediaQuery.sizeOf(context).height/10,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: ceramicController.products.length,
    itemBuilder: (context, productIndex) {
      final products = ceramicController.products[index];
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
    children: [
    Stack(
      children: [
        Image.network(
          products.imageName??"",
          height: MediaQuery.sizeOf(context).height/10, // Adjust height as needed
          width: 80,
          fit: BoxFit.fill,// Adjust width as needed
        ),
        Container(color: Colors.blue,child: Text(products.priceCode??""),),

      ],
    ),
    ],
    ),
    );
    },
    ),
    ),
    );
    },
    );
    }),
    )

    ],
      ),
    );
  }
}
