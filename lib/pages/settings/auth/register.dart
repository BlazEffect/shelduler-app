import 'package:flutter/material.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';

import 'package:scheduler/services/auth_service.dart';
import 'package:scheduler/utils/validators/auth_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  String errorMessage = "";

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
  }

// These all needs to be disposed of once done so let's do that as well.
  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";

    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              }
            );
          },
        ),
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
                  validator: AuthValidator().emailValidator,
                  onSaved: (value) => email = value!.trim(),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: AuthValidator().passwordValidator,
                  controller: passwordController,
                  onSaved: (value) => password = value!.trim(),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Confirm password'),
                  validator: (val) => AuthValidator().confirmPasswordValidator(val, passwordController.text),
                  onSaved: (value) => password = value!.trim(),
                ),
                errorWidget(),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      final form = formKey.currentState;
                      final isValid = form!.validate();

                      if (isValid) {
                        form.save();
                        var error = await AuthService().signUp(email, password);

                        setState(() {
                          errorMessage = error;
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      elevation: 5.0,
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    ),
                    child: const Text('Зарегистрироваться')
                  ),
                ),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                elevation: 5.0,
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              ),
              child: const Text('Уже зарегестрированы?')
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