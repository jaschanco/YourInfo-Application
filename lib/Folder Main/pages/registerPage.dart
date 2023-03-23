// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'finalHome.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //controllers
  //final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _occupation = TextEditingController();


  @override
  void dispose() {
    // _emailC.dispose();
    // _passwordC.dispose();
    // _name.dispose();
    // _age.dispose();
    // _occupation.dispose();
    super.dispose();
  }

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailC.text,
      password: _passwordC.text,
    );

    addUserDetails(
        _name.text,
        int.parse(_age.text),
        _occupation.text,
        _emailC.text,
    );

  }

  Future addUserDetails (String name, int age, String occupation, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name' : name,
      'age' : age,
      'occupation' : occupation,
      'email' : email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: ListView(
              children: [
                //const SizedBox(height: 40),
                //const Icon(Icons.android, size: 150,),
                Center(
                  child: Text(
                    "Hello There!",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 70,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Register Below",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),

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
                          controller: _name,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Full Name: ',
                          ),
                        ),
                      )
                  ),
                ),

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
                          controller: _age,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Age: ',
                          ),
                        ),
                      )
                  ),
                ),

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
                          controller: _occupation,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Occupation: ',
                          ),
                        ),
                      )
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
                    onTap: signUp,
                    // onTap: (){
                    //   signUp();
                    //   setState(() {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(builder: (context) => const HomeFinal())
                    //     );
                    //   });
                    //},
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF001128),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ElevatedButton(
                  //   onPressed: (){
                  //     if (_formKey.currentState!.validate()) {
                  //       signInWithEmailAndPassword();
                  //     }
                  //   },
                  //   child: const Text("Sign Up"),
                  // ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "I am a Member! ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        "LogIn",
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
