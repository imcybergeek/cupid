import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../view_models/firebase_controller.dart';

final FirebaseController firebaseController = Get.put(FirebaseController());

class ContactsList extends StatelessWidget {
  const ContactsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirebaseController>(
        init: FirebaseController(),
        initState: (_) {},
        builder: (firebaseController) {
          firebaseController.getContacts();
          return Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Contacts",
                    style: TextStyle(fontSize: 25),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: firebaseController.contacts.length,
                    itemBuilder: (context, index) => ContactCard(
                      id: firebaseController.contacts[index].id,
                      name: firebaseController.contacts[index].name,
                      email: firebaseController.contacts[index].email,
                      mobile: firebaseController.contacts[index].mobile,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ContactCard extends StatelessWidget {
  String? id;
  String? name;
  String? email;
  String? mobile;

  ContactCard({
    Key? key,
    this.id,
    this.name,
    this.email,
    this.mobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${name}",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            title: Text(
              "${email}",
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              "${mobile}",
              style: TextStyle(fontSize: 15),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => firebaseController.deleteContact("$id"),
            ),
          ),
        ));
  }
}
