import 'package:cupid/main.dart';
import 'package:cupid/view_models/firebase_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

PhoneNumber number = PhoneNumber(isoCode: 'IN');
var _nameController = TextEditingController();
var _emailController = TextEditingController();
var _mobileController = TextEditingController();
String? mobile;

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
            textFieldController: _mobileController,
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
        BlueButton(
          text: "Submit",
          onTap: () async {
            if (await FirebaseController.instance.createContact(
                _nameController.text, _emailController.text, mobile)) {
              _nameController.text =
                  _mobileController.text = _emailController.text = mobile = "";
            }
          },
        ),
      ],
    );
  }
}
