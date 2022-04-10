import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupid/auth_controller.dart';
import 'package:cupid/model.dart';
import 'package:cupid/shared_preferences.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  var isLoading = true;
  var contacts = <ContactsModel>[];
  var profile = <ProfileModel>[];
  String? uid = UserPreferences.getUid();
  List<String>? userData = UserPreferences.getUserData();

  Future<void> addContact(
      String id, String name, String email, String mobile) async {
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(userData![1])
        .collection('contacts')
        .doc(id.isNotEmpty ? id : '')
        .set(
      {
        'name': name,
        'email': email,
        'mobile': mobile,
      },
      SetOptions(merge: true),
    ).then(
      (value) => Get.back(),
    );
  }

  Future<void> updateProfile(
      String name, String mobile, String gender, String dob) async {
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(userData![1])
        .set(
      {
        'name': name,
        'mobile': mobile,
        'gender': gender,
        'dob': dob,
      },
      SetOptions(merge: true),
    ).then(
      (value) => Get.back(),
    );
  }

  Future<void> getData() async {
    try {
      QuerySnapshot _taskSnap = await FirebaseFirestore.instance
          .collection('UserData')
          .doc(userData![1])
          .collection('contacts')
          .get();

      contacts.clear();
      for (var item in _taskSnap.docs) {
        contacts.add(
          ContactsModel(
            item.id,
            item['name'],
            item['email'],
            item['mobile'],
          ),
        );
      }
      contacts = contacts.toList();
      isLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getProfileData() async {
    try {
      DocumentSnapshot profileData = await FirebaseFirestore.instance
          .collection('UserData')
          .doc(userData![1])
          .get();

      profile.clear();
      profile.add(
        ProfileModel(
          profileData['name'],
          profileData['mobile'],
          profileData['gender'],
          profileData['dob'],
        ),
      );
      profile = profile.toList();
      isLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  create(String _name, String _email, String? _mobile) {
    final FirebaseController firebaseController = Get.find();
    firebaseController
        .addContact(DateTime.now().millisecondsSinceEpoch.toString(), _name,
            _email, _mobile!)
        .then((value) => AuthController.instance.contactAdded());
  }

  deleteContact(String id) {
    FirebaseFirestore.instance
        .collection('UserData')
        .doc(userData![1])
        .collection('contacts')
        .doc(id)
        .delete();
  }

  setUid(String _uid) {
    uid = _uid;
  }
}
