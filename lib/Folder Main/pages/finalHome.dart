// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:information_display/Folder%20Main/readData/getUserName.dart';
import 'package:information_display/models/storageModel.dart';
import 'package:information_display/pages/formPage.dart';
//import 'package:intl/intl.dart';


class HomeFinal extends StatefulWidget {
  const HomeFinal({Key? key}) : super(key: key);

  @override
  State<HomeFinal> createState() => _HomeFinalState();
}

class _HomeFinalState extends State<HomeFinal> {
  final user = FirebaseAuth.instance.currentUser!;

  Storage storage = Storage();
  final CollectionReference profile = FirebaseFirestore.instance.collection('users'); //or user?
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //document IDs
  List<String> docIDs = [];

  //get document IDs
  Future getDocId () async {
    await FirebaseFirestore.instance.collection('users').get().then(
        (snapshot) => snapshot.docs.forEach((document) {
          print(document.reference);
          docIDs.add(document.reference.id);
        })
    );
  }

  @override
  void initState() {
    getDocId();
    super.initState();
  }

  Widget personalInformationContent(DocumentSnapshot documentSnapshot){
    // Timestamp t = documentSnapshot['birthday'];
    // DateTime date = t.toDate();
    // String formattedDate = DateFormat.yMMMEd().format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
              "PERSONAL INFORMATION:",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Name: ${documentSnapshot['name']}",
            style: const TextStyle(
                fontSize: 16,
                //color: Colors.black45
            ),
          ),
          Text("Age: ${documentSnapshot['age']}",
            style: const TextStyle(
                fontSize: 16,
                //color: Colors.black45
            ),
          ),
          Text("Occupation: ${documentSnapshot['occupation']}",
            style: const TextStyle(
              fontSize: 16,
              //color: Colors.black45
            ),
          ),
          // Text("Birthday: $formattedDate",
          //   style: const TextStyle(
          //       fontSize: 16,
          //       //color: Colors.black45
          //   ),
          // ),
          Text("Email: ${documentSnapshot['email']}",
            style: const TextStyle(
                fontSize: 16,
                //color: Colors.black45
            ),
          ),
        ],
      ),
    );
  }

  buildHomeContent(){
    return StreamBuilder(
      stream: profile.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            for (var i = 0; i < streamSnapshot.data!.docs.length; i++) {
              DocumentSnapshot documentSnapshot =
              streamSnapshot.data!.docs[i];
              if (documentSnapshot.id != _firebaseAuth.currentUser!.uid) {
                continue;
              }else{
                return Column(
                  children: [
                    const SizedBox(height: 8),
                    Text(documentSnapshot['name'],
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    const SizedBox(height: 8),
                    Text(documentSnapshot['occupation'],
                      style: const TextStyle(
                          fontSize: 20,
                          //color: Colors.black45
                      ),
                    ),
                    //const SizedBox(height: 10),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     buildSocialIcon(FontAwesomeIcons.facebook, documentSnapshot['fb']),
                    //     const SizedBox(height: 16, width: 10),
                    //     buildSocialIcon(
                    //         FontAwesomeIcons.github, documentSnapshot['git']),
                    //     const SizedBox(height: 16, width: 10),
                    //     buildSocialIcon(
                    //         FontAwesomeIcons.twitter, documentSnapshot['twtr']),
                    //     const SizedBox(height: 16, width: 10),
                    //     buildSocialIcon(FontAwesomeIcons.instagram,
                    //         documentSnapshot['ig']),
                    //   ],
                    // ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => FormPage(docU: documentSnapshot)
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF001128)
                          ),
                          child: const Text("Edit Profile"),
                        ),
                        // const SizedBox(width: 10),
                        // ElevatedButton(
                        //   onPressed: (){
                        //     signOut();
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //       backgroundColor: const Color(0xFF698269)
                        //   ),
                        //   child: const Text("Sign out",style: TextStyle(color: Color(0xFF03001C))),
                        // ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 16),
                    personalInformationContent(documentSnapshot),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    personalInformationContent(documentSnapshot),
                    const SizedBox(height: 20),
                  ],
                );
              }
            }
          }else{
            return const Center(child: CircularProgressIndicator());
            //return const Text("NAAAAAHHHH");
          }
          //return const Text("HUHUHUHU");
          return const Center(child: CircularProgressIndicator());
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.email!),
        actions: [
          GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut();
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),

      body: RefreshIndicator(
        child: ListView(
          children: [buildHomeContent()]
        ),
        onRefresh: () async {
          return Future.delayed(const Duration(seconds: 0));
        },
      ),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Expanded(
      //         child: FutureBuilder(
      //           future: getDocId(),
      //           builder: (context, snapshot){
      //             return ListView.builder(
      //               itemCount: docIDs.length,
      //               itemBuilder: (context, index){
      //                 return Padding(
      //                   padding: const EdgeInsets.all(10),
      //                   child: ListTile(
      //                     tileColor: const Color(0xFF001128),
      //                     title: GetUserName(documentId: docIDs[index]),
      //                   )
      //                 );
      //
      //               },
      //             );
      //           },
      //         )
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
