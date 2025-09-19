import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import 'colors.dart';
import 'delete_dialog.dart';

class UserAttendancePage extends StatefulWidget {
  String name = "";
  String classs = "";
  String phone = "";
  String joiningdate = "";
  String section = "";
  String keyValue = "";


  UserAttendancePage(
      this.name, this.classs, this.phone, this.joiningdate, this.section, this.keyValue);

  @override
  State<UserAttendancePage> createState() => _UserAttendancePageState(name,classs,phone,joiningdate,section,keyValue);


}

class _UserAttendancePageState extends State<UserAttendancePage> {


  String name = "";
  String classs = "";
  String phone = "";
  String joiningdate = "";
  String section = "";
  String keyValue = "";


  bool isPresent = false;
  bool isAbsent = false;

  final putAttendanceRef = FirebaseDatabase.instance.ref("userdata");



  void handlePresentChange(bool? value) {
    setState(() {
      isPresent = value!;
      if (isPresent) {
        isAbsent = false;
        String uploadId = putAttendanceRef.child("userdata").child(keyValue).child("list").push().key.toString();
        putAttendanceRef.child(keyValue).child("list").child(uploadId).set({
          'status':'present',
          'date':'${getDateFun()}',
        });

      }
    });
  }

  void handleAbsentChange(bool? value) {
    setState(() {
      isAbsent = value!;
      if (isAbsent) {
        isPresent = false;
        String uploadId = putAttendanceRef.child("userdata").child(keyValue).child("list").push().key.toString();
        putAttendanceRef.child(keyValue).child("list").child(uploadId).set({
          'status':'absent',
          'date':'${getDateFun()}',
        });
      }
    });
  }

  String getDateFun(){
    DateTime now = DateTime.now();

    // Format the date to display only the date portion (e.g., yyyy-MM-dd)
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    return formattedDate;
  }

  _UserAttendancePageState(
      this.name, this.classs, this.phone, this.joiningdate, this.section, this.keyValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('User Details'),
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.mainColor.withOpacity(0.2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [



                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.introColor,
                        ),
                        child: Center(
                          child: Icon(LineIcons.user,
                          color: AppColors.whiteColor,
                          ),
                        ),
                      ),

                      Text("Name : ${name}",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),





                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text("Section : ${section}",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),

                      Text("Phone : ${phone}",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),



                    ],
                  ),

                  Row(
                    children: [
                      Text("Class : ${classs}",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),


                  Row(
                    children: [
                      Text("Date of Joining : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(joiningdate))}",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.mainColor.withOpacity(0.2),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [

                  Row(
                    children: [
                      Text("Put the Attendance here :",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [

                      CheckboxListTile(
                        title: Text("Present",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                          ),
                        ),
                        value: isPresent,
                        onChanged: handlePresentChange,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),

                      CheckboxListTile(
                        title: Text("Absent",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                          ),
                        ),
                        value: isAbsent,
                        onChanged: handleAbsentChange,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),

                    ],
                  )

                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 35,
              child: Row(
                children: [

                  Container(
                    width: 50,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      )
                    ),
                    child: Center(
                      child: Text("S.No",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  Expanded(child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        )
                    ),
                    child: Center(
                      child: Text("Date",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )),

                  Container(
                    width: 100,
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        )
                    ),
                    child: Center(
                      child: Text("Status",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: Center(child: CircularProgressIndicator(color: AppColors.mainColor,)),
              query: FirebaseDatabase.instance.ref("userdata").child(keyValue).child("list"), itemBuilder: (context, snapshot, animation, index) {
              return InkWell(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeleteDialog(snapshot.key.toString(), keyValue),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                    child: Row(
                      children: [

                        Container(
                          width: 50,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              )
                          ),
                          child: Center(
                            child: Text("${index+1}",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),

                        Expanded(child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              )
                          ),
                          child: Center(
                            child: Text("${snapshot.child("date").value.toString()}",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )),

                        Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              )
                          ),
                          child: Center(
                            child: Text("${snapshot.child("status").value.toString()}",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },),
          )

          // Expanded(child: FirebaseAnimatedList(query: query, itemBuilder: (context, snapshot, animation, index) {
          //   return
          // },))

        ],
      ),
    );
  }
}
