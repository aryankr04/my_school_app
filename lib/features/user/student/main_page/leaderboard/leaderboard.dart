import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';

class Student {
  final String name;
  final int points;

  Student({required this.name, required this.points});
}

class Leaderboard extends StatelessWidget {
  final List<Student> students = [
    Student(name: 'Alice', points: 95),
    Student(name: 'Bob', points: 89),
    Student(name: 'Charlie', points: 78),
    Student(name: 'David', points: 92),
    Student(name: 'Eva', points: 84),
    // Add more students as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        elevation: 0,

      ),
      body: Container(
        // padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Students',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 16.0),

            Container(
              height: 200,
              color: SchoolDynamicColors.activeBlue,
            )
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: students.length,
            //     itemBuilder: (context, index) {
            //       final student = students[index];
            //       return Card(
            //         elevation: 2.0,
            //         child: ListTile(
            //           title: Text(
            //             student.name,
            //             style: const TextStyle(fontWeight: FontWeight.bold),
            //           ),
            //           subtitle: Text('Points: ${student.points}'),
            //           leading: CircleAvatar(
            //             child: Text((index + 1).toString()),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}