// ignore_for_file: avoid_print, file_names, unnecessary_null_comparison
import 'package:firebase_auth/firebase_auth.dart';
import '../models/storageModel.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User? get currentUser => auth.currentUser;
  Stream<User?> get authStateChanges => auth.authStateChanges();

  //signing in with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
  }

  // Future<void> signInWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   await auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //   );
  // }

  //creating User with email and password
  // Future<void> createUserWithEmailAndPassword() async{
  //   try {
  //     await AuthService().createUserWithEmailAndPassword(
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //       // age: int.parse(_controllerAge.text),
  //       // name: _controllerName.text,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       errorMessage = e.message;
  //     });
  //   }
  // }

  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email,
        required String password,
        required String name,
        //required String birthday,
        required String occupation,
        required int age}) async {
    UserCredential userCredential = await auth
        .createUserWithEmailAndPassword(
        email: email,
        password: password
    );

    Map<String,dynamic> userInfoMap = {
      "email": email,
      "name": name,
      "age": age,
      "occupation": occupation,
      //"birthday": birthday,
      //"gender": gender,
    };

    if(userCredential != null){
      Storage().addUserInfoToDB(auth.currentUser!.uid, userInfoMap);
    }

    return userCredential;
  }

  // Future<void> createUserWithEmailAndPassword({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required int age,
  //   required String birthday,
  // }) async {
  //   await AuthService().createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //     name: name,
  //     age: age,
  //     birthday: birthday,
  //
  //   );
  // }

  //signing out
  Future<void> signOut() async {
    await auth.signOut();
  }

  //signing in anonymously
  // Future anonymousSignIn() async {
  //   try {
  //     UserCredential result = await auth.signInAnonymously();
  //     User? user = result.user;
  //     return user;
  //   } catch(e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
}