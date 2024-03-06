import 'package:flutter/material.dart';


import 'firebasefunction.dart';
import 'login.dart';

class MyHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Center(child: Text("Hello Welcome"),),
            ElevatedButton(onPressed: () {
              FireBaseHelper()
                  .logout()
                  .then((result) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin()));
              });
            }, child: Text("LogOut"))
          ],
        ),
      ),
    );
  }

}