import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/login.dart';
import 'package:flutter_application_2/screen/register.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register/Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/sda.png"),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return RegisterScreen();

                    })
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      "สร้างบัญชี",
                      style: TextStyle(fontSize: 20),
)),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return loginscreen();

                    })
                      );
                    },
                    icon: Icon(Icons.login),
                    label: Text(
                      "เข้าสู่ระบบ",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
