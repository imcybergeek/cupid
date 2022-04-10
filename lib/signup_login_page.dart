import 'package:cupid/firebase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'registration_name.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;

class SignUpLogin extends StatelessWidget {
  const SignUpLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirebaseController>(
        init: FirebaseController(),
        initState: (_) {},
        builder: (firebaseController) {
          firebaseController.getData();
          return Scaffold(
            body: SafeArea(
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset('assets/couple.jpg'),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            onPressed: () {
                              // AuthController.instance
                              //     .register("jatinjxd@gmail.com", "password");
                              Get.to(() => Name());
                            },
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            onPressed: () {
                              Get.to(() => Login());
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 48,
                      ),
                    ],
                  )),
            ),
          );
        });
  }
}
