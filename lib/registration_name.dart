import 'package:cupid/auth_controller.dart';
import 'package:cupid/registration_gender_dob.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Name extends StatelessWidget {
  const Name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _firstNameController = TextEditingController();
    var _lastNameController = TextEditingController();

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 20.0),
                    labelText: 'First Name',
                  )),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 20.0),
                    labelText: 'Last Name',
                  )),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_firstNameController.text.isNotEmpty &&
                        _lastNameController.text.isNotEmpty) {
                      AuthController.instance.saveName(
                          _firstNameController.text, _lastNameController.text);
                      Get.to(() => GenderDob());
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
