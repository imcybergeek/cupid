import 'package:cupid/main.dart';
import 'package:cupid/view_models/auth_controller.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        color: Colors.white,
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
              TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 20.0),
                    labelText: 'Password',
                  )),
              SizedBox(
                height: 25,
              ),
              BlueButton(
                  onTap: () {
                    AuthController.instance.fromLoginPageToHomePage(
                        _emailController.text, _passwordController.text);
                  },
                  text: "Login")
            ],
          ),
        ),
      ),
    );
  }
}
