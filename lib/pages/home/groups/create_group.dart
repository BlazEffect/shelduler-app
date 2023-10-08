import 'package:flutter/material.dart';
import 'package:scheduler/models/group.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';

class CreateGroupPage extends StatefulWidget  {
  const CreateGroupPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая группа'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(Icons.done),
              onPressed: () {
                _submitForm();
              },
            )
          )
        ],
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
                  child: Text('Название группы')
                ),
                Container(
                  color: Colors.grey[300],
                  child: TextFormField(
                    controller: _nameController,
                    maxLength: 250,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      hintText: 'Введите название группы',
                      contentPadding: const EdgeInsets.only(left: 20),
                      border: InputBorder.none,
                    ),
                    buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text("$currentLength/$maxLength"),
                      );
                    },
                    validator: (value) => value!.isEmpty ? 'Название не может быть пустым' : null,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
                  child: Text('Примечание')
                ),
                Container(
                  color: Colors.grey[300],
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLength: 1024,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      hintText: 'Введите описание',
                      contentPadding: const EdgeInsets.only(left: 20),
                      border: InputBorder.none,
                    ),
                    buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text("$currentLength/$maxLength"),
                      );
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        _submitForm();
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
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const AppNavigationBar(
        shape: CircularNotchedRectangle(),
      )
    );
  }

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();

    Map<String, dynamic> groupMap = {
      'name': _nameController.text.trim(),
      'description': _descriptionController.text.trim(),
    };

    if (isValid) {
      _formKey.currentState!.save();

      GroupModel().create(Group.fromMap(groupMap));
    }
  }
}