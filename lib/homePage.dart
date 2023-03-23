// ignore_for_file: file_names, prefer_typing_uninitialized_variables
//import 'package:flex_color_scheme/flex_color_scheme.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int? selectedIndex;
  final dynamic data;

  const HomePage({
    Key? key,
    this.selectedIndex,
    this.data,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String photoPath = '';

  late Future<List> dataList;
  List datas = [];
  var receiver;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "AppDev | Activity #1",
              style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  //color: Color(0xffc47530),
              ),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.account_circle_outlined, )),
                Tab(icon: Icon(Icons.family_restroom_outlined, )),
                Tab(icon: Icon(Icons.school_outlined, )),
              ],
            ),
          ),

          body: TabBarView(
            children: [
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Container(
                          height: 800.0,
                          color: Colors.transparent,
                          child: LayoutBuilder(
                              builder: (context, constraints){
                                double innerHeight = constraints.maxHeight;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                        top: 90,
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: innerHeight * 0.95,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: const Color(0xFF001128),
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 55.0),

                                              const Text(
                                                  'Jachin Chan Co',
                                                  style: TextStyle(
                                                    fontFamily: 'Satisfy',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25.0,
                                                    //color: Colors.black54
                                                  )
                                              ),

                                              const SizedBox(height: 10.0),

                                              Padding(
                                                padding: const EdgeInsets.only(right: 25.0, left: 25.0,),
                                                child: Material(
                                                  elevation: 10.0,
                                                  //borderRadius: BorderRadius.circular(5),
                                                  //color: const Color(0xff3f76bf),
                                                  color: Colors.transparent,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      // Padding(
                                                      //   padding: const EdgeInsets.all(10.0),
                                                      //   child: ElevatedButton(
                                                      //       onPressed: () async {
                                                      //         receiver = await Navigator.push(
                                                      //             context,
                                                      //             MaterialPageRoute(
                                                      //                 builder: (context) => const TabOneFormPage(
                                                      //                   //docU: docToEdit,
                                                      //                 )));
                                                      //         if (receiver != null) {
                                                      //           setState(() {
                                                      //             datas.add(receiver);
                                                      //           });
                                                      //         } else {
                                                      //           return;
                                                      //         }
                                                      //       },
                                                      //       style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                      //       child: const Text(
                                                      //           "Edit Profile",
                                                      //           style: TextStyle(
                                                      //             color: Color(0xFF001128),
                                                      //             fontWeight: FontWeight.bold,
                                                      //           )
                                                      //       )
                                                      //   ),
                                                      // ),



                                                    ],
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 10.0),

                                              const Text(
                                                "Basic Information:",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'PlayfairDisplay',
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  //color: Colors.black54
                                                ),
                                              ),

                                              const Card(
                                                margin: EdgeInsets.only(right: 25.0, left: 25.0, top: 10.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.zero,
                                                ),
                                                color: Color(0xff3f76bf),
                                                child: ListTile(
                                                  leading: Icon(Icons.account_circle, color: Color(0xFF001128)),
                                                  title: Text.rich(TextSpan(
                                                      text: "Name: ",
                                                      style: TextStyle(
                                                        fontFamily: 'PlayfairDisplay',
                                                        //color: Colors.white
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "Jachin C. Co",
                                                            style: TextStyle(
                                                                fontFamily: 'PlayfairDisplay',
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(0xFF001128)
                                                            )
                                                        )
                                                      ]
                                                  )),
                                                ),
                                              ),

                                              const Card(
                                                margin: EdgeInsets.symmetric(horizontal: 25.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.zero,
                                                ),
                                                color: Color(0xff3f76bf),
                                                child: ListTile(
                                                  leading: Icon(Icons.stacked_bar_chart, color: Color(0xFF001128)),
                                                  title: Text.rich(TextSpan(
                                                      text: "Course & Year: ",
                                                      style: TextStyle(
                                                        fontFamily: 'PlayfairDisplay',
                                                        //color: Colors.white
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "BS in Information Technology - 3rd Year",
                                                            style: TextStyle(
                                                                fontFamily: 'PlayfairDisplay',
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(0xFF001128)
                                                            )
                                                        )
                                                      ]
                                                  )),
                                                ),
                                              ),

                                              const Card(
                                                margin: EdgeInsets.symmetric(horizontal: 25.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.zero,
                                                ),
                                                color: Color(0xff3f76bf),
                                                child: ListTile(
                                                  leading: Icon(Icons.onetwothree_outlined, color: Color(0xFF001128)),
                                                  title: Text.rich(TextSpan(
                                                      text: "Age: ",
                                                      style: TextStyle(
                                                        fontFamily: 'PlayfairDisplay',
                                                        //color: Colors.white
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "21 years old",
                                                            style: TextStyle(
                                                                fontFamily: 'PlayfairDisplay',
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(0xFF001128)
                                                            )
                                                        )
                                                      ]
                                                  )),
                                                ),
                                              ),

                                              const Card(
                                                margin: EdgeInsets.symmetric(horizontal: 25.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.zero,
                                                ),
                                                color: Color(0xff3f76bf),
                                                child: ListTile(
                                                  leading: Icon(Icons.cake, color: Color(0xFF001128)),
                                                  title: Text.rich(TextSpan(
                                                      text: "BirthDate: ",
                                                      style: TextStyle(
                                                        fontFamily: 'PlayfairDisplay',
                                                        //color: Colors.white
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "June 22, 2001",
                                                            style: TextStyle(
                                                                fontFamily: 'PlayfairDisplay',
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(0xFF001128)
                                                            )
                                                        )
                                                      ]
                                                  )),
                                                ),
                                              ),

                                              const Card(
                                                margin: EdgeInsets.symmetric(horizontal: 25.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.zero,
                                                ),
                                                color: Color(0xff3f76bf),
                                                child: ListTile(
                                                  leading: Icon(Icons.people, color: Color(0xFF001128)),
                                                  title: Text.rich(TextSpan(
                                                      text: "Gender: ",
                                                      style: TextStyle(
                                                        fontFamily: 'PlayfairDisplay',
                                                        //color: Colors.white
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "Female",
                                                            style: TextStyle(
                                                                fontFamily: 'PlayfairDisplay',
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(0xFF001128)
                                                            )
                                                        )
                                                      ]
                                                  )),
                                                ),
                                              ),

                                              const Card(
                                                margin: EdgeInsets.symmetric(horizontal: 25.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.zero,
                                                ),
                                                color: Color(0xff3f76bf),
                                                child: ListTile(
                                                  leading: Icon(Icons.bloodtype, color: Color(0xFF001128)),
                                                  title: Text.rich(TextSpan(
                                                      text: "Blood Type: ",
                                                      style: TextStyle(
                                                        fontFamily: 'PlayfairDisplay',
                                                        //color: Colors.white
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "O+",
                                                            style: TextStyle(
                                                                fontFamily: 'PlayfairDisplay',
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(0xFF001128)
                                                            )
                                                        )
                                                      ]
                                                  )),
                                                ),
                                              ),

                                              const Card(
                                                margin: EdgeInsets.symmetric(horizontal: 25.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.zero,
                                                ),
                                                color: Color(0xff3f76bf),
                                                child: ListTile(
                                                  leading: Icon(Icons.phone, color: Color(0xFF001128)),
                                                  title: Text.rich(TextSpan(
                                                      text: "Phone Number: ",
                                                      style: TextStyle(
                                                        fontFamily: 'PlayfairDisplay',
                                                        //color: Colors.white
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "0922 700 3816",
                                                            style: TextStyle(
                                                                fontFamily: 'PlayfairDisplay',
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(0xFF001128)
                                                            )
                                                        )
                                                      ]
                                                  )),
                                                ),
                                              ),

                                              const Card(
                                                margin: EdgeInsets.only(right: 25.0, left: 25.0, bottom: 10.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.zero,
                                                ),
                                                color: Color(0xff3f76bf),
                                                child: ListTile(
                                                  leading: Icon(Icons.mail, color: Color(0xFF001128)),
                                                  title: Text.rich(TextSpan(
                                                      text: "Email Address: ",
                                                      style: TextStyle(
                                                        fontFamily: 'PlayfairDisplay',
                                                        //color: Colors.white
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "jachin.co22@gmail.com",
                                                            style: TextStyle(
                                                                fontFamily: 'PlayfairDisplay',
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(0xFF001128)
                                                            )
                                                        )
                                                      ]
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),

                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                          child: CircleAvatar(
                                            radius: 70.0,
                                            backgroundColor: const Color(0xFF001128),
                                            child: CircleAvatar(
                                              radius: 60.0,
                                              backgroundColor: const Color(0xFF001128),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  'assets/images/image1.jpg',
                                                  //width: innerWidth * 0.45,
                                                  //fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                          )
                                      ),
                                    ),

                                  ],
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF001128),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(15.0),
                    children: const [
                      Text(
                        "Family Details:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Satisfy',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            //color: Colors.black
                        ),
                      ),

                      SizedBox(height: 10.0),

                      ExpansionTile(
                        backgroundColor: Color(0xff3f76bf),
                        leading: Icon(Icons.perm_identity),
                        title: Text(
                            "Jimmy O. Co",
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Father",
                          style: TextStyle(
                            fontFamily: 'Satisfy',
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: [
                          ListTile(
                            leading: Icon(Icons.cake, color: Color(0xFF001128)),
                            title: Text.rich(TextSpan(
                                text: "Date of Birth: ",
                                style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontSize: 13.0,
                                  //color: Colors.white,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "October 18, 1967",
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001128)
                                      )
                                  )
                                ]
                            )),
                          ),
                          ListTile(
                            leading: Icon(Icons.calendar_month, color: Color(0xFF001128)),
                            title: Text.rich(TextSpan(
                                text: "Date of Death: ",
                                style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontSize: 13.0,
                                  //color: Colors.white
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "September 07, 2021",
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001128)
                                      )
                                  )
                                ]
                            )),
                          ),
                          ListTile(
                            leading: Icon(Icons.work, color: Color(0xFF001128)),
                            title: Text.rich(TextSpan(
                                text: "Occupation: ",
                                style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: 13.0,
                                    //color: Colors.white
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Church Minister",
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001128)
                                      )
                                  )
                                ]
                            )),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.0),

                      ExpansionTile(
                        backgroundColor: Color(0xff3f76bf),
                        leading: Icon(Icons.perm_identity),
                        title: Text(
                          "Jean C. Co",
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Mother",
                          style: TextStyle(
                            fontFamily: 'Satisfy',
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: [
                          ListTile(
                            leading: Icon(Icons.cake, color: Color(0xFF001128)),
                            title: Text.rich(TextSpan(
                                text: "Date of Birth: ",
                                style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontSize: 13.0,
                                  //color: Colors.white,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "August 21, 1969",
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001128)
                                      )
                                  )
                                ]
                            )),
                          ),
                          ListTile(
                            leading: Icon(Icons.calendar_month, color: Color(0xFF001128)),
                            title: Text.rich(TextSpan(
                                text: "Age: ",
                                style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: 13.0,
                                    //color: Colors.white
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "54",
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001128)
                                      )
                                  )
                                ]
                            )),
                          ),
                          ListTile(
                            leading: Icon(Icons.work, color: Color(0xFF001128)),
                            title: Text.rich(TextSpan(
                                text: "Occupation: ",
                                style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: 13.0,
                                    //color: Colors.white
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Bookkeeper",
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001128)
                                      )
                                  )
                                ]
                            )),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.0),

                      ExpansionTile(
                        backgroundColor: Color(0xff3f76bf),
                        leading: Icon(Icons.perm_identity),
                        title: Text(
                          "John C. Co",
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Older Brother",
                          style: TextStyle(
                            fontFamily: 'Satisfy',
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: [
                          ListTile(
                            leading: Icon(Icons.cake, color: Color(0xFF001128)),
                            title: Text.rich(TextSpan(
                                text: "Date of Birth: ",
                                style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontSize: 13.0,
                                  //color: Colors.white,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "January 23, 2000",
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001128)
                                      )
                                  )
                                ]
                            )),
                          ),
                          ListTile(
                            leading: Icon(Icons.calendar_month, color: Color(0xFF001128)),
                            title: Text.rich(TextSpan(
                                text: "Age: ",
                                style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: 13.0,
                                    //color: Colors.white
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "23",
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001128)
                                      )
                                  )
                                ]
                            )),
                          ),
                          ListTile(
                            leading: Icon(Icons.work, color: Color(0xFF001128)),
                            title: Text.rich(TextSpan(
                                text: "Occupation: ",
                                style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: 13.0,
                                    //color: Colors.white
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Student",
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001128)
                                      )
                                  )
                                ]
                            )),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.0),

                      ExpansionTile(
                        backgroundColor: Color(0xff3f76bf),
                        leading: Icon(Icons.perm_identity),
                        title: Text(
                          "Justin C. Co",
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Younger Brother",
                          style: TextStyle(
                            fontFamily: 'Satisfy',
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: [
                          ListTile(
                            leading: Icon(Icons.cake, color: Color(0xFF001128)),
                            title: Text.rich(TextSpan(
                                text: "Date of Birth: ",
                                style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontSize: 13.0,
                                  //color: Colors.white,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "June 02, 2004",
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001128)
                                      )
                                  )
                                ]
                            )),
                          ),
                          ListTile(
                            leading: Icon(Icons.calendar_month, color: Color(0xFF001128)),
                            title: Text.rich(TextSpan(
                                text: "Age: ",
                                style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: 13.0,
                                    //color: Colors.white
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "19",
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001128)
                                      )
                                  )
                                ]
                            )),
                          ),
                          ListTile(
                            leading: Icon(Icons.work, color: Color(0xFF001128)),
                            title: Text.rich(TextSpan(
                                text: "Occupation: ",
                                style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: 13.0,
                                    //color: Colors.white
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Student",
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001128)
                                      )
                                  )
                                ]
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Container(
                          height: 1100.0,
                          color: Colors.transparent,
                          child: LayoutBuilder(
                              builder: (context, constraints){
                                double innerHeight = constraints.maxHeight;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                        top: 90,
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: innerHeight * 0.95,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: const Color(0xFF001128),
                                          ),
                                          child: Column(
                                            children: const [
                                              SizedBox(
                                                height: 55.0,
                                              ),
                                              Text(
                                                  'Education',
                                                  style: TextStyle(
                                                      fontFamily: 'Satisfy',
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 25.0,
                                                      //color: Colors.black
                                                  )
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 15.0),
                                                child: ExpansionTile(
                                                  backgroundColor: Color(0xff3f76bf),
                                                  leading: Icon(Icons.school_rounded),
                                                  title: Text(
                                                    "Pre-School",
                                                    style: TextStyle(
                                                      fontFamily: 'PlayfairDisplay',
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  children: [
                                                    ListTile(
                                                      leading: Icon(Icons.edit_sharp, color: Color(0xFF001128)),
                                                      title: Text.rich(TextSpan(
                                                          text: "Kid's Place ",
                                                          style: TextStyle(
                                                            fontFamily: 'PlayfairDisplay',
                                                            fontSize: 13.0,
                                                            fontWeight: FontWeight.bold,
                                                            //color: Colors.white,
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: "(Nursery - Kinder 1)",
                                                                style: TextStyle(
                                                                    fontFamily: 'PlayfairDisplay',
                                                                    fontSize: 13.0,
                                                                    color: Color(0xFF001128)
                                                                )
                                                            )
                                                          ]
                                                      )),
                                                    ),
                                                    ListTile(
                                                      leading: Icon(Icons.edit_sharp, color: Color(0xFF001128)),
                                                      title: Text.rich(TextSpan(
                                                          text: "Cagayan de Oro Christian School - UCCP ",
                                                          style: TextStyle(
                                                              fontFamily: 'PlayfairDisplay',
                                                              fontSize: 13.0,
                                                              fontWeight: FontWeight.bold,
                                                              //color: Colors.white
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: "(Kinder 2)",
                                                                style: TextStyle(
                                                                    fontFamily: 'PlayfairDisplay',
                                                                    fontSize: 13.0,
                                                                    color: Color(0xFF001128)
                                                                )
                                                            )
                                                          ]
                                                      )),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0),
                                                child: ExpansionTile(
                                                  backgroundColor: Color(0xff3f76bf),
                                                  leading: Icon(Icons.school_rounded),
                                                  title: Text(
                                                    "Elementary",
                                                    style: TextStyle(
                                                      fontFamily: 'PlayfairDisplay',
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  children: [
                                                    ListTile(
                                                      leading: Icon(Icons.edit_sharp, color: Color(0xFF001128)),
                                                      title: Text.rich(TextSpan(
                                                          text: "Cagayan de Oro Christian School - UCCP ",
                                                          style: TextStyle(
                                                            fontFamily: 'PlayfairDisplay',
                                                            fontSize: 13.0,
                                                            fontWeight: FontWeight.bold,
                                                            //color: Colors.white,
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: "(Grade 1 - Grade 6)",
                                                                style: TextStyle(
                                                                    fontFamily: 'PlayfairDisplay',
                                                                    fontSize: 13.0,
                                                                    color: Color(0xFF001128)
                                                                )
                                                            )
                                                          ]
                                                      )),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0),
                                                child: ExpansionTile(
                                                  backgroundColor: Color(0xff3f76bf),
                                                  leading: Icon(Icons.school_rounded),
                                                  title: Text(
                                                    "Junior High School",
                                                    style: TextStyle(
                                                      fontFamily: 'PlayfairDisplay',
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  children: [
                                                    ListTile(
                                                      leading: Icon(Icons.edit_sharp, color: Color(0xFF001128)),
                                                      title: Text.rich(TextSpan(
                                                          text: "Pilgrim Christian College ",
                                                          style: TextStyle(
                                                            fontFamily: 'PlayfairDisplay',
                                                            fontSize: 13.0,
                                                            fontWeight: FontWeight.bold,
                                                            //color: Colors.white,
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: "(Grade 7 - Grade 10)",
                                                                style: TextStyle(
                                                                    fontFamily: 'PlayfairDisplay',
                                                                    fontSize: 13.0,
                                                                    color: Color(0xFF001128)
                                                                )
                                                            )
                                                          ]
                                                      )),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0),
                                                child: ExpansionTile(
                                                  backgroundColor: Color(0xff3f76bf),
                                                  leading: Icon(Icons.school_rounded),
                                                  title: Text(
                                                    "Senior High School",
                                                    style: TextStyle(
                                                      fontFamily: 'PlayfairDisplay',
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  children: [
                                                    ListTile(
                                                      leading: Icon(Icons.edit_sharp, color: Color(0xFF001128)),
                                                      title: Text.rich(TextSpan(
                                                          text: "Gusa Regional Science High School - Region X ",
                                                          style: TextStyle(
                                                            fontFamily: 'PlayfairDisplay',
                                                            fontSize: 13.0,
                                                            fontWeight: FontWeight.bold,
                                                            //color: Colors.white,
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: "(Grade 11 - Grade 12)",
                                                                style: TextStyle(
                                                                    fontFamily: 'PlayfairDisplay',
                                                                    fontSize: 13.0,
                                                                    color: Color(0xFF001128)
                                                                )
                                                            )
                                                          ]
                                                      )),
                                                    ),

                                                    ListTile(
                                                      contentPadding: EdgeInsets.only(left: 100.0, right: 15.0, bottom: 10.0),
                                                      title: Text.rich(TextSpan(
                                                          text: "Strand: ",
                                                          style: TextStyle(
                                                              fontFamily: 'PlayfairDisplay',
                                                              fontSize: 13.0,
                                                              fontWeight: FontWeight.bold,
                                                              //color: Colors.white
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: "STEM (Science, Technology, Engineering, Mathematics)",
                                                                style: TextStyle(
                                                                    fontFamily: 'PlayfairDisplay',
                                                                    fontSize: 13.0,
                                                                    color: Color(0xFF001128)
                                                                )
                                                            )
                                                          ]
                                                      )),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 10.0),
                                                child: ExpansionTile(
                                                  backgroundColor: Color(0xff3f76bf),
                                                  leading: Icon(Icons.school_rounded),
                                                  title: Text(
                                                    "College",
                                                    style: TextStyle(
                                                      fontFamily: 'PlayfairDisplay',
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  children: [
                                                    ListTile(
                                                      leading: Icon(Icons.edit_sharp, color: Color(0xFF001128)),
                                                      title: Text.rich(TextSpan(
                                                          text: "University of Science and Technology of Southern Philippines ",
                                                          style: TextStyle(
                                                            fontFamily: 'PlayfairDisplay',
                                                            fontSize: 13.0,
                                                            fontWeight: FontWeight.bold,
                                                            //color: Colors.white,
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: "(1st Year - 4th Year)",
                                                                style: TextStyle(
                                                                    fontFamily: 'PlayfairDisplay',
                                                                    fontSize: 13.0,
                                                                    color: Color(0xFF001128)
                                                                )
                                                            )
                                                          ]
                                                      )),
                                                    ),
                                                    ListTile(
                                                      contentPadding: EdgeInsets.only(left: 100.0, right: 15.0, bottom: 10.0),
                                                      title: Text.rich(TextSpan(
                                                          text: "Course: ",
                                                          style: TextStyle(
                                                              fontFamily: 'PlayfairDisplay',
                                                              fontSize: 13.0,
                                                              fontWeight: FontWeight.bold,
                                                              //color: Colors.white
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: "B.S. in Information Technology",
                                                                style: TextStyle(
                                                                    fontFamily: 'PlayfairDisplay',
                                                                    fontSize: 13.0,
                                                                    color: Color(0xFF001128)
                                                                )
                                                            )
                                                          ]
                                                      )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),

                                    const Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                          child: CircleAvatar(
                                            radius: 70.0,
                                            backgroundColor: Color(0xFF001128),
                                            child: CircleAvatar(
                                              radius: 60.0,
                                              backgroundColor: Colors.white,
                                              child: ClipOval(
                                                child: Icon(
                                                  Icons.school,
                                                  size: 80.0,
                                                  color: Color(0xFF001128),
                                                ),
                                              ),
                                            ),
                                          )
                                      ),
                                    ),

                                  ],
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}