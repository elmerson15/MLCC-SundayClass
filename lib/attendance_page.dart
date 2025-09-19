import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mllccsundayclass/user_attendance_page.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'addname_dialog.dart';
import 'package:http/http.dart' as http;

import 'admin_login.dart';
import 'colors.dart';
import 'notification_dialog.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final DatabaseReference userDateRef = FirebaseDatabase.instance.ref('userdata');
  String _selectedClass = 'All'; // Default selection for filtering
  List<String> classOptions = ['All', 'Nursery', 'Beginner', 'Primary', 'Junior', 'Senior', 'Inter'];

  List<String> tokenList = [];

  // Function to check if the item should be displayed based on the selected class
  bool _filterItem(DataSnapshot snapshot) {
    if (_selectedClass == 'All') {
      return true; // Show all items
    }
    return snapshot.child("class").value.toString() == _selectedClass; // Change 'class' to your actual key
  }

  List<String> months = List.generate(12, (index) {
    DateTime date = DateTime(2024, 6).add(Duration(days: index * 30));
    return DateFormat('MMMM yyyy').format(date);
  });


  int nursery = 0;
  int beginner = 0;
  int primary = 0;
  int junior = 0;
  int inter = 0;
  int senior = 0;
  int total = 0;


  int nurseryState = 0;
  int beginnerState = 0;
  int primaryState = 0;
  int juniorState = 0;
  int seniorState = 0;
  int interState = 0;

  final ref = FirebaseDatabase.instance.ref("userdata");

  final refToken = FirebaseDatabase.instance.ref("usertoken");

  List<String> nurserykeysList = [];
  List<String> beginnerkeysList = [];
  List<String> keysList = [];
  List<String> juniorkeysList = [];
  List<String> seniorkeysList = [];
  List<String> interkeysList = [];



  Future<void> getUserTokenData() async {
    DatabaseEvent event = await refToken.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      tokenList.clear();
      Map<dynamic, dynamic>? values = snapshot.value as Map?;
      values!.forEach((key, value) {
        tokenList.add(value['tokenId'].toString());
      });
    }
  }


  String getDateFun(){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    return formattedDate;
  }

  Future<void> getNurseryData() async {
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      nurserykeysList.clear();
      Map<dynamic, dynamic>? values = snapshot.value as Map?;
      values!.forEach((key, value) {
        if (value['class'].toString() == "Nursery") {
          nurserykeysList.add(key);
        }
      });
    }
    await nurseryListgetdata();
  }


  Future<void> nurseryListgetdata() async {

    for(String s in nurserykeysList){
      final nurseryRef = FirebaseDatabase.instance.ref("userdata").child(s).child("list");
      DatabaseEvent eventNursery = await nurseryRef.once();
      DataSnapshot snapshotNursery = eventNursery.snapshot;
      print(snapshotNursery.value);
      if (snapshotNursery.value != null) {
        Map<dynamic, dynamic>? valuesNursery = snapshotNursery.value as Map?;
        valuesNursery!.forEach((key, value) {

          if(value['date'].toString() == getDateFun() && value['status'].toString() == "present"){
            nursery++;
          }
        });
      }
    }
    setState(() {
      nurseryState = nursery;
    });
  }

  Future<void> getBeginnerData() async {
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      beginnerkeysList.clear();
      Map<dynamic, dynamic>? values = snapshot.value as Map?;
      values!.forEach((key, value) {
        if (value['class'].toString() == "Beginner") {
          beginnerkeysList.add(key);
        }
      });
    }
    await beginnerListgetdata();
  }


  Future<void> beginnerListgetdata() async {

    for(String s in beginnerkeysList){
      final beginnerRef = FirebaseDatabase.instance.ref("userdata").child(s).child("list");
      DatabaseEvent eventBeginner = await beginnerRef.once();
      DataSnapshot snapshotBeginner = eventBeginner.snapshot;
      print(snapshotBeginner.value);
      if (snapshotBeginner.value != null) {
        Map<dynamic, dynamic>? valuesBeginner = snapshotBeginner.value as Map?;
        valuesBeginner!.forEach((key, value) {

          if(value['date'].toString() == getDateFun() && value['status'].toString() == "present"){
            beginner++;
          }
        });
      }
    }
    setState(() {
      beginnerState = beginner;
    });
  }

  Future<void> getPrimaryData() async {
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      keysList.clear();
      Map<dynamic, dynamic>? values = snapshot.value as Map?;
      values!.forEach((key, value) {
        if (value['class'].toString() == "Primary") {
          keysList.add(key);
        }
      });
    }
    await primaryListgetdata();
    await getJuniorData();
    await getNurseryData();
    await getBeginnerData();
    await getSeniorData();
    await getinterData();
  }


  Future<void> primaryListgetdata() async {

    for(String s in keysList){
      final primaryRef = FirebaseDatabase.instance.ref("userdata").child(s).child("list");
      DatabaseEvent eventPrimary = await primaryRef.once();
      DataSnapshot snapshotPrimary = eventPrimary.snapshot;
      print(snapshotPrimary.value);
      if (snapshotPrimary.value != null) {
        Map<dynamic, dynamic>? valuesPrimary = snapshotPrimary.value as Map?;
        valuesPrimary!.forEach((key, value) {

          if(value['date'].toString() == getDateFun() && value['status'].toString() == "present"){
            primary++;
          }
        });
      }
    }
    setState(() {
      primaryState = primary;
    });
  }

  Future<void> getJuniorData() async {
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      juniorkeysList.clear();
      Map<dynamic, dynamic>? values = snapshot.value as Map?;
      values!.forEach((key, value) {
        if (value['class'].toString() == "Junior") {
          juniorkeysList.add(key);
        }
      });
    }
    await juniorListgetdata();
  }


  Future<void> juniorListgetdata() async {

    for(String s in juniorkeysList){
      final juniorRef = FirebaseDatabase.instance.ref("userdata").child(s).child("list");
      DatabaseEvent eventJunior = await juniorRef.once();
      DataSnapshot snapshotJunior = eventJunior.snapshot;
      print(snapshotJunior.value);
      if (snapshotJunior.value != null) {
        Map<dynamic, dynamic>? valuesJunior = snapshotJunior.value as Map?;
        valuesJunior!.forEach((key, value) {

          if(value['date'].toString() == getDateFun() && value['status'].toString() == "present"){
            junior++;
          }
        });
      }
    }
    setState(() {
      juniorState = junior;
    });
  }

  Future<void> getSeniorData() async {
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      seniorkeysList.clear();
      Map<dynamic, dynamic>? values = snapshot.value as Map?;
      values!.forEach((key, value) {
        if (value['class'].toString() == "Senior") {
          seniorkeysList.add(key);
        }
      });
    }
    await seniorListgetdata();
  }


  Future<void> seniorListgetdata() async {

    for(String s in seniorkeysList){
      final seniorRef = FirebaseDatabase.instance.ref("userdata").child(s).child("list");
      DatabaseEvent eventSenior = await seniorRef.once();
      DataSnapshot snapshotSenior = eventSenior.snapshot;
      print(snapshotSenior.value);
      if (snapshotSenior.value != null) {
        Map<dynamic, dynamic>? valuesSenior = snapshotSenior.value as Map?;
        valuesSenior!.forEach((key, value) {

          if(value['date'].toString() == getDateFun() && value['status'].toString() == "present"){
            senior++;
          }
        });
      }
    }
    setState(() {
      seniorState = senior;
    });
  }

  Future<void> getinterData() async {
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      interkeysList.clear();
      Map<dynamic, dynamic>? values = snapshot.value as Map?;
      values!.forEach((key, value) {
        if (value['class'].toString() == "Inter") {
          interkeysList.add(key);
        }
      });
    }
    await interListgetdata();
  }


  Future<void> interListgetdata() async {

    for(String s in interkeysList){
      final interRef = FirebaseDatabase.instance.ref("userdata").child(s).child("list");
      DatabaseEvent eventInter = await interRef.once();
      DataSnapshot snapshotInter = eventInter.snapshot;
      print(snapshotInter.value);
      if (snapshotInter.value != null) {
        Map<dynamic, dynamic>? valuesInter = snapshotInter.value as Map?;
        valuesInter!.forEach((key, value) {

          if(value['date'].toString() == getDateFun() && value['status'].toString() == "present"){
            inter++;
          }
        });
      }
    }
    setState(() {
      interState = inter;
    });
  }

  int totalPresent(){
    return interState + seniorState + juniorState + primaryState + beginnerState + nurseryState;
  }



  Future<http.Response?> sendNotificationToUser(List<String> tokenIdList, String contents, String heading) async {
    const String apiKey = 'MDM1MzQyZjEtMzdhZC00OWY0LTg3NTQtNTE5ZDhmYTM3YTFh';  // Your OneSignal REST API key
    print("sqs");
    try {
      final response = await http.post(
        Uri.parse('https://onesignal.com/api/v1/notifications'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Basic $apiKey',  // Use your OneSignal REST API key here
        },
        body: jsonEncode(<String, dynamic>{
          "app_id": "875ea179-ee15-4e10-a399-cc94d4781856",  // Your OneSignal App ID
          "include_player_ids": tokenIdList,  // List of OneSignal player IDs
          "android_accent_color": "FF9976D2",  // Accent color of the notification
          "small_icon": "ic_stat_onesignal_default",  // Notification icon
          "headings": {"en": heading.isNotEmpty ? heading : "New Notification"},  // Heading in English
          "contents": {"en": contents.isNotEmpty ? contents : "This is a default message"},  // Content in English
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      return response;
    } catch (e) {
      print("Error sending notification: $e");
      return null;
    }
  }






  @override
  void initState() {
    // TODO: implement initState
    getUserTokenData();
    getPrimaryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Attendance')),
        body: Center(
          child: AdminLogin(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        actions: [
          DropdownButton<String>(
            value: _selectedClass,
            onChanged: (value) {
              setState(() {
                _selectedClass = value!;
              });
            },
            items: classOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [


       /* Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap:(){
                      showDialog(
                        context: context,
                        builder: (context) => PasswordDialog(),
                      );
            },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [

                          Icon(Icons.add,
                          size: 18,
                          ),

                          Text("Add Verse",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),*/


          // InkWell(
          //   onTap: () async {
          //
          //
          //     // await OneSignal.shared.setAppId("875ea179-ee15-4e10-a399-cc94d4781856");
          //
          //
          //     showDialog(
          //       context: context,
          //       builder: (context) => NotificationDialog(tokenList),
          //     );
          //
          //   },
          //   child: Container(
          //     width: 100,
          //     height: 30,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(15),
          //       color: AppColors.mainColor.withOpacity(0.2),
          //     ),
          //     child: Center(child: Text("Send")),
          //   ),
          // ),


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.mainColor.withOpacity(0.2),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nursery",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),


                          Text("$nurseryState",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),


                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Beginners",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),
                          Text("$beginnerState",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Primary",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),


                          Text("$primaryState",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),


                        ],
                      ),



                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Total(${getDateFun()})",
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),


                          Text("${totalPresent()}",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                            ),
                          ),


                        ],
                      ),





                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Junior",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),
                          Text("$juniorState",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Inter",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),


                          Text("$interState",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),


                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Senior",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),
                          Text("$seniorState",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),




                ],
              ),
            ),
          ),

          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: Center(child: CircularProgressIndicator(color: AppColors.mainColor)),
              query: userDateRef,
              itemBuilder: (context, snapshot, animation, index) {
                if (_filterItem(snapshot)) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserAttendancePage(
                            snapshot.child("name").value.toString(),
                            snapshot.child("class").value.toString(),
                            snapshot.child("phone").value.toString(),
                            snapshot.child("date").value.toString(),
                            snapshot.child("section").value.toString(),
                            snapshot.key.toString(),
                          ),
                        ));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width : MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Name : ${snapshot.child("name").value.toString()}",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Class : ${snapshot.child("class").value.toString()}",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Section : ${snapshot.child("section").value.toString()}",
                                  style: GoogleFonts.poppins(fontSize: 15),
                                ),
                                Text(
                                  "Phone : ${snapshot.child("phone").value.toString()}",
                                  style: GoogleFonts.poppins(fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Date of Joining : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.child("date").value.toString()))}",
                                  style: GoogleFonts.poppins(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink(); // Return an empty box for non-matching items
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddNameDialog(),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  List<Widget> _buildMonthContent(String month) {
    List<Widget> content = [];
    DateTime firstDayOfMonth = DateFormat('MMMM yyyy').parse(month);
    int daysInMonth = DateUtils.getDaysInMonth(firstDayOfMonth.year, firstDayOfMonth.month);

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(firstDayOfMonth.year, firstDayOfMonth.month, day);
      if (date.weekday == DateTime.sunday) {
        content.add(
          ListTile(
            title: Text(DateFormat('dd MMM yyyy').format(date)),
            onTap: () => _showDateDetails(date),
          ),
        );
      }
    }

    return content;
  }

  void _showDateDetails(DateTime date) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(DateFormat('dd MMM yyyy').format(date)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder<QuerySnapshot>(
                future: _firestore.collection('attendance')
                    .where('date', isEqualTo: date)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text('No data available.');
                  }

                  final docs = snapshot.data!.docs;
                  int presentCount = docs.where((doc) => doc['present'] as bool? ?? false).length;
                  int absentCount = docs.length - presentCount;

                  return Column(
                    children: [
                      ...docs.map((doc) {
                        final name = doc['name'] ?? 'Unknown';
                        final className = doc['class'] ?? 'Unknown';
                        final section = doc['section'] ?? 'Unknown';
                        final isPresent = doc['present'] as bool? ?? false;

                        return ListTile(
                          title: Text('$name ($className, $section)'),
                          trailing: Checkbox(
                            value: isPresent,
                            onChanged: (bool? value) {
                              _firestore.collection('attendance').doc(doc.id).update({
                                'present': value,
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error updating attendance: $error')),
                                );
                              });
                            },
                          ),
                        );
                      }).toList(),
                      Text('Total Present: $presentCount'),
                      Text('Total Absent: $absentCount'),
                    ],
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
