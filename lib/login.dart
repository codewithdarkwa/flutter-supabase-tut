import 'package:flutter/material.dart';
import 'package:flutter_supabase/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Sign In User
  Future<void> signIn() async {
    try {
      await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
    } on AuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 34,
                          width: 264,
                          margin: const EdgeInsets.only(
                            left: 15,
                            right: 16,
                          ),
                          child: const Text("Welcome to Supabase",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26))),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 28,
                          right: 16,
                        ),
                        child: Container(
                          width: 343,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(
                              color: Colors.blue.shade50,
                              width: 1,
                            ),
                          ),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: "Enter your email",
                                hintStyle: TextStyle(fontSize: 12.0, color: Colors.blueGrey.shade300),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(color: Colors.white70),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(color: Colors.white70),
                                ),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(
                                    15,
                                  ),
                                  child: Icon(Icons.email_outlined),
                                ),
                                filled: true,
                                fillColor: Colors.white),
                            style: TextStyle(
                                color: Colors.blueGrey.shade300,
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Container(
                        width: 343,
                        height: 48,
                        margin: const EdgeInsets.only(
                          left: 16,
                          top: 8,
                          right: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.blue.shade50,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Enter Password",
                              hintStyle: TextStyle(fontSize: 12.0, color: Colors.blueGrey.shade300),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.white70),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.white70),
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(
                                  15,
                                ),
                                child: Icon(Icons.lock_outline_rounded),
                              ),
                              filled: true,
                              fillColor: Colors.white),
                          style: TextStyle(
                              color: Colors.blueGrey.shade300,
                              fontSize: 14.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      GestureDetector(
                        onTap: signIn,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 18,
                            right: 16,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            height: 57,
                            width: 343,
                            child: const Text(
                              "Sign In",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                        },
                        child: Container(
                          width: 212,
                          margin: const EdgeInsets.only(
                            left: 81,
                            top: 8,
                            right: 82,
                          ),
                          child: RichText(
                              text: TextSpan(children: <InlineSpan>[
                                TextSpan(
                                  text: "Already have an account?",
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade300,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: ' ',
                                  style: TextStyle(
                                      color: Colors.indigo.shade300,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text: "SignUp",
                                  style: TextStyle(
                                      color: Colors.lightBlue.shade300,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700),
                                )
                              ]),
                              textAlign: TextAlign.center),
                        ),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
