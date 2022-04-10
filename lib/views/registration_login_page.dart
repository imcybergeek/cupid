import 'package:cupid/main.dart';
import 'package:cupid/view_models/firebase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'registration/registration_name.dart';
import 'login/login_page.dart';

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
          firebaseController.getContacts();
          return Scaffold(
            body: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FittedBox(
                        fit: BoxFit.cover,
                        child: Image.asset('assets/couple.jpg')),
                    Positioned(
                      bottom: 100,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlueButton(
                            text: "Sign Up",
                            onTap: () => Get.to(() => Name()),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          BlueButton(
                            text: "Login",
                            onTap: () => Get.to(() => Login()),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
