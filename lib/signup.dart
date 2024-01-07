import 'package:flutter/material.dart';
import 'package:flutter_supabase/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  //Sign Up User
  Future<void> signUp() async {
    try {
      await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
        data: {'username': usernameController.text},
      );
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
    } on AuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome to Supabase",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required field missing';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: const Icon(Icons.email, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required field missing';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required field missing';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Enter your username',
                        prefixIcon: const Icon(Icons.email, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: 360,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          "Sign Up",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                    child: Container(
                      width: 212,
                      margin: const EdgeInsets.only(left: 81, top: 8, right: 82),
                      child: RichText(
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: "Already have an account?",
                              style: TextStyle(
                                color: Colors.blueGrey.shade300,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
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
                              text: "SignIn",
                              style: TextStyle(
                                  color: Colors.lightBlue.shade300,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
