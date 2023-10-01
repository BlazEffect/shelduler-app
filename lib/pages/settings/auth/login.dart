import 'package:flutter/material.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';

import 'package:scheduler/services/auth_service.dart';

class LoginPage extends StatefulWidget  {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";

    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onSaved: (value) => email = value!.trim(),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  onSaved: (value) => password = value!.trim(),
                ),
                errorWidget(),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      final form = formKey.currentState;
                      form?.save();
                      var error = await AuthService().signIn(email, password);

                      setState(() {
                        errorMessage = error;
                      });
                    },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      elevation: 5.0,
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    ),
                    child: const Text('Войти')
                  ),
                ),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                elevation: 5.0,
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              ),
              child: const Text('Зарегестрироваться')
            ),
          )
        ],
      ),
      bottomNavigationBar: const AppNavigationBar(
        shape: CircularNotchedRectangle(),
      )
    );
  }

  Widget errorWidget() {
    if (errorMessage.isNotEmpty) {
      return Text(
          errorMessage,
          style: const TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300
          ),
        );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }
}