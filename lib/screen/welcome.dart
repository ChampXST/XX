import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/home.dart';

class welcomescreen extends StatelessWidget {
  
   final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ยินดีต้อนรับ"),),
      body: Column(
        children: [
          Text(auth.currentUser?.email as String),
          ElevatedButton(
            child: Text("ออกจากระบบ"),
            onPressed: (){
              auth.signOut().then((value){
                Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Homescreen();
                                      }));
              });
            },
             )
          
      ],),
    );
  }
}