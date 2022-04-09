import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupid/model.dart';
import 'package:cupid/shared_preferences.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  var isLoading = true;
  var contacts = <ContactsModel>[];
  var profile = <ProfileModel>[];
  String? uid = UserPreferences.getUid();

  Future<void> addTransaction(
      String id, String name, String email, String mobile) async {
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(uid)
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
    await FirebaseFirestore.instance.collection('UserData').doc(uid).set(
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
          .doc(uid)
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
      QuerySnapshot _taskSnap =
          await FirebaseFirestore.instance.collection('UserData').get();

      profile.clear();
      for (var item in _taskSnap.docs) {
        profile.add(
          ProfileModel(
            item['name'],
            item['mobile'],
            item['gender'],
            item['dob'],
          ),
        );
      }
      profile = profile.toList();
      isLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  create(String _name, String _email, String _mobile) {
    final FirebaseController firebaseController = Get.find();
    firebaseController.addTransaction(
        DateTime.now().millisecondsSinceEpoch.toString(),
        _name,
        _email,
        _mobile);
  }

  edit() {
    final FirebaseController firebaseController = Get.find();
    firebaseController.addTransaction(
        "1649453982241", "Jatin Joshi", "jatinjxd@gmail.com", "7906160705");
  }

  delete(String id) {
    FirebaseFirestore.instance
        .collection('UserData')
        .doc(uid)
        .collection('contacts')
        .doc(id)
        .delete();
  }

  setUid(String _uid) {
    uid = _uid;
  }

  display() {
    print(uid);
  }
}
