import 'package:cupid/views/home/home_contact_form.dart';
import 'package:cupid/views/home/home_contacts_list.dart';
import 'package:cupid/views/home/home_profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 2;
  final screens = [
    ContactForm(),
    ContactsList(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: screens[_currentIndex],
            ),
          )),
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 35,
          showUnselectedLabels: false,
          elevation: 0,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_contact_cal_rounded),
              label: "Add Contact",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts_rounded),
              label: "Contacts",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            )
          ]),
    );
  }
}

class CustomFormField extends StatelessWidget {
  String? label;
  TextEditingController? controller;
  CustomFormField({
    Key? key,
    this.label,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
            labelText: '${label}',
          )),
    );
  }
}
