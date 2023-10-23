import 'package:flutter/material.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';

import 'package:scheduler/services/auth_service.dart';
import 'package:scheduler/utils/validators/auth_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _emailError;
  String? _passwordError;
  String? _repeatPasswordError;

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Зарегестрироваться'),
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      contentPadding: const EdgeInsets.only(left: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(7)
                      ),
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      _emailError = AuthValidator().emailValidator(value);
                      return null;
                    },
                  )
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      contentPadding: const EdgeInsets.only(left: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(7)
                      ),
                      hintText: 'Пароль',
                    ),
                    validator: (value) {
                      _passwordError = AuthValidator().passwordValidator(value);
                      return null;
                    },
                  )
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      contentPadding: const EdgeInsets.only(left: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(7)
                      ),
                      hintText: 'Подтвердить пароль',
                    ),
                    validator: (value) {
                      _repeatPasswordError = AuthValidator().confirmPasswordValidator(value, _passwordController.text);
                      return null;
                    },
                  )
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        _submit();
                      },
                      style: const ButtonStyle(
                        textStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(fontSize: 16)),
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.deepPurple),
                        foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                        elevation: MaterialStatePropertyAll<double>(5.0),
                        padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(vertical: 10, horizontal: 0))
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 0
                        ),
                        child: Text('Зарегистрироваться'),
                      )
                    ),
                  ),
                )
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
          ),
          const SizedBox(
            height: 100,
          )
        ]
      ),
      bottomNavigationBar: const AppNavigationBar(
        shape: CircularNotchedRectangle(),
      )
    );
  }

  void _submit() async {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();

    if (_emailError != null || _passwordError != null || _repeatPasswordError != null) {
      String? error = '$_emailError\n\n$_passwordError\n\n$_repeatPasswordError';

      snackBarMessage(error, 5000);
    } else {
      Map<String, dynamic> registerData = await AuthService().signUp(_emailController.text, _passwordController.text);

      snackBarMessage(registerData['message'], 1500);

      if (registerData['isRegister']) {
        pushToLogin();
      }
    }
  }

  pushToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  snackBarMessage(String message, int milliseconds) {
    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(milliseconds: milliseconds),
        )
      );
    }
  }
}