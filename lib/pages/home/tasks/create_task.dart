import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
//import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scheduler/models/task.dart';

import 'package:scheduler/widgets/app_navigation_bar.dart';

class CreateTaskPage extends StatefulWidget  {
  const CreateTaskPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> with TickerProviderStateMixin {
  //late final TabController _tabController;
  //int _selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  Widget _suffixIconStartFrom = const Icon(Icons.add);
  Widget _suffixIconEndBefore = const Icon(Icons.add);

  bool _addToFavorites = false;

  late String _startFrom;
  late String _endBefore;

  @override
  void initState() {
    super.initState();
    //_tabController = TabController(length: 3, vsync: this);
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    //_tabController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая задача'),
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
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
                  child: Text('Название задачи')
                ),
                Container(
                  color: Colors.grey[300],
                  child: TextFormField(
                    controller: _nameController,
                    maxLength: 250,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      hintText: 'Введите название задачи',
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
                    child: Text('Сроки задачи')
                ),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    contentPadding: const EdgeInsets.only(left: 20),
                    border: InputBorder.none,
                    hintText: 'Начать:',
                    suffixIcon: _suffixIconStartFrom,
                    suffixIconColor: Colors.deepPurple,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime.utc(275760,09,13),
                      onConfirm: (date) {
                        setState(() {
                          String formatDate = DateFormat('dd.MM.yyyy, H:mm').format(date);

                          _suffixIconStartFrom = Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Text(formatDate),
                            ),
                          );

                          _startFrom = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
                        });
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.ru
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    contentPadding: const EdgeInsets.only(left: 20),
                    border: InputBorder.none,
                    hintText: 'Закончить до:',
                    suffixIcon: _suffixIconEndBefore,
                    suffixIconColor: Colors.deepPurple,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime.utc(275760, 09, 13),
                      onConfirm: (date) {
                        setState(() {
                          _suffixIconEndBefore = Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Text(DateFormat('dd.MM.yyyy, H:mm').format(date)),
                            ),
                          );

                          _endBefore = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
                        });
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.ru
                    );
                  },
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
                const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
                    child: Text('Дополнительные параметры')
                ),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    contentPadding: const EdgeInsets.only(left: 20),
                    border: InputBorder.none,
                    hintText: 'Добавить в избранное',
                    suffixIcon: _addToFavorites ? const Icon(Icons.star) : const Icon(Icons.star_outline),
                    suffixIconColor: Colors.orange,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  onTap: () {
                    setState(() {
                      if (_addToFavorites) {
                        _addToFavorites = false;
                      } else {
                        _addToFavorites = true;
                      }
                    });
                  }
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

    Map<String, dynamic> taskMap = {
      'name': _nameController.text.trim(),
      'description': _descriptionController.text.trim(),
      'start_from': _startFrom,
      'finish_before': _endBefore,
      'is_all_day': 0,
      'is_favorite': _addToFavorites ? '1' : '0'
    };

    if (isValid) {
      _formKey.currentState!.save();

      TaskModel().create(Task.fromMap(taskMap));
    }
  }
}