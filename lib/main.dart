// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
//import 'package:information_display/Wrapper/wrapper.dart';
//import 'package:information_display/homePage.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:information_display/Folder%20Main/pages/mainHomePage.dart';
import 'package:information_display/widgetTree.dart';
// import 'package:information_display/homePage.dart';
// import 'package:information_display/widgetTree.dart';
//import 'widgetTree.dart';

final FlexSchemeColor schemeLight = FlexSchemeColor.from(
  primary: const Color(0xFF14213D),
  secondary: const Color(0xFFFCA311),
  tertiary: const Color(0xFFE5E5E5),
  brightness: Brightness.light,
);

final FlexSchemeColor schemeDark = FlexSchemeColor.from(
  primary: const Color(0xFF222B5F),
  secondary: const Color(0xffa6aaee),
  tertiary: const Color(0xffe20a4a),
  brightness: Brightness.dark,
);

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF14213D),
          appBarTheme: const AppBarTheme(color: Color(0xFF001128)),
          scaffoldBackgroundColor: const Color(0xff3f76bf),
          brightness: Brightness.dark,
          useMaterial3: true,
        ),

        //home: const WidgetTree(),
        home: const MainHomePage(),
        //home: const HomePage(),
      )
  );
}