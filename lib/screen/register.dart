import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/profile.dart';
import 'package:flutter_application_2/screen/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            //เช็คข้อผิดพลาด ไฟเยอร์เบด
            return Scaffold(
              appBar: AppBar(
                title: Text("สร้างบัญชี"),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("อีเมล", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
                              EmailValidator(errorText: "อีเมลไม่ถูกต้อง")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (email) {
                              profile.email = email!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("รหัสผ่าน", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนรหัสผ่าน"),
                            obscureText: true,
                            onSaved: (password) {
                              profile.password = password!;
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                "ลงทะเบียน",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                //สร้างแอคเค้าก่อนค่อยเคลียแบบฟอรม
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState?.save();
                                  //กดลงทะเบียนข้อมูลก็ไปทำงานที่ ไฟเยอร์เบรด ให้าร้างบัญชีผู้ใช้

                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: profile.email,
                                            password: profile.password)
                                        .then((value) {
                                      formKey.currentState?.reset();
                                      Fluttertoast.showToast(
                                          msg: "สร้างบัญชีสำเร็จ",
                                          gravity: ToastGravity.CENTER);
                                      Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Homescreen();
                                      }));
                                    });
                                    // formKey.currentState?.reset();
                                    // Fluttertoast.showToast(
                                    //     msg: "สร้างบัญชีสำเร็จ",
                                    //     gravity: ToastGravity.CENTER);
                                    // Navigator.pushReplacement(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //   return Homescreen();
                                    // }));
                                  } on FirebaseAuthException catch (e) {
                                    //catch  ถ้ามีข้อผิดพลาด ให้ print
                                    // print(e.message);
                                    print(e.code);
                                    String message = '';

                                    if (e.code == 'email-already-in-use') {
                                      message =
                                          "มีเมลนี้ในระบบแล้วโปรดใช้อีเมลอื่น";
                                    } else if (e.code == 'weak-password') {
                                      message = "รหัสผ่านต้องมี6ตัวอักษรขึ้นไป";
                                    } else {
                                      message = message;
                                    }
                                    Fluttertoast.showToast(
                                        msg: message,
                                        gravity: ToastGravity.CENTER);
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  String newMethod(String message) => message;
}
