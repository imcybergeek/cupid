import 'package:cupid/view_models/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class EmailAndMobile extends StatelessWidget {
  const EmailAndMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PhoneNumber number = PhoneNumber(isoCode: 'IN');
    var _emailController = TextEditingController();
    String? mobile;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 20.0),
                      labelText: 'Email Address',
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
                ElevatedButton(
                    onPressed: () {
                      AuthController.instance
                          .fromEmailAndMobilePageToPasswordPage(
                              _emailController.text, mobile);
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
