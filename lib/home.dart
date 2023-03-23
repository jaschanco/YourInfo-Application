// ignore_for_file: avoid_web_libraries_in_flutter, unnecessary_import, prefer_typing_uninitialized_variables, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:information_display/models/userModel.dart';
import 'package:information_display/pages/formPage.dart';
import 'package:information_display/services/authService.dart';
import 'package:information_display/models/storageModel.dart';

import 'auth/sign_in.dart';

class Home extends StatefulWidget {
  bool? isUpdated;
  final int? selectedIndex;
  final dynamic data;
  Home({
    Key? key,
    this.selectedIndex,
    this.data,
    this.isUpdated,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = AuthService().currentUser!;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference profile = FirebaseFirestore.instance.collection('users');
  //late DocumentSnapshot docToEdit;
  DocumentSnapshot? docToEdit;
  late Future dataList;
  List<Profile> datas = [];
  var receiver;
  var isLoading = false;
  final Storage storage = Storage();
  bool? created;

  setDoc(DocumentSnapshot? documentSnapshot){
    docToEdit = documentSnapshot;
  }

  @override
  void initState() {
    //docToEdit ?? '';
    super.initState();
  }

  Widget userId(){
    return Text(user?.email ?? 'User Email');
  }

  Widget signOutButton(){
    return ElevatedButton(
        onPressed: signOut,
        child: const Text('Sign Out')
    );
  }

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
    await AuthService().signOut();
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SignIn()));
    });
  }

  buildUserStreamBuilder() {
    return StreamBuilder(
        stream: profile.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  if (documentSnapshot.id != firebaseAuth.currentUser!.uid) {
                    return Container();
                  }
                  {
                    setDoc(documentSnapshot);
                    return Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.perm_identity),
                          title: Text.rich(TextSpan(
                              text: 'Full Name: ',
                              children: <TextSpan>[
                                TextSpan(
                                  text: documentSnapshot['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF001128)),
                                )
                              ])),
                        ),
                        ListTile(
                          leading: const Icon(Icons.onetwothree_outlined),
                          title: Text.rich(
                              TextSpan(text: 'Age: ', children: <TextSpan>[
                                TextSpan(
                                  text: documentSnapshot['age'].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF001128)),
                                )
                              ])),
                        ),
                        ListTile(
                          leading: const Icon(Icons.onetwothree_outlined),
                          title: Text.rich(
                              TextSpan(text: 'Birthday: ', children: <TextSpan>[
                                TextSpan(
                                  text: documentSnapshot['birthday'].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF001128)),
                                )
                              ])),
                        ),
                        ListTile(
                          leading: const Icon(Icons.people_alt_outlined),
                          title: Text.rich(
                              TextSpan(text: 'Gender: ', children: <TextSpan>[
                                TextSpan(
                                  text: documentSnapshot['gender'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF001128)),
                                )
                              ])),
                        ),
                        ListTile(
                          leading: const Icon(Icons.email_outlined),
                          title: Text.rich(TextSpan(
                              text: 'Email Address: ',
                              children: <TextSpan>[
                                TextSpan(
                                  text: documentSnapshot[
                                    'email'
                                    //userId()
                                  ],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF001128)),
                                )
                              ])),
                        ),
                      ],
                    );
                  }
                });
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Stream<List<Profile>> readProfile() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Profile.fromJson(doc.data())).toList()
  );

  Widget buildProfile (Profile profile) => ListTile(
    leading: const CircleAvatar(child: Icon(Icons.perm_identity, color: Color(0xff3f76bf))),
    title: Text(profile.name.toString()),
    subtitle: Text(profile.age.toString()),

  );

  @override
  Widget build(BuildContext context) {
    if(widget.isUpdated != null){
      isLoading = widget.isUpdated!;
    } else {
      isLoading = created ?? true;
    }
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.account_circle),
        title: const Text("Dashboard"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            height: 500,
            child: ListView(
              padding: const EdgeInsets.all(15.0),
              children: [
                const SizedBox(height: 10.0),
                StreamBuilder(
                    stream: storage.getPicStream('pfp'),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                height: 120,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                      snapshot.data ??
                                          "https://i0.wp.com/collegecore.com/wp-content/uploads/2018/05/facebook-no-profile-picture-icon-620x389.jpg?ssl=1"
                                  ),
                                )
                            ),
                          ],
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Container(
                          alignment: Alignment.center,
                          height: 120,
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage("https://i0.wp.com/collegecore.com/wp-content/uploads/2018/05/facebook-no-profile-picture-icon-620x389.jpg?ssl=1"),
                          )
                      );
                    }
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF001128),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              receiver = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FormPage(
                                        docU: docToEdit!,
                                      )));
                              if (receiver != null) {
                                setState(() {
                                  datas.add(receiver);
                                });
                              } else {
                                return;
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                            child: const Text("Edit Profile",
                                style: TextStyle(color: Color(0xFF001128)))),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                            onPressed: () {
                              signOut();
                            },
                            child: const Text("Sign out", style: TextStyle(color: Color(0xFF001128)))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.topLeft,
                      height: 370,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : buildUserStreamBuilder()
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(height: 10),

          Container(
            alignment: Alignment.center,
            color: const Color(0xFF001128),
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              "List of Data's Saved" ,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),

          const SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow:[
                  BoxShadow(
                    color: const Color(0xFF001128).withOpacity(0.5), //color of shadow
                    spreadRadius: 5, //spread radius
                    blurRadius: 7, // blur radius
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
                color: const Color(0xFF001128),
              ),
              child: StreamBuilder<List<Profile>>(
                stream: readProfile(),
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Text("Something went wrong! ${snapshot.error}");
                  } else if(snapshot.hasData){
                    final profiles = snapshot.data!;

                    return ListView(
                      children: profiles.map(buildProfile).toList(),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),

        ],
      ),



      // body: Container(
      //   height: double.infinity,
      //   width: double.infinity,
      //   padding: const EdgeInsets.all(25.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Container(
      //         alignment: Alignment.center,
      //         padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      //         color: const Color(0xFF001128),
      //         child: const Text(
      //           'Welcome to YourInfo App',
      //           style: TextStyle(
      //             fontSize: 24.8,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ),
      //       Container(
      //         alignment: Alignment.center,
      //         padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      //         color: Colors.white,
      //         child: const Text(
      //           'Input your details',
      //           style: TextStyle(
      //             fontSize: 12,
      //             fontWeight: FontWeight.bold,
      //             color: Color(0xFF001128),
      //           ),
      //         ),
      //       ),
      //
      //       userId(),
      //       signOutButton(),
      //     ],
      //   ),
      // ),

    );
  }
}