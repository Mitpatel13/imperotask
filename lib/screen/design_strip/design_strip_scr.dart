import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:impero_task/screen/design_strip/design_strip_ctrl.dart';

import '../home/category_scr.dart';
class TestStripScr extends StatefulWidget {
  const TestStripScr({super.key});

  @override
  State<TestStripScr> createState() => _TestStripScrState();
}

class _TestStripScrState extends State<TestStripScr> {
final DesignController controller = Get.put(DesignController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: (){
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.grey
              ,),padding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),child: Text('Next',style: TextStyle(color: Colors.white),),),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Column(
              children: [
                Text('Test Strip',style:
                TextStyle(fontSize: 30,fontWeight: FontWeight.bold,
                    color: Colors.lightBlue),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                SizedBox(),
                Text('Total Hardness (ppm)'),
                SizedBox(height:20,width:50,child:
                TextField(decoration: InputDecoration(border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),))
                          ],
                        ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                    List.generate(controller.colors.length, (index) {
                      return
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(height: 20,width: 30,color: controller.colors[index]),
                        );
                    })
                  ,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                            SizedBox(),
                            Text('Total Clorine (ppm)'),
                            SizedBox(height:20,width:50,child:
                            TextField(decoration: InputDecoration(border:
                            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),))
              ],
            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:
                                List.generate(controller.colors.length, (index) {
                                  return
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(height: 20,width: 30,color: controller.colors[index]),
            );
                                })
                              ,
                            ),
          ]

        ),
      ),
    );
  }
}
