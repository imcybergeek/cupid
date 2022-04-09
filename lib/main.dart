import 'package:cupid/auth_controller.dart';
import 'package:cupid/signup_login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(CupidKnot());
}

class CupidKnot extends StatelessWidget {
  const CupidKnot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle myOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.white);
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
