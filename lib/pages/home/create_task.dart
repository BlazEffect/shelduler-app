import 'package:flutter/material.dart';
import 'package:scheduler/models/task.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';

class CreateTaskPage extends StatefulWidget  {
  const CreateTaskPage({super.key});

  @override
  State<StatefulWidget> createState() => CreateTaskPageState();
}

class CreateTaskPageState extends State<CreateTaskPage> {
  @override
  Widget build(BuildContext context) {
    String name = "";
    String description = "";

    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Создание задачи'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Название'),
                  validator: (value) => value!.isEmpty ? 'Название не может быть пустым' : null,
                  onSaved: (value) => name = value!.trim(),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Описание'),
                  onSaved: (value) => description = value!.trim(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      final form = formKey.currentState;
                      final isValid = form!.validate();

                      if (isValid) {
                        form.save();

                        await TaskModel().create(
                          Task(
                            id: '0',
                            name: name,
                            description: description,
                            userId: ''
                          )
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      elevation: 5.0,
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    ),
                    child: const Text('Создать')
                  ),
                ),
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: const AppNavigationBar(
        fabLocation: FloatingActionButtonLocation.centerDocked,
        shape: CircularNotchedRectangle(),
      )
    );
  }
}