import 'package:cupid/view_models/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

bool gender = true;
String dateTime = "1990-01-01";

class GenderAndDob extends StatefulWidget {
  const GenderAndDob({Key? key}) : super(key: key);

  @override
  State<GenderAndDob> createState() => _GenderAndDobState();
}

class _GenderAndDobState extends State<GenderAndDob> {
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
                          gender = true;
                        });
                      },
                      child: Text(
                        "MALE",
                        style: TextStyle(
                            color: gender ? Colors.white : Colors.black),
                      ),
                      color: gender ? Colors.blueGrey : Colors.white,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          gender = false;
                        });
                      },
                      child: Text(
                        "FEMALE",
                        style: TextStyle(
                            color: gender ? Colors.black : Colors.white),
                      ),
                      color: gender ? Colors.white : Colors.blueGrey,
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
                      AuthController.instance
                          .fromGenderAndDobPageToEmailAndMobilePage(
                              gender, dateTime);
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
