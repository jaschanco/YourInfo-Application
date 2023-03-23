// ignore_for_file: file_names
import 'package:information_display/auth/sign_in.dart';
import 'package:information_display/services/authService.dart';
//import 'Folder Main/auth/logInPage.dart';
import 'Folder Main/auth/logInPage.dart';
import 'home.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return Home(isUpdated: true);
        } else {
          //return Home();
          return const SignIn();
        }
      },
    );
  }
}
