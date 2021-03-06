import 'package:cupid/main.dart';
import 'package:cupid/view_models/auth_controller.dart';
import 'package:cupid/view_models/firebase_controller.dart';
import 'package:cupid/views/home/home.dart';
import 'package:cupid/models/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
          return Column(
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
                          value: userData![0],
                        ),
                        ProfileCard(
                          type: "Mobile:",
                          value: userData[2],
                        ),
                        ProfileCard(
                          type: "Gender:",
                          value: userData[3],
                        ),
                        ProfileCard(
                          type: "Date of Birth:",
                          value: userData[4],
                        ),
                      ],
                    ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlueButton(
                    text: "Logout",
                    onTap: () {
                      AuthController.instance.signOut();
                    },
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  BlueButton(
                    text: edit ? "Save" : "Edit",
                    onTap: () async {
                      if (edit) {
                        await AuthController.instance.updateUserData(
                            _nameController.text,
                            _mobileController.text,
                            _genderController.text,
                            _dobController.text,
                            userData![5]);
                        setState(() {});
                      } else {
                        _nameController.text = userData![0];
                        _mobileController.text = userData[2];
                        _genderController.text = userData[3];
                        _dobController.text = userData[4];
                      }
                      edit = !edit;
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
