import 'package:flutter/material.dart';
import 'package:iotapps/screens/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //Explcit
  double amount = 150.0;
  double size = 250.0;

  Widget emailTextFormFeild() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: size,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Email:',
            hintText: 'you@abcd.com',
            labelStyle: TextStyle(color: Colors.orange[500]),
          ),
        ),
      ),
    );
  }

  Widget passwordTextFormFeild() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: size,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password:',
            hintText: 'More than 7 charactor',
            labelStyle: TextStyle(color: Colors.orange[500]),
          ),
        ),
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    return Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.orange[500],
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget signUpButton(BuildContext context) {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.orange[500]),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.orange[500]),
        ),
        onPressed: () {
          print("Click to link");
          var registerRoute = MaterialPageRoute(
              builder: (BuildContext context) => (Register()));
              Navigator.of(context).push(registerRoute);
        },
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: amount,
      height: amount,
      child: Image.asset(
        'images/logo2.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget showName() {
    return Container(
      child: Text(
        'IoT Fish Tank',
        style: TextStyle(
            fontSize: 30.0,
            color: Colors.orange[500],
            fontWeight: FontWeight.bold,
            fontFamily: 'GloriaHallelujah'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        alignment: Alignment(0, -1),
        padding: EdgeInsets.only(top: 70.0),
        child: Column(
          children: <Widget>[
            showLogo(),
            showName(),
            emailTextFormFeild(),
            passwordTextFormFeild(),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              alignment: Alignment.center,
              width: size,
              child: Row(
                children: <Widget>[
                  signInButton(context),
                  signUpButton(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
