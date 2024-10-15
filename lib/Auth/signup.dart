import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/Auth/login.dart';
import 'package:flutter_app/componets/custombutton.dart';
import 'package:flutter_app/componets/customtextformfiled.dart';
import 'package:flutter_app/home/homepage.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});
  static String id = 'SignUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Future SignUp() async {
    if (pass.text != confirmpass.text) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
            content: Text('كلمة المرور ليست متطابقة'),
            title: Text('خطأ'),
          );
        },
      );
      return;
    } else {
      try {
        showDialog(
          context: context,
          builder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: "${email.text}", password: "${pass.text}");
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 118, 207, 55),
            content: Text(
                "تم ارسال رابط التحقق الئ ايميلك الشخصي الرجاء مراجهته للتحقق")));
        Navigator.of(context).pushReplacementNamed(Login.id);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text("كلمه السر ضعيفة")));
          Navigator.of(context).pop();
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color.fromARGB(255, 251, 188, 0),
              content: Text("الحساب موجود بالفعل")));
          Navigator.of(context).pop();
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  // confirmpassword() {
  //   if () {
  //     return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           content: Text('password not much'),
  //           title: Text('error much pass'),
  //         );

  //       },
  //     );
  //     // return true;
  //   } else {
  //     return true;
  //   }
  // }

  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: 200,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  blurRadius: 80,
                                  offset: Offset(1, 2))
                            ],
                          ),
                          child: Image.asset(
                            "assets/images/login.png",
                            fit: BoxFit.cover,
                          )),
                      Container(
                        // margin: EdgeInsets.only(top: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "SignUp",
                              style: TextStyle(
                                  fontSize: 37, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              " Now",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 37,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 7),
                        // margin: EdgeInsets.only(top: 1),
                        child: const Text(
                          "Please Enter Your Detiles below to continue",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Form(
                          key: form_key,
                          child: Column(
                            children: [
                              customtextfiled(
                                title: 'ادخل الايميل',
                                contrillername: email,
                                type: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              customtextfiled(
                                title: 'أدخل كلمه المرور',
                                contrillername: pass,
                                type: TextInputType.visiblePassword,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              customtextfiled(
                                title: 'تأكيد كلمه المرور',
                                contrillername: confirmpass,
                                type: TextInputType.visiblePassword,
                              ),
                            ],
                          )),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: MaterialButton(
                            minWidth: 200,
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 23),
                            ),
                            color: Colors.blueAccent,
                            onPressed: () {
                              if (form_key.currentState!.validate()) {
                                if (pass.text != confirmpass) {}
                                SignUp();
                              }
                            }),
                      ),
                      // Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Do you have account?",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, Login.id);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Sginup()));
                                },
                                child: Text(
                                  " login",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
