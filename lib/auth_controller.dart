import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupid/home.dart';
import 'package:cupid/home_contacts_list.dart';
import 'package:cupid/registration_email_mobile.dart';
import 'package:cupid/registration_gender_dob.dart';
import 'package:cupid/registration_password.dart';
import 'package:cupid/shared_preferences.dart';
import 'package:cupid/signup_login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
          .createUserWithEmailAndPassword(
              email: email!.trim(), password: password!.trim())
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
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
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

  saveGenderAndDob(String _gender, String _dob) {
    gender = _gender;
    dob = _dob;
  }

  saveEmailAndMobile(String _email, String? _mobile) {
    email = _email;
    mobile = _mobile;
  }

  savePassword(String _password) {
    password = _password;
  }

  void contactAdded() {
    Get.snackbar("Contact Added!", "Contact was added successfully!",
        snackPosition: SnackPosition.TOP);
  }

// CupidKnot

  registerCupidKnot() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {
      'full_name': name,
      'email': email,
      'mobile_no': mobile,
      'password': password,
      'c_password': password,
      'gender': gender,
      'dob': dob,
    };

    var url = Uri.parse('http://flutter-intern.cupidknot.com/api/register');
    var res = await http.post(url, headers: headers, body: data);
    print(res.body);
  }

// Sign Up

  fromNamePageToGenderAndDobPage(String first, String last) {
    if (nameValidate(first, last)) {
      saveName(first, last);
      Get.to(() => GenderAndDob());
    }
  }

  nameValidate(String first, String last) {
    if (first.isEmpty) {
      Get.snackbar("First name missing!", "Enter your first name!");
    } else if (last.isEmpty) {
      Get.snackbar("Last name missing!", "Enter your last name!");
    } else {
      return true;
    }
    return false;
  }

  fromGenderAndDobPageToEmailAndMobilePage(bool gender, String dob) {
    saveGenderAndDob(gender ? "MALE" : "FEMALE", dob);
    Get.to(() => EmailAndMobile());
  }

  fromEmailAndMobilePageToPasswordPage(String email, String? mobile) {
    if (validateEmailAndMobile(email, mobile)) {
      saveEmailAndMobile(email, mobile);
      Get.to(() => Password());
    }
  }

  validateEmailAndMobile(String email, String? mobile) {
    if (email.isEmpty) {
      Get.snackbar("Email missing!", "Enter your email address!");
    } else if (!email.contains(EmailValidator.regex)) {
      Get.snackbar("Invalid Email!", "Please enter a valid email!");
    } else if (mobile == null || mobile.isEmpty) {
      Get.snackbar("Mobile Number missing!", "Enter your mobile number!");
    } else if (!mobile.contains(MobileValidator.regex)) {
      Get.snackbar(
          "Invalid Mobile Number!", "Please enter a valid mobile number!");
    } else {
      return true;
    }
    return false;
  }

  fromPasswordPageToHomePage(String password, String passwordConfirmation) {
    if (passwordMismatch(password, passwordConfirmation)) {
      savePassword(password);
      register();
      registerCupidKnot();
    }
  }

  passwordMismatch(password, passwordConfirmation) {
    if (password!.isEmpty) {
      Get.snackbar("Password Missing!", "Enter a password!");
    } else if (passwordConfirmation!.isEmpty) {
      Get.snackbar("Confirm Password!", "Confirm the password!");
    } else if (password != passwordConfirmation) {
      Get.snackbar(
          "Password Mismatch!", "Make sure password is same in both fields!");
    } else {
      return true;
    }
    return false;
  }
}

class EmailValidator {
  static final RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
}

class MobileValidator {
  static final RegExp regex = RegExp(r'^(\+\d{1,3}[- ]?)?\d{10}$');
}
