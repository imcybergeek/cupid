import 'package:cupid/auth_controller.dart';
import 'package:cupid/firebase_controller.dart';
import 'package:cupid/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseController firebaseController = Get.put(FirebaseController());
    return GetBuilder<FirebaseController>(
        init: FirebaseController(),
        initState: (_) {},
        builder: (firebaseController) {
          firebaseController.getData();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Profile",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 25,
              ),
              CustomFormField(
                label: "Full Name",
              ),
              CustomFormField(
                label: "Mobile Number",
              ),
              CustomFormField(
                label: "Gender",
              ),
              CustomFormField(
                label: "DOB",
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                onPressed: () {},
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Log Out",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                onPressed: () {
                  AuthController.instance.signOut();
                },
              ),
            ],
          );
        });
  }
}
