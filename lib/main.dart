import 'package:cupid/view_models/auth_controller.dart';
import 'package:cupid/view_models/firebase_controller.dart';
import 'package:cupid/models/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserPreferences.init();
  Get.put(AuthController());
  Get.put(FirebaseController());
  runApp(CupidKnot());
}

class CupidKnot extends StatelessWidget {
  const CupidKnot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle myOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: myOverlayStyle,
        child: GetMaterialApp(
          title: "Practical Exam",
          theme: ThemeData(primaryColor: Colors.blue),
          home: Container(
            color: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class BlueButton extends StatelessWidget {
  String text;
  VoidCallback onTap;
  BlueButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ))),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ),
      onPressed: () {
        WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
        onTap();
      },
    );
  }
}
