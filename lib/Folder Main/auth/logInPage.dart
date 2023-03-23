// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogIn extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LogIn({
    Key? key,
    required this.showRegisterPage,
  }) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  //controllers
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailC.text,
      password: _passwordC.text,
    );
  }

  @override
  void dispose() {
    // _emailC.dispose();
    // _passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.android, size: 150,),
              Center(
                child: Text(
                  "Hello Again!",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 70,
                  ),
                ),
              ),
              //const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Welcome Back to YourInfo App",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              //const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF001128),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _emailC,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  )
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF001128),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _passwordC,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    )
                ),
              ),



              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: signIn,
                  // onTap: (){
                  //   signIn();
                  //   setState(() {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => const HomeFinal())
                  //     );
                  //   });
                  // },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF001128),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not a Member? ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: const Text(
                      "Register Now",
                      style: TextStyle(
                        color: Color(0xFFFCA311),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      )
    );
  }
}
