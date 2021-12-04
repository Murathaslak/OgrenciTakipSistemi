import 'package:btkakademi/models/student.dart';
import 'package:btkakademi/screens/student_add.dart';
import 'package:btkakademi/validation/student_validator.dart';
import 'package:flutter/material.dart';

class StudentEdit extends StatefulWidget {
  late Student selectedstudent;
  StudentEdit(List<Student> students){
    this.selectedstudent = selectedstudent;

  }

  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(selectedstudent);
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  late Student selectedStudent;

  var formKey = GlobalKey<FormState>();
  _StudentAddState(Student selectedStudent){
    this.selectedStudent = selectedStudent;

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
                      initialValue: selectedStudent.firstName,
                      decoration: InputDecoration(labelText: "Öğrenci Adı:"),
                      onSaved: (value){
                        selectedStudent.firstName = value;
                      },
                    ),
                    TextFormField(
                      initialValue: selectedStudent.lastName,
                      decoration: InputDecoration(labelText: "Öğrenci Soyadı:"),
                      onSaved: (value){
                        selectedStudent.lastName = value;
                      },
                    ),
                    TextFormField(
                      initialValue: selectedStudent.grade.toString(),
                      decoration: InputDecoration(labelText: "Öğrenci Notu:"),
                      onSaved: (value){
                        selectedStudent.grade = int.parse(value!);
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
          saveStudent();
          Navigator.pop(context);
        }
      },
    );

  }

  void saveStudent() {
    print(selectedStudent.firstName);
    print(selectedStudent.lastName);
    print(selectedStudent.grade);
  }
}

