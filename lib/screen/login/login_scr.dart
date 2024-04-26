import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'login_ctr.dart';

class LoginPage extends StatelessWidget {

  final LoginPageController controller = Get.find<LoginPageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/loginimage.png'),
              Center(child: Text('Login',style: TextStyle
                (color: Colors.deepPurple,fontSize: 20,fontWeight: FontWeight.bold),)),
              TextField(
                controller: controller.emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email id / Phone No.',
                    hintText: 'Enter Your Email id / Phone No.',
                  ),
              ),
              SizedBox(height: 20),

              TextField(
                obscureText: true,
                controller: controller.passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter Your Password',
                ),
              ),

              SizedBox(height: 20),
              Obx(() => Row(
                children: [
                  Checkbox(
                    value: controller.rememberMe.value,
                    onChanged: (value) {
                      controller.toggleRememberMe();
                    },
                  ),
                  Text('Remember Me'),
                ],
              )),
              SizedBox(height: 20),

              SizedBox(
                width: Get.width,
                height: 52,
                child:ElevatedButton(
                  onPressed: (){
                    controller.login();
                  },
                  style: ButtonStyle(backgroundColor:
                  MaterialStatePropertyAll(Colors.deepPurple),foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  child: Text('Login'),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
