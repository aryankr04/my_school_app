
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

Future<T?> showTextDialog<T>(
    BuildContext context, {
      required String title,
      required String value,
    }) =>
    showDialog<T>(
      context: context,
      builder: (context) => TextDialogWidget(
        title: title,
        value: value,
      ),
    );

class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;

  const TextDialogWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  _TextDialogWidgetState createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    ),
    actions: [
      ElevatedButton(
        child: Text('Done'),
        onPressed: () => Navigator.of(context).pop(controller.text),
      )
    ],
  );
}
class Utils {
  static List<T> modelBuilder<M, T>(
      List<M> models, T Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}
class ScrollableWidget extends StatelessWidget {
  final Widget child;

  const ScrollableWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: child,
    ),
  );
}
class User {
  final String firstName;
  final String lastName;
  final int age;

  const User({
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  User copy({
    String? firstName,
    String? lastName,
    int? age,
  }) =>
      User(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        age: age ?? this.age,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User &&
              runtimeType == other.runtimeType &&
              firstName == other.firstName &&
              lastName == other.lastName &&
              age == other.age;

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode ^ age.hashCode;
}
class EditablePage extends StatefulWidget {
  @override
  _EditablePageState createState() => _EditablePageState();
}

class _EditablePageState extends State<EditablePage> {
  late List<User> users;

  final allUsers = <User>[
    User(firstName: 'Emma', lastName: 'Field', age: 37),
    User(firstName: 'Max', lastName: 'Stone', age: 27),
    User(firstName: 'Sarah', lastName: 'Winter', age: 20),
    User(firstName: 'James', lastName: 'Summer', age: 21),
    User(firstName: 'Lorita', lastName: 'Wilcher', age: 18),
    User(firstName: 'Anton', lastName: 'Wilbur', age: 32),
    User(firstName: 'Salina', lastName: 'Monsour', age: 24),
    User(firstName: 'Sunday', lastName: 'Salem', age: 42),
    User(firstName: 'Alva', lastName: 'Cowen', age: 47),
    User(firstName: 'Jonah', lastName: 'Lintz', age: 18),
    User(firstName: 'Kimberley', lastName: 'Kelson', age: 33),
    User(firstName: 'Waldo', lastName: 'Cybart', age: 19),
    User(firstName: 'Garret', lastName: 'Hoffmann', age: 27),
    User(firstName: 'Margaret', lastName: 'Yarger', age: 25),
    User(firstName: 'Foster', lastName: 'Lamp', age: 53),
    User(firstName: 'Samuel', lastName: 'Testa', age: 58),
    User(firstName: 'Sam', lastName: 'Schug', age: 44),
    User(firstName: 'Alise', lastName: 'Bryden', age: 41),
  ];

  @override
  void initState() {
    super.initState();

    this.users = List.of(allUsers);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ScrollableWidget(child: buildDataTable()),
  );

  Widget buildDataTable() {
    final columns = ['First Name', 'Last Name', 'Age'];

    return DataTable(
      columns: getColumns(columns),
      rows: getRows(users),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      final isAge = column == columns[2];

      return DataColumn(
        label: Text(column),
        numeric: isAge,
      );
    }).toList();
  }

  List<DataRow> getRows(List<User> users) => users.map((User user) {
    final cells = [user.firstName, user.lastName, user.age];

    return DataRow(
      cells: Utils.modelBuilder(cells, (index, cell) {
        final showEditIcon = index == 0 || index == 1;

        return DataCell(
          Text('$cell'),
          showEditIcon: showEditIcon,
          onTap: () {
            switch (index) {
              case 0:
                editFirstName(user);
                break;
              case 1:
                editLastName(user);
                break;
            }
          },
        );
      }),
    );
  }).toList();

  Future editFirstName(User editUser) async {
    final firstName = await showTextDialog(
      context,
      title: 'Change First Name',
      value: editUser.firstName,
    );

    setState(() => users = users.map((user) {
      final isEditedUser = user == editUser;

      return isEditedUser ? user.copy(firstName: firstName) : user;
    }).toList());
  }

  Future editLastName(User editUser) async {
    final lastName = await showTextDialog(
      context,
      title: 'Change Last Name',
      value: editUser.lastName,
    );

    setState(() => users = users.map((user) {
      final isEditedUser = user == editUser;

      return isEditedUser ? user.copy(lastName: lastName) : user;
    }).toList());
  }
}