import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

import '../../main.dart';
class SearchPageController extends GetxController{
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

String appVersion = '';
String token = '';
  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      nextPage();
    }
  }
getToken(){
  token = box.read('token');
  print("get token method=======token${token}");

}
  @override
  void onInit() {
    getVersion();
    super.onInit();
  }
  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    getToken();
  }

  List<dynamic> userList = [];
  var isLoading = false.obs;
  var page = 1.obs;

  Future<void> searchUsers() async {
    try {
      isLoading(true);
      if (searchController.text.trim().split(' ').length == 1) {
        userList.clear();
        page.value=1;
      }

      String uri = 'https://salesapp.infistack.com/api/sales/my-team?page=${page.value}&name=${searchController.text}';
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'X-API-Version': '2',
          'AppVersion': appVersion,
          'platform': Platform.isAndroid ? 'Android' : 'iOS',
          'Authorization': 'Bearer $token',
        },
      );
      print(uri);
      print(appVersion);
      print(token);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var users = data['data'];
        print(response.headers);
        print(response.body);
        print(response.statusCode);
        print(users);
        if (users is List) {
          userList.addAll(users);
          print("USER LIST =======${userList}");
        } else {
          print('Error: Data is not a List');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e, t) {
      print('Exception: $e');
      print('Trace: $t');
    } finally {
      isLoading(false);
    }
  }


void nextPage() {
    page.value++;
    print('next page callled');
    searchUsers();
  }
}
