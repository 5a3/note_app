import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/Auth/signup.dart';
import 'package:flutter_app/componets/custombutton.dart';
import 'package:flutter_app/componets/customtextformfiled.dart';
import 'package:flutter_app/home/homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static String id = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green, content: Text("تم تسجيل الدخول بنجاح")));
    setState(() {});
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => HomePage(),
    ));
  }

  bool IsLoding = false;
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future login() async {
    try {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "${email.text.trim()}",
              password: "${password.text.trim()}");
      if (userCredential.user!.emailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("تم تسجيل الدخول بنجاح")));
        setState(() {});
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      } else {
        Navigator.of(context).pop();
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
                "يرجئ التحقق من الايميل والضغط علئ رابط التحقق المرسل الئ ايميلك الشخصي للتاكيد")));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
                "لا يوجد مستخدم بهذا الايميل الرجاء عمل تسجيل الدخول بالبداية")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("كلمة المرور غير صحيحة")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("حدث خطأ ما الرجاء المحاولة مرة أخرى")));
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
                              "Login",
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
                                title: 'ادخل كلمه المرور',
                                contrillername: password,
                                type: TextInputType.text,
                              ),
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                if (email.text == '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              "الرجاء كتابه البريد الالكتروني لارسال رلابط اعادة التعيين لكلمة المرور")));
                                  return;
                                }
                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: email.text);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.orange,
                                          content: Text(
                                              "تم ارسال رساله اعادة التعيين لكلمة المرور الئ ${email.text}")));
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              "تاكد من البريد الالكتروني المدخل وحاول مرة اخرئ")));
                                }
                              },
                              child: Text(
                                'هل نسيت كمة السر؟',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: MaterialButton(
                            minWidth: 200,
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 23),
                            ),
                            color: Colors.blueAccent,
                            onPressed: () {
                              if (form_key.currentState!.validate()) {
                                login();
                              }
                            }),
                      ),
                      SizedBox(
                        height: 14,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => signInWithGoogle(),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage('assets/images/google.png'),
                            ),
                          )
                        ],
                      ),
                      // Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Do not have an account?",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, SignUp.id);

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Sginup()));
                                },
                                child: Text(
                                  " Register",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
