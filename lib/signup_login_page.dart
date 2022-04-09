import 'package:cupid/auth_controller.dart';
import 'package:cupid/firebase_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'registration_name.dart';
import 'login_page.dart';

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
                      Image.asset('assets/couple.jpg'),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                //   final dio = Dio();
                                //   var hi = await dio.post(
                                //     "http://flutter-intern.cupidknot.com/api/",
                                //     data: {
                                //       'full_name': 'Practical Test',
                                //       'email': 'test@testing.com'
                                //     },
                                //     options: Options(
                                //         contentType: Headers.formUrlEncodedContentType),
                                //   );
                              },
                              child: Text("Create")),
                          ElevatedButton(
                              onPressed: () {
                                final FirebaseController firebaseController =
                                    Get.put(FirebaseController());

                                firebaseController.edit();
                              },
                              child: Text("Edit")),
                          ElevatedButton(
                              onPressed: () {
                                final FirebaseController firebaseController =
                                    Get.put(FirebaseController());

                                firebaseController.delete("XD");
                              },
                              child: Text("Delete")),
                          ElevatedButton(
                              onPressed: () {
                                final FirebaseController firebaseController =
                                    Get.put(FirebaseController());
                                print(firebaseController.contacts.length);
                              },
                              child: Text("Read")),
                        ],
                      ),
                      // SizedBox(
                      //   height: 48,
                      // ),
                    ],
                  )),
            ),
          );
        });
  }
}
