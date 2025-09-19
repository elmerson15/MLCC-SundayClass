import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mllccsundayclass/provider_data.dart';
import 'beginner_page.dart';
import 'colors.dart';
import 'inter_page.dart';
import 'junior_page.dart';
import 'nursery_page.dart';
import 'primary_page.dart';
import 'senior_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imageUrl =
      'https://firebasestorage.googleapis.com/v0/b/mlccsundayclass.appspot.com/o/homePageImage.jpg?alt=media&token=9f41e1d2-772a-4325-8193-0444cfc1a4b0'; // URL for the main image
  String imageUrl2 =
      'https://firebasestorage.googleapis.com/v0/b/mlccsundayclass.appspot.com/o/monthverse.jpg?alt=media&token=ccd62270-21ed-45d3-af90-6937bf7f4986'; // URL for the second image
  String imageUrl3 =
      'https://firebasestorage.googleapis.com/v0/b/mlccsundayclass.appspot.com/o/thiruvasanam.jpg?alt=media&token=15744550-8ba8-4c1a-8bb0-3938f937d940'; // URL for the third image
  String title = ''; // Title from Firestore

  @override
  void initState() {
    super.initState();
    _loadImagesFromFirebase();
    _loadTitleFromFirestore();
  }

  Future<void> _loadImagesFromFirebase() async {
    try {
      Reference ref1 =
      FirebaseStorage.instance.ref().child('homePageImage.jpg');
      String url1 = await ref1.getDownloadURL();

      Reference ref2 = FirebaseStorage.instance.ref().child('monthverse.jpg');
      String url2 = await ref2.getDownloadURL();

      Reference ref3 =
      FirebaseStorage.instance.ref().child('thiruvasanam.jpg');
      String url3 = await ref3.getDownloadURL();

      setState(() {
        imageUrl = url1;
        imageUrl2 = url2;
        imageUrl3 = url3;
      });
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  Future<void> _loadTitleFromFirestore() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('hometitle')
          .doc('homePage')
          .get();
      if (snapshot.exists) {
        setState(() {
          title = snapshot['title'] ?? 'Title'; // Update with your field name
        });
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error loading title: $e');
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust padding as needed
          child: Image.asset('assets/splash_logo.png'), // Replace with your logo path
        ),
        title: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          child: Text(
            'MLCC Sunday School',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff1a7fd0), Colors.blueGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // The top content and images
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (imageUrl.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator(color: AppColors.mainColor)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ).animate().fadeIn(duration: 150.ms).scale(duration: 100.ms),
                  SizedBox(height: 10),
                  if (imageUrl2.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: imageUrl2,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator(color: AppColors.mainColor)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ).animate().fadeIn(duration: 150.ms).scale(duration: 100.ms, curve: Curves.decelerate),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 1.0),  // Add padding for spacing
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)), // Fixed text scale factor
                      child: Text(
                        title.isNotEmpty ? title : 'Loading...', // Display the title from Firestore
                        style: GoogleFonts.balooThambi2(
                          textStyle: TextStyle(fontSize: 24, color: Colors.black), // Fixed font size
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Grid for the categories
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          _buildCategoryContainer('Nursery', context, NurseryPage()),
                          _buildCategoryContainer('Beginner', context, BeginnerPage()),
                          _buildCategoryContainer('Primary', context, PrimaryPage()),
                          _buildCategoryContainer('Junior', context, JuniorPage()),
                          _buildCategoryContainer('Inter', context, InterPage()),
                          _buildCategoryContainer('Senior', context, SeniorPage()),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                      child: Text(
                        '© MLCC Youth',
                        style: GoogleFonts.hammersmithOne(
                          textStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Copyright at the bottom without scrolling

        ],
      ),
    );
  }

  // Function to build each category container with navigation
  Widget _buildCategoryContainer(String label, BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.mainColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.balooThambi2(
            textStyle: TextStyle(fontSize: 18, color: Colors.black),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
