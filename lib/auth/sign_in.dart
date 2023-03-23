// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
//import 'package:information_display/pages/formPage.dart';
import 'package:information_display/home.dart';
//import 'package:information_display/models/userModel.dart';
import 'package:information_display/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService auth = AuthService();
  String? errorMessage = '';
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  //var _gender;


  Future<void> signInWithEmailAndPassword() async {
    try {
      await AuthService().signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch(e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await AuthService().createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        age: int.parse(ageController.text),
        occupation: occupationController.text,
        //birthday: birthdayController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget title(){
    return Text(isLogin ? 'Login Page' : 'Register Page');
  }

  Widget entryField(String title, TextEditingController controller){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage(){
    return Text(errorMessage == '' ? '' : 'Sorry, there is an error. $errorMessage');
  }

  Widget submitButton(){
    return ElevatedButton(
      onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Register')
    );
  }

  Widget loginOrRegisterButton(){
    return TextButton(
      onPressed: (){
        if(_formKey.currentState != null && _formKey.currentState!.validate() ){
          createUserWithEmailAndPassword();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Home(isUpdated: false) //Home(isUpdated: false)
            ),
              (Route<dynamic> route) => false
          );
        }
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register Instead' : 'Login Instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.login),
        title: title(),
      ),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              entryField('Email', emailController),
              entryField('Password', passwordController),
              if (!isLogin) ...[
                entryField('Name', nameController),
                entryField('Age', ageController),
                entryField('Occupation', occupationController),
              ],
              _errorMessage(),
              submitButton(),
              loginOrRegisterButton(),
            ],
          ),
        ),
      ),

    );
  }
}
