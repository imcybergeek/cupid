import 'package:cupid/auth_controller.dart';
import 'package:cupid/registration_email_mobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool male = false;
bool female = false;
String dateTime = "1990-01-01";

class GenderDob extends StatefulWidget {
  const GenderDob({Key? key}) : super(key: key);

  @override
  State<GenderDob> createState() => _GenderDobState();
}

class _GenderDobState extends State<GenderDob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Gender",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          male = !male;
                          female = false;
                        });
                      },
                      child: Text(
                        "MALE",
                        style: TextStyle(
                            color: male ? Colors.white : Colors.black),
                      ),
                      color: male ? Colors.blueGrey : Colors.white,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          female = !female;
                          male = false;
                        });
                      },
                      child: Text(
                        "FEMALE",
                        style: TextStyle(
                            color: female ? Colors.white : Colors.black),
                      ),
                      color: female ? Colors.blueGrey : Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Date of Birth",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 100,
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime(1990, 1, 1),
                      onDateTimeChanged: (DateTime date) {
                        setState(() {
                          dateTime = DateFormat('yyyy-MM-dd').format(date);
                        });
                      }),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () {
                      String gender = male ? "male" : "female";
                      AuthController.instance.saveGenderDob(gender, dateTime);

                      Get.to(() => EmailMobile());
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
