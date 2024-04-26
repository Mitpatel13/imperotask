import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:impero_task/screen/login/login_ctr.dart';
import 'package:impero_task/screen/login/login_scr.dart';
import 'package:impero_task/screen/searchscreen/search_scr.dart';

late GetStorage box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(LoginPageController());
  box = GetStorage();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
      box.read('isLoggedIn') ?? false ? const SearchScreen() : LoginPage(),
    );
  }
}
