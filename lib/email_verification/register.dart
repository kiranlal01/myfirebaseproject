import 'package:flutter/material.dart';


import 'firebasefunction.dart';
import 'login.dart';

class MyRegister extends StatelessWidget{
  var email_controller=TextEditingController();
  var pass_controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: email_controller,
              decoration: InputDecoration(
                hintText: 'email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
            ),),
            TextField(
              controller: pass_controller,
              decoration: InputDecoration(
                hintText: 'password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
            ),),
            ElevatedButton(onPressed: () {
              String email=email_controller.text.trim();
              String pass=pass_controller.text.trim();

              FireBaseHelper()
              .registerUser(email: email,pass: pass)
              .then((result) {
                if (result == null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin()));
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                }
              });
            }, child: Text("Register")),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin()));
            }, child: Text("Login"))
          ],
        ),
      ),
    );
  }

}