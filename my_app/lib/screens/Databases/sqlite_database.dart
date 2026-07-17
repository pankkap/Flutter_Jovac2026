import 'package:flutter/material.dart';

import './database_helper.dart';
import './model/student.dart';

class SQLiteDatabaseDemo extends StatefulWidget {
  const SQLiteDatabaseDemo({super.key});

  @override
  State<SQLiteDatabaseDemo> createState() => _SQLiteDatabaseDemoState();
}

class _SQLiteDatabaseDemoState extends State<SQLiteDatabaseDemo> {
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    print("initState called");
    insertFiveStudents();
  }

  Future insertFiveStudents() async {
    List<Student> list = [
      Student(name: "Rahul", course: "BCA", age: 20),
      Student(name: "Aman", course: "B.Tech", age: 21),
      Student(name: "Priya", course: "MBA", age: 23),
      Student(name: "Neha", course: "MCA", age: 22),
      Student(name: "Rohit", course: "BBA", age: 19),
    ];

    final oldData = await DatabaseHelper.instance.getStudents();

    if (oldData.isEmpty) {
      for (var student in list) {
        await DatabaseHelper.instance.insertStudent(student);
      }
    }

    loadStudents();
  }

  Future loadStudents() async {
    students = await DatabaseHelper.instance.getStudents();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite Database"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          Student s = students[index];

          return Card(
            child: ListTile(
              title: Text(s.name),
              subtitle: Text(
                  "${s.course} | Age : ${s.age} | ID : ${s.id}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {

                      Student updated = Student(
                        id: s.id,
                        name: "${s.name} Updated",
                        course: s.course,
                        age: s.age + 1,
                      );

                      await DatabaseHelper.instance
                          .updateStudent(updated);

                      loadStudents();
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {

                      await DatabaseHelper.instance
                          .deleteStudent(s.id!);

                      loadStudents();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}