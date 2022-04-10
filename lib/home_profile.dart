import 'package:cupid/auth_controller.dart';
import 'package:cupid/firebase_controller.dart';
import 'package:cupid/home.dart';
import 'package:cupid/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _nameController = TextEditingController();
    var _mobileController = TextEditingController();
    var _genderController = TextEditingController();
    var _dobController = TextEditingController();
    List<String>? userData = UserPreferences.getUserData();
    bool edit = false;
    final FirebaseController firebaseController = Get.put(FirebaseController());
    return GetBuilder<FirebaseController>(
        init: FirebaseController(),
        initState: (_) {},
        builder: (firebaseController) {
          firebaseController.getProfileData();
          return firebaseController.profile.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    edit
                        ? Column(
                            children: [
                              CustomFormField(
                                controller: _nameController,
                                label: "Full Name",
                              ),
                              CustomFormField(
                                controller: _mobileController,
                                label: "Mobile Number",
                              ),
                              CustomFormField(
                                controller: _genderController,
                                label: "Gender",
                              ),
                              CustomFormField(
                                controller: _dobController,
                                label: "DOB",
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              ProfileCard(
                                type: "Name:",
                                value: firebaseController.profile[0].name,
                              ),
                              ProfileCard(
                                type: "Mobile:",
                                value: firebaseController.profile[0].mobile,
                              ),
                              ProfileCard(
                                type: "Gender:",
                                value: firebaseController.profile[0].gender,
                              ),
                              ProfileCard(
                                type: "Date of Birth:",
                                value: firebaseController.profile[0].dob,
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Log Out",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          onPressed: () {
                            AuthController.instance.signOut();
                          },
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              edit ? "Save" : "Edit",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          onPressed: () async {
                            if (edit) {
                              await firebaseController.updateProfile(
                                  _nameController.text,
                                  _mobileController.text,
                                  _genderController.text,
                                  _dobController.text);
                              edit = !edit;
                            } else {
                              _nameController.text =
                                  firebaseController.profile[0].name;
                              _mobileController.text =
                                  firebaseController.profile[0].mobile;
                              _genderController.text =
                                  firebaseController.profile[0].gender;
                              _dobController.text =
                                  firebaseController.profile[0].dob;
                              edit = !edit;
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    SizedBox(height: 25),
                  ],
                );
        });
  }
}

class ProfileCard extends StatelessWidget {
  String? type;
  String? value;

  ProfileCard({
    Key? key,
    this.type,
    this.value,
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
                  "${type}",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            title: Text(
              "${value}",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ));
  }
}
