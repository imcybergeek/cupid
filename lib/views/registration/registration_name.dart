import 'package:cupid/main.dart';
import 'package:cupid/view_models/auth_controller.dart';
import 'package:flutter/material.dart';

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
              BlueButton(
                  onTap: () {
                    AuthController.instance.fromNamePageToGenderAndDobPage(
                        _firstNameController.text, _lastNameController.text);
                  },
                  text: "Next")
            ],
          ),
        ),
      ),
    );
  }
}
