import 'package:flutter/material.dart';
//import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scheduler/models/task.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';

class CreateTaskPage extends StatefulWidget  {
  const CreateTaskPage({super.key});

  @override
  State<StatefulWidget> createState() => CreateTaskPageState();
}

class CreateTaskPageState extends State<CreateTaskPage> with TickerProviderStateMixin {
  //late final TabController _tabController;

  //int _selectedIndex = 0;

  /*@override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    String name = "";
    String description = "";

    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая задача'),
        // Customize the TabBar class and get rid of using the library
        /*bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              gap: 8,
              activeColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabs: const [
                GButton(
                  icon: Icon(
                    Icons.flag,
                    color: Colors.deepPurple
                  ),
                  text: 'Главное'
                ),
                GButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.deepPurple,
                  ),
                  text: 'Дополнительное'
                ),
                GButton(
                  icon: Icon(
                    Icons.alarm_rounded,
                    color: Colors.deepPurple
                  ),
                  text: 'Напоминания'
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              }
            )
          )
        )*/
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
        shape: CircularNotchedRectangle(),
      )
    );
  }
}