import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'colors.dart';

class BeginnerPage extends StatefulWidget {
  @override
  _BeginnerPageState createState() => _BeginnerPageState();
}

class _BeginnerPageState extends State<BeginnerPage> {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<String>> _loadImages() async {
    ListResult result = await storage.ref('beginner').listAll();
    List<String> imageUrls = [];

    for (var ref in result.items) {
      String url = await ref.getDownloadURL();
      imageUrls.add(url);
    }
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beginner Book'),
      ),
      body: FutureBuilder<List<String>>(
        future: _loadImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(358 / 360),
                    child: Image.asset(
                      'assets/splash_logo.png', // Update with your logo's path
                      height: 90,
                      width: 90,
                    ),
                  ),
                  SizedBox(height: 1), // Adds spacing between the indicator and the text
                  Text(
                    "Beginner Book Loading...",
                    style: TextStyle(fontSize: 16, color: Colors.grey), // Customize as needed
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading images'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No images found'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator(color: AppColors.mainColor)),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                      fit: BoxFit.contain, // Display image in its own size
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
