import 'package:cupid/view_models/auth_controller.dart';
import 'package:flutter/material.dart';

class Password extends StatelessWidget {
  const Password({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _passwordController = TextEditingController();
    var _confirmPasswordController = TextEditingController();

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 20.0),
                    labelText: 'Enter Password',
                  )),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 20.0),
                    labelText: 'Confirm Password',
                  )),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    AuthController.instance.fromPasswordPageToHomePage(
                        _passwordController.text,
                        _confirmPasswordController.text);
                  },
                  child: Text(
                    "Complete",
                    style: TextStyle(fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
