// ignore_for_file: unused_import, avoid_web_libraries_in_flutter, prefer_typing_uninitialized_variables, use_build_context_synchronously, unnecessary_import, avoid_print, must_be_immutable, file_names, unnecessary_null_comparison
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:information_display/Folder%20Main/pages/finalHome.dart';
import 'package:information_display/home.dart';
import 'package:information_display/models/userModel.dart';
import 'package:information_display/models/storageModel.dart';
import 'package:flutter/services.dart';
import 'package:information_display/services/authService.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  //DocumentSnapshot docU;
  DocumentSnapshot? docU;

  FormPage({
    Key? key,
    //required this.docU,
    this.docU
  }): super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final User? user = AuthService().currentUser;
  final CollectionReference profile = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final Storage storage = Storage();
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final age = TextEditingController();
  //late final birthday = TextEditingController();
  final email = TextEditingController();
  final occupation = TextEditingController();
  //var gender, sender;
  bool update = false;

  String? userId(){
    return user?.email;
  }

  @override
  void initState() {
    super.initState();
    //birthday.text='';
  }

  Future createUser({
    required String name,
    required int age,
    required String occupation,
    required String email,
  }) async {
    final docU = FirebaseFirestore.instance.collection('users').doc();

    final profileUser = Profile(
      //id: docU.id,
      name: name,
      age: age,
      occupation: occupation,
      //birthday: birthday,
      email: email,
    );
    final json = profileUser.toJson();

    await docU.set(json);
  }

  Stream<List<Profile>> readProfile() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Profile.fromJson(doc.data())).toList()
  );

  Widget formContent() {
    TextEditingController name = TextEditingController();
    TextEditingController age = TextEditingController();
    TextEditingController occupation = TextEditingController();
    TextEditingController email = TextEditingController();

    name.text = widget.docU!['name'];
    age.text = widget.docU!['age'].toString();
    occupation = widget.docU!['occupation'];
    email = widget.docU!['email'];
    // Timestamp t = widget.documentSnapshot['birthdate'];
    // DateTime date = t.toDate();
    // DateTime? addDate;
    // String formattedDate = DateFormat.yMMMEd().format(date);
    // birthdate.text = formattedDate;
    // aboutMe.text = widget.documentSnapshot['aboutMe'];
    return Form(child: Padding(
      key: formKey,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          TextFormField(
            controller: name,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name:",
                suffixIcon: Icon(Icons.person)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter your Name";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: age,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Age:",
                suffixIcon: Icon(Icons.person)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Age";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: occupation,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Occupation:",
                suffixIcon: Icon(Icons.meeting_room)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Your Occupation";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: email,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email Address:",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter your Email Address";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),

          //const SizedBox(height: 10),
          // TextFormField(
          //   readOnly: true,
          //   controller: birthdate,
          //   decoration: InputDecoration(
          //     border: const OutlineInputBorder(),
          //     labelText: 'Birthdate',
          //     prefixIcon: InkWell(
          //       child: const Icon(Icons.calendar_today),
          //       onTap: () async {
          //         DateTime d = DateTime.now();
          //         addDate = await _selectDate(d);
          //         String formattedDate =
          //         DateFormat('E, d MMM yyyy').format(addDate!);
          //         birthdate.text = formattedDate;
          //       },
          //     ),
          //   ),
          //   validator: (value) {
          //     return (value == '') ? 'Please enter a date and time' : null;
          //   },
          // ),
          // const SizedBox(height: 10),
          // TextFormField(
          //   controller: aboutMe,
          //   textAlignVertical: TextAlignVertical.center,
          //   keyboardType: TextInputType.multiline,
          //   maxLines: null,
          //   decoration: const InputDecoration(
          //     border: OutlineInputBorder(),
          //     labelText: "About me",
          //     suffixIcon: Icon(Icons.info_outline),
          //     contentPadding:
          //     EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          //   ),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return "Pleas Enter url";
          //     }
          //     return null;
          //   },
          // ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              // String FB = widget.documentSnapshot['fb']+fb.text;
              // String IG = widget.documentSnapshot['ig']+ig.text;
              // String GIT = widget.documentSnapshot['git']+git.text;
              // String TWTR = widget.documentSnapshot['twtr']+twtr.text;
              await storage.updateProfileData(
                  widget.docU!.id.toString(),
                  Profile(
                    age: int.parse(age.text),
                    name: name.text,
                    occupation: occupation.text,
                    email: email.text,
                    //birthdate: addDate ?? date,
                  ));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeFinal())
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF001128)
            ),
            child: const Text("Save Changes"),
          ),
        ],
      ),
    ));
  }



  @override
  Widget build(BuildContext context) {
    // DocumentSnapshot? newDoc = widget.docU;
    // if (newDoc != null) {
    //   name.text = newDoc['name'];
    //   age.text = newDoc['age'].toString();
    //   email.text = newDoc['email'];
    //   occupation.text = newDoc['occupation'];
    //   //gender = newDoc['gender'];
    //   //birthday.text = newDoc['birthday'];
    // }

    return Scaffold(
        appBar: AppBar(
          //backgroundColor: const Color(0xFF698269),
          title: const Text("Edit Profile"),
        ),
        body: RefreshIndicator(
            child: ListView(
                padding: EdgeInsets.zero,
                children: [formContent()]),
            onRefresh: () async {
              return Future.delayed(const Duration(seconds: 0));
            }));

    // return Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //       icon: const Icon(Icons.arrow_back)),
    //     title: const Text('Profile Information:'),
    //   ),
    //
    //   body: ListView(
    //     padding: const EdgeInsets.all(20.0),
    //     children: [
    //       const SizedBox(height: 15),
    //       StreamBuilder(
    //               stream: storage.getPicStream('pfp'),
    //               builder: (context, AsyncSnapshot<String> snapshot){
    //                 if (snapshot.hasData){
    //                   return Column(
    //                     children: [
    //                       Container(
    //                         alignment: Alignment.center,
    //                         height: 120,
    //                         child: CircleAvatar(
    //                           radius: 60,
    //                           backgroundImage: NetworkImage(snapshot.data ?? "https://i0.wp.com/collegecore.com/wp-content/uploads/2018/05/facebook-no-profile-picture-icon-620x389.jpg?ssl=1"),
    //                         ),
    //                       ),
    //
    //                       const SizedBox(height: 15),
    //
    //                       ElevatedButton(
    //                         onPressed: () async {
    //                           final result = await FilePicker.platform.pickFiles(
    //                               allowMultiple: false,
    //                               type: FileType.custom,
    //                               allowedExtensions: ['png', 'jpg', 'jpeg']);
    //
    //                           if (result == null) {
    //                             ScaffoldMessenger.of(context).showSnackBar(
    //                                 const SnackBar(
    //                                     content: Text("No Image Selected")
    //                                 )
    //                             );
    //                             return;
    //                           }
    //                           final filePath = result.files.single.path!;
    //                           const fileName = "pfp";
    //                           storage.uploadFile(filePath, fileName);
    //                         },
    //                         style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
    //                         child: const Text(
    //                           "Change Profile",
    //                           style: TextStyle(color: Color(0xFF001128))
    //                         )
    //                       ),
    //
    //                     ],
    //                   );
    //                 }
    //                 if (snapshot.connectionState == ConnectionState.waiting) {
    //                   return const Center(child: CircularProgressIndicator());
    //                 }
    //                 {
    //                   return Column(
    //                     children: [
    //                       Container(
    //                           alignment: Alignment.center,
    //                           height: 120,
    //                           child: const CircleAvatar(
    //                             radius: 60,
    //                             backgroundImage: NetworkImage(
    //                                 "https://i0.wp.com/collegecore.com/wp-content/uploads/2018/05/facebook-no-profile-picture-icon-620x389.jpg?ssl=1"
    //                             ),
    //                           )
    //                       ),
    //
    //                       const SizedBox(height: 10),
    //
    //                       ElevatedButton(
    //                           onPressed: () async {
    //                             final result = await FilePicker.platform.pickFiles(
    //                                 allowMultiple: false,
    //                                 type: FileType.custom,
    //                                 allowedExtensions: ['png', 'jpg', 'jpeg']);
    //
    //                             if (result == null) {
    //                               ScaffoldMessenger.of(context).showSnackBar(
    //                                   const SnackBar(
    //                                     content: Text("No Image Selected")
    //                                   )
    //                               );
    //                               return;
    //                             }
    //                             final filePath = result.files.single.path!;
    //                             const fileName = "pfp";
    //                             storage.uploadFile(filePath, fileName);
    //                           },
    //                           style: ElevatedButton.styleFrom(
    //                               backgroundColor: Colors.white),
    //                           child: const Text(
    //                               "Change Profile",
    //                               style: TextStyle(
    //                                   color: Color(0xFF001128)
    //                               )
    //                           )
    //                       ),
    //                     ],
    //                   );
    //                 }
    //               },
    //             ),
    //       const SizedBox(height: 15),
    //       Container(
    //         height: 500,
    //         alignment: Alignment.center,
    //         child: Form(
    //           autovalidateMode: AutovalidateMode.onUserInteraction,
    //           key: formKey,
    //           child: ListView(
    //             children: [
    //               TextFormField(
    //                 controller: name,
    //                 keyboardType: TextInputType.name,
    //                 decoration: const InputDecoration(
    //                   border: OutlineInputBorder(),
    //                   labelText: "Full Name:",
    //                 ),
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return "Please Enter Full Name";
    //                   }
    //                   return null;
    //                 },
    //               ),
    //
    //               const SizedBox(height: 10),
    //               TextFormField(
    //                 controller: age,
    //                 keyboardType: TextInputType.number,
    //                 decoration: const InputDecoration(
    //                   border: OutlineInputBorder(),
    //                   labelText: "Age:",
    //                 ),
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return "Please Enter Your Age";
    //                   }
    //                   return null;
    //                 },
    //               ),
    //
    //               const SizedBox(height: 10),
    //               TextField(
    //                 controller: birthday,
    //                 decoration: const InputDecoration(
    //                   icon: Icon(Icons.calendar_month),
    //                   labelText: "Birthday:",
    //                 ),
    //                 readOnly: true,
    //                 onTap: () async {
    //                   DateTime? selectedDate = await showDatePicker(
    //                     context: context,
    //                     initialDate: DateTime.now(),
    //                     firstDate: DateTime(1950),
    //                     lastDate: DateTime(2200),
    //                   );
    //                   if (selectedDate != null){
    //                     setState(() {
    //                       String formattedDate = DateFormat("yMMMd").format(selectedDate);
    //                       birthday.text = formattedDate.toString();
    //                     });
    //                   } else {
    //                     print("Date Not Selected");
    //                   }
    //                 },
    //               ),
    //
    //               //const SizedBox(height: 10),
    //               // DropdownButtonFormField(
    //               //   value: gender,
    //               //   decoration: const InputDecoration(
    //               //   labelText: "Gender:", border: OutlineInputBorder()),
    //               //   items: const [
    //               //     DropdownMenuItem(
    //               //       value: "Male",
    //               //       child: Text("Male"),
    //               //     ),
    //               //     DropdownMenuItem(
    //               //       value: "Female",
    //               //       child: Text("Female"),
    //               //     ),
    //               //   ],
    //               //   onChanged: (value) {
    //               //     setState(() {
    //               //       gender = value;
    //               //     });
    //               //   }
    //               // ),
    //
    //               const SizedBox(height: 7),
    //               TextFormField(
    //                 controller: email,
    //                 keyboardType: TextInputType.emailAddress,
    //                 decoration: const InputDecoration(
    //                   border: OutlineInputBorder(),
    //                   labelText: "Email Address:",
    //                   //hintText: user?.email;
    //                   ),
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return "Please Enter Email";
    //                   }
    //                   return null;
    //                 },
    //               ),
    //
    //               const SizedBox(height: 10),
    //               ElevatedButton(
    //                   onPressed: () {
    //
    //                     print(newDoc.id);
    //                     print(firebaseAuth.currentUser!.uid);
    //                     if (formKey.currentState!.validate()) {
    //                       profile.doc(newDoc.id).update({
    //                         "name": name.text,
    //                         "age": int.parse(age.text),
    //                         "gender": gender.toString(),
    //                         "email": email.text,
    //                       });
    //
    //                       final finalName = name.text;
    //                       final finalAge = int.parse(age.text);
    //                       final finalBirthday = birthday.text;
    //                       final finalEmail = email.text;
    //                       //var finalGender = gender.toString();
    //
    //                       createUser(
    //                         name: finalName,
    //                         age: finalAge,
    //                         birthday: finalBirthday,
    //                         email: finalEmail,
    //                       );
    //
    //                       Navigator.pop(context);
    //
    //                     } else {
    //                       return;
    //                     }
    //                   },
    //                   child: const Text("Save Changes"),
    //               ),
    //
    //               const SizedBox(height: 10),
    //
    //               // ElevatedButton(
    //               //   onPressed: (){
    //               //     final docU = FirebaseFirestore.instance
    //               //       .collection('users')
    //               //       .doc(newDoc?.id)
    //               //     ;
    //               //
    //               //     docU.update({
    //               //       'name': name,
    //               //       "age": int.parse(age.text),
    //               //       "gender": gender.toString(),
    //               //       "email": email.text,
    //               //
    //               //     });
    //               //
    //               //
    //               //     Navigator.pop(context);
    //               //   },
    //               //   child: const Text("Update"),
    //               // ),
    //
    //             ],
    //           )
    //         ),
    //       ),
    //
    //     ],
    //   ),
    //
    // );


    // DocumentSnapshot newDoc = widget.docU;
    // if(newDoc != null){
    //   name.text = newDoc['name'];
    //   age.text = newDoc['age'].toString();
    //   birthday.text = newDoc['birthday'];
    //   gender.text = newDoc['gender'];
    //   email.text = newDoc['email'];
    // }
    // return Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //         icon: const Icon(Icons.arrow_back)),
    //     title: const Text('Profile Information:'),
    //   ),
    //
    //   body: ListView(
    //     padding: const EdgeInsets.all(20.0),
    //     children: [
    //       const SizedBox(height: 15),
    //       StreamBuilder(
    //         stream: storage.getPicStream('pfp'),
    //         builder: (context, AsyncSnapshot<String> snapshot){
    //           if (snapshot.hasData){
    //             return Column(
    //               children: [
    //                 Container(
    //                   alignment: Alignment.center,
    //                   height: 120,
    //                   child: CircleAvatar(
    //                     radius: 60,
    //                     backgroundImage: NetworkImage(snapshot.data ?? "https://i0.wp.com/collegecore.com/wp-content/uploads/2018/05/facebook-no-profile-picture-icon-620x389.jpg?ssl=1"),
    //                   ),
    //                 ),
    //
    //                 const SizedBox(height: 15),
    //
    //                 ElevatedButton(
    //                   onPressed: () async {
    //                     final result = await FilePicker.platform.pickFiles(
    //                         allowMultiple: false,
    //                         type: FileType.custom,
    //                         allowedExtensions: ['png', 'jpg', 'jpeg']);
    //
    //                     if (result == null) {
    //                       ScaffoldMessenger.of(context).showSnackBar(
    //                           const SnackBar(
    //                               content: Text("No Image Selected")
    //                           )
    //                       );
    //                       return;
    //                     }
    //                     final filePath = result.files.single.path!;
    //                     const fileName = "pfp";
    //                     storage.uploadFile(filePath, fileName);
    //                   },
    //                   style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
    //                   child: const Text(
    //                     "Change Profile",
    //                     style: TextStyle(color: Color(0xFF001128))
    //                   )
    //                 ),
    //
    //               ],
    //             );
    //           }
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return const Center(child: CircularProgressIndicator());
    //           }
    //           {
    //             return Column(
    //               children: [
    //                 Container(
    //                     alignment: Alignment.center,
    //                     height: 120,
    //                     child: const CircleAvatar(
    //                       radius: 60,
    //                       backgroundImage: NetworkImage(
    //                           "https://i0.wp.com/collegecore.com/wp-content/uploads/2018/05/facebook-no-profile-picture-icon-620x389.jpg?ssl=1"
    //                       ),
    //                     )
    //                 ),
    //
    //                 const SizedBox(height: 10),
    //
    //                 ElevatedButton(
    //                     onPressed: () async {
    //                       final result = await FilePicker.platform.pickFiles(
    //                           allowMultiple: false,
    //                           type: FileType.custom,
    //                           allowedExtensions: ['png', 'jpg', 'jpeg']);
    //
    //                       if (result == null) {
    //                         ScaffoldMessenger.of(context).showSnackBar(
    //                             const SnackBar(
    //                               content: Text("No Image Selected")
    //                             )
    //                         );
    //                         return;
    //                       }
    //                       final filePath = result.files.single.path!;
    //                       const fileName = "pfp";
    //                       storage.uploadFile(filePath, fileName);
    //                     },
    //                     style: ElevatedButton.styleFrom(
    //                         backgroundColor: Colors.white),
    //                     child: const Text(
    //                         "Change Profile",
    //                         style: TextStyle(
    //                             color: Color(0xFF001128)
    //                         )
    //                     )
    //                 ),
    //               ],
    //             );
    //           }
    //         },
    //       ),
    //
    //       Container(
    //         alignment: Alignment.center,
    //         height: 350,
    //         child: Form(
    //           autovalidateMode: AutovalidateMode.onUserInteraction,
    //           key: formKey,
    //           child: ListView(
    //             padding:
    //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //             children: [
    //               TextFormField(
    //                 controller: name,
    //                 keyboardType: TextInputType.name,
    //                 decoration: const InputDecoration(
    //                   border: OutlineInputBorder(),
    //                   labelText: "Full Name:",
    //                 ),
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return "Please Enter Full Name";
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               const SizedBox(height: 7),
    //               TextFormField(
    //                 controller: age,
    //                 keyboardType: TextInputType.number,
    //                 decoration: const InputDecoration(
    //                   border: OutlineInputBorder(),
    //                   labelText: "Age:",
    //                 ),
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return "Please Enter Age";
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               const SizedBox(height: 7),
    //               DropdownButtonFormField(
    //                   value: gender,
    //                   decoration: const InputDecoration(
    //                       labelText: "Gender:", border: OutlineInputBorder()),
    //                   items: const [
    //                     DropdownMenuItem(
    //                       value: "Male",
    //                       child: Text("Male"),
    //                     ),
    //                     DropdownMenuItem(
    //                       value: "Female",
    //                       child: Text("Female"),
    //                     ),
    //                   ],
    //                   onChanged: (value) {
    //                     setState(() {
    //                       gender = value;
    //                     });
    //                   }),
    //               const SizedBox(height: 7),
    //               TextFormField(
    //                 controller: email,
    //                 keyboardType: TextInputType.emailAddress,
    //                 decoration: const InputDecoration(
    //                   border: OutlineInputBorder(),
    //                   labelText: "Email Address:",
    //                   //hintText: user?.email;
    //                 ),
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return "Please Enter Email";
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               const SizedBox(height: 7),
    //             ],
    //           ),
    //         ),
    //       ),
    //
    //       Container(
    //         alignment: Alignment.center,
    //         height: 40,
    //         //color: Colors.blue,
    //         child: ElevatedButton(
    //           onPressed: () async {
    //             print(user != null); //not sure of this
    //             print(firebaseAuth.currentUser!.uid);
    //             if (formKey.currentState!.validate()) {
    //               await profile.doc().update({
    //                 "name": name.text,
    //                 "age": int.parse(age.text),
    //                 "birthday": birthday.text,
    //                 "gender": gender.toString(),
    //                 "email": email.text,
    //               // await profile.doc(newDoc.id).update({
    //               //   "name": name.text,
    //               //   "age": int.parse(age.text),
    //               //   "birthday": birthday.text,
    //               //   "gender": gender.toString(),
    //               //   "email": email.text,
    //               });
    //
    //               Navigator.pop(context);
    //             } else {
    //               return;
    //             }
    //           },
    //           //style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
    //           child: const Text(
    //               "Save Changes",
    //               //style: TextStyle(color: Colors.white)
    //           ),
    //         ),
    //       ),
    //
    //
    //     ],
    //   ),
    //
    // );
  }
}
