import 'dart:convert';
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

import '../../main.dart';
import '../searchscreen/search_scr.dart';
class LoginPageController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String deviceName = '';
  String appVersion = '';
  String deviceId = '';
  String version = '2';
  RxBool rememberMe = false.obs;

  toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
      }

  Future<void> login() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    deviceId = (await getDeviceId())!;
    deviceName = (await getDeviceName())!;
    String url = 'https://salesapp.infistack.com/api/login';
    Map<String, dynamic> body = {
      "email": emailController.text,
      "password": passwordController.text,
      "device_name": deviceName,
      "device_id": deviceId,
      "app_version": appVersion,
    };
    Map<String, String> headers = {
      'X-API-Version': version,
      'AppVersion': appVersion,
      'platform':  Platform.isAndroid ? "Android" : "IOS",
    };

    try {
      print('BODY ==== ${body}');
      print('HEADER ==== ${headers}');
      final response = await http.post(Uri.parse(url), body: body, headers: headers);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("====RESPONCE DARA ++++++++${responseData}");
        print("====RESPONCE  --------${response}");
        String token = responseData['token'];
        box.write('token', token);
        box.write('isLoggedIn', true);
        Get.to(SearchScreen(),arguments: token);
      } else {
        Get.snackbar('Error', 'Login Failed');
      }
    } catch (error) {
      print(error);
      Get.snackbar('Error', 'An error occurred');
    }
  }


  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      print(androidDeviceInfo.id);
      return androidDeviceInfo.id;
    }
  }
  Future<String?> getDeviceName() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.name;
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.device;
    }
  }

  bool isLoggedIn() {
    return box.read('isLoggedIn') ?? false;
  }

  String? getToken() {
    return box.read('token');
  }

}