import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:impero_task/screen/login/login_ctr.dart';
import 'package:impero_task/screen/login/login_scr.dart';
import 'package:impero_task/screen/searchscreen/search_scr.dart';
late GetStorage box;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await GetStorage().initStorage;
  box = GetStorage();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginPageController());

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
      box.read('isLoggedIn') ?SearchScreen() :
      LoginPage(),
    );
  }
}