import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';

import 'package:scheduler/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Box user;

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    user = Hive.box('user');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Войти в аккаунт'),
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
                        child: Text('Войти в аккаунт'),
                      )
                    ),
                  ),
                )
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                elevation: 5.0,
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              ),
              child: const Text('Забыли пароль?')
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: TextButton(
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
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
      bottomNavigationBar: const AppNavigationBar(
        shape: CircularNotchedRectangle(),
      )
    );
  }

  void _submit() async {
    final user = Hive.box('user');
    _formKey.currentState!.save();

    Map<String, dynamic> authData = await AuthService().signIn(_emailController.text, _passwordController.text);

    snackBarMessage(authData['message']);

    if (authData['isAuth']) {
      await user.add(authData['user'].toMap());

      pushToMain();
    }
  }

  pushToMain() {
    Navigator.pushNamed(context, '/');
  }

  snackBarMessage(String message) {
    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(milliseconds: 1500),
        )
      );
    }
  }
}