import 'package:btkakademi/screens/student_add.dart';
import 'package:btkakademi/screens/student_edit.dart';
import 'package:flutter/material.dart';
import 'models/student.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mesaj = "Öğrenci Takip Sistemi!";

  Student selectedStudent = Student.withId(0, "", "", 0);

  List<Student> students = [
    Student.withId(1, "Osman Murat", " Haşlak", 25),
    Student.withId(2, "Engin", " Haşlak", 45),
    Student.withId(3, "Ali", " Haşlak", 65),
    Student.withId(4, "Onur", " Haşlak", 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(mesaj),
        ),
        body: buildBody(context));
  }

  void mesajGoster(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      title: Text("İşlem Sonucu!"),
      content: Text(mesaj),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 27,
                      backgroundImage: AssetImage("assets/images/eevee.png"),
                    ),
                    title: Text(students[index].firstName! +
                        " " +
                        students[index].lastName!),
                    subtitle: Text("Sınavdan aldığı not: " +
                        students[index].grade.toString() +
                        " [" +
                        students[index].getStatus +
                        "]"),
                    trailing: buildStatusIcon(students[index].grade!),
                    onTap: () {
                      setState(() {
                        selectedStudent = students[index];
                      });

                      print(selectedStudent.firstName);
                    },
                  );
                })),
        Text("Seçili öğrenci: " + selectedStudent.firstName!),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                  color: Colors.black45,
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text("Yeni öğrenci"),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentAdd(students)));
                  }),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                  color: Colors.greenAccent,
                  child: Row(
                    children: [
                      Icon(Icons.update),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text("Güncelle"),
                    ],
                  ),
                  onPressed: () {
                    var mesaj = "Güncellendi";
                    mesajGoster(context, mesaj);
                  }),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                  color: Colors.amberAccent,
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text("Sil"),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      students.remove(selectedStudent);
                    });

                    var mesaj = "Silindi: " + selectedStudent.firstName!;
                    mesajGoster(context, mesaj);
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade >= 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }
}
