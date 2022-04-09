import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupid/home.dart';
import 'package:cupid/home_contacts_list.dart';
import 'package:cupid/shared_preferences.dart';
import 'package:cupid/signup_login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

String? name;
String? gender;
String? dob;
String? email;
String? mobile;
String? password;

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => SignUpLogin());
    } else {
      Get.offAll(() => Home());
    }
  }

  void register() async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        firebaseController.setUid(value.user!.uid);
        FirebaseFirestore.instance
            .collection('UserData')
            .doc(value.user!.uid)
            .set({
          "name": name,
          "mobile": mobile,
          "gender": gender,
          "dob": dob,
        });
        UserPreferences.setUid(value.user!.uid);
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Account Creation Failed", e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void login(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        firebaseController.setUid(value.user!.uid);
        UserPreferences.setUid(value.user!.uid);
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Failed", e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() {
    auth.signOut();
  }

  saveName(String _first, String _last) {
    name = _first + " " + _last;
  }

  saveGenderDob(String _gender, String _dob) {
    gender = _gender;
    dob = _dob;
  }

  saveEmailMobile(String _email, String? _mobile) {
    email = _email;
    mobile = _mobile;
  }

  savePassword(String _password) {
    password = _password;
  }

  void display() {
    print("$name + $gender + $dob + $email + $mobile + $password");
  }
}
