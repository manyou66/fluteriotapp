import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iotapps/screens/my_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString, phoneString;

  // Method
  Widget uploadButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      iconSize: 35.0,
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
        }
      },
    );
  }

  void uploadToFirebase(BuildContext context) async {
    print(
        'Name=$nameString, Email=$emailString, Password=$passwordString, Phone=$phoneString');
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((objValue) {
      String uidString = objValue.uid.toString();
      print('uid=$uidString');
      uploadValueToDatabase(uidString, context);
    }).catchError((objValue) {
      String error = objValue.message;
      print('error=$error');
    });
  }

  void uploadValueToDatabase(String uid, BuildContext context) async {
    Map<String, String> map = Map();
    map['Name'] = nameString;
    map['Phone'] = phoneString;
    map['Uid'] = uid;
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    await firebaseDatabase
        .reference()
        .child('User')
        .child(uid)
        .set(map)
        .then((objValue) {
      print('Update Database Success');
      //Create Route to MyService
      var myServiceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          myServiceRoute,
          ((Route<dynamic> route) =>
              false)); //Route to MyService don't have back button
    }).catchError((objValue) {
      String error = objValue.message;
      print('error = $error');
    });
  }

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.face,
          color: Colors.blue[500],
          size: 35.0,
        ),
        labelText: 'Name',
        labelStyle: TextStyle(color: Colors.orange[500]),
        helperText: 'First Name and Last Name',
        helperStyle:
            TextStyle(color: Colors.orange[300], fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (value.length == 0) {
          return 'Please Fill Name in Blank';
        }
      },
      onSaved: (String value) {
        nameString = value.trim();
      },
    );
  }

  Widget nameEmail() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: Colors.blue[500],
          size: 36.0,
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(color: Colors.orange[500]),
        helperText: 'abce@gmail.com',
        helperStyle:
            TextStyle(color: Colors.orange[300], fontStyle: FontStyle.italic),
      ),
      validator: (String emailValue) {
        if (!(emailValue.contains('@')) && (emailValue.contains('.'))) {
          return 'Wrong Email Format you@abcd.com';
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget namePassword() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          color: Colors.blue[500],
          size: 35.0,
        ),
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.orange[500]),
        helperText: 'More than 7 charactor',
        helperStyle:
            TextStyle(color: Colors.orange[300], fontStyle: FontStyle.italic),
      ),
      validator: (String passwordValue) {
        if (passwordValue.length <= 7) {
          return 'More than 7 ';
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
    );
  }

  Widget namePhone() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.phone,
          color: Colors.blue[500],
          size: 35.0,
        ),
        labelText: 'Phone',
        labelStyle: TextStyle(color: Colors.orange[500]),
        helperText: '0891234567',
        helperStyle:
            TextStyle(color: Colors.orange[300], fontStyle: FontStyle.italic),
      ),
      validator: (String phoneValue) {
        if (phoneValue.length == 0) {
          return 'Empty Password';
        }
      },
      onSaved: (String value) {
        phoneString = value.trim();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: Text('Register'),
        actions: <Widget>[uploadButton(context)],
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(top: 80.0, left: 50.0, right: 50.0),
          child: ListView(
            children: <Widget>[
              nameText(),
              nameEmail(),
              namePassword(),
              namePhone()
            ],
          ),
        ),
      ),
    );
  }
}
