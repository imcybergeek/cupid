import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupid/contact_form_model.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  var isLoading = true;
  var contacts = <ContactFormModel>[];

  Future<void> addTransaction(
      String id, String name, String email, String mobile) async {
    await FirebaseFirestore.instance
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

  Future<void> getData() async {
    try {
      QuerySnapshot _taskSnap =
          await FirebaseFirestore.instance.collection('contacts').get();

      contacts.clear();
      for (var item in _taskSnap.docs) {
        contacts.add(
          ContactFormModel(
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
    FirebaseFirestore.instance.collection('contacts').doc(id).delete();
  }
}
