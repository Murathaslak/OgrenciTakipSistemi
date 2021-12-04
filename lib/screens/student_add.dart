import 'package:btkakademi/models/student.dart';
import 'package:btkakademi/validation/student_validator.dart';
import 'package:flutter/material.dart';

class StudentAdd extends StatefulWidget {
  late List<Student> students;
  StudentAdd(List<Student> students){
    this.students = students;

  }

  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students);
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  late List<Student> students;
  var student = Student.withoutInfo();
  var formKey = GlobalKey<FormState>();
  _StudentAddState(List<Student> students){
    this.students = students;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Yeni Öğrenci Ekle"),
        ),
        body: Container(
            margin: EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
                child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "Öğrenci Adı:"),
                  onSaved: (value){
                    student.firstName = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Öğrenci Soyadı:"),
                  onSaved: (value){
                    student.lastName = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Öğrenci Notu:"),
                  onSaved: (value){
                    student.grade = int.parse(value!);
                  },
                ),
                buildSutmibButton(),
              ],
            ))));
  }

  buildSutmibButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: (){
        if(formKey.currentState!.validate()){
          formKey.currentState!.save();
          students.add(student);
          saveStudent();
          Navigator.pop(context);
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentAdd(students)));
          };

        }
      },
    );

  }

  void saveStudent() {
    print(student.firstName);
    print(student.lastName);
    print(student.grade);
  }
}

