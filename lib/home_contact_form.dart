import 'package:cupid/firebase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

PhoneNumber number = PhoneNumber(isoCode: 'IN');
var _nameController = TextEditingController();
var _emailController = TextEditingController();
String mobile = "";

class ContactForm extends StatelessWidget {
  const ContactForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Contact Form",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 25,
        ),
        TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: const OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
              labelText: 'Full Name',
            )),
        SizedBox(
          height: 25,
        ),
        InternationalPhoneNumberInput(
            initialValue: number,
            inputBorder: OutlineInputBorder(),
            onInputChanged: (phone) {
              mobile = phone.toString();
            }),
        SizedBox(
          height: 25,
        ),
        TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: const OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
              labelText: 'Email Address',
            )),
        SizedBox(
          height: 25,
        ),
        ElevatedButton(
            onPressed: () {
              final FirebaseController firebaseController =
                  Get.put(FirebaseController());
              firebaseController.create(
                  _nameController.text, _emailController.text, mobile);
            },
            child: Text(
              "Submit",
              style: TextStyle(fontSize: 18),
            )),
      ],
    );
  }
}
