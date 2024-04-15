import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class DesignController extends GetxController{
  List<dynamic> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
  ];
TextEditingController chooseColor = TextEditingController();
  RxList<String> colorNames = ['Red', 'Green', 'Blue', 'Yellow', 'Purple'].obs;

}