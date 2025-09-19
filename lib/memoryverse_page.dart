import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

import 'colors.dart'; // Import intl pack


class MemoryVersePage extends StatefulWidget {
  const MemoryVersePage({super.key});

  @override
  _MemoryVersePageState createState() => _MemoryVersePageState();
}

class _MemoryVersePageState extends State<MemoryVersePage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('memoryverse');
  Map<String, List<Map<String, String>>> _versesByMonth = {};
  bool _isLoading = true;
  String? _expandedMonth; // Keep track of the currently expanded month

  @override
  void initState() {
    super.initState();
    _fetchVerses();
  }

  // Fetches the memory verses from Firebase and organizes them by month
  Future<void> _fetchVerses() async {
    try {
      DataSnapshot snapshot = await _dbRef.get();

      if (snapshot.exists && snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        Map<String, List<Map<String, String>>> tempMap = {};

        values.forEach((key, value) {
          String date = value['date'];

          DateTime dateTime;
          try {
            dateTime = DateFormat('d MMM yyyy').parse(date);
          } catch (e) {
            print('Error parsing date: $e');
            return;
          }

          String month = DateFormat('MMMM').format(dateTime); // Get month name only

          if (!tempMap.containsKey(month)) {
            tempMap[month] = [];
          }

          tempMap[month]!.add({
            'date': date, // Keep the original string date for display
            'day': dateTime.day.toString(), // Add only the day for display
            'title': value['title'],
            'verse': value['verse'],
            'verseenglish': value['verseenglish']
          });
        });

        tempMap.forEach((key, value) {
          value.sort((a, b) {
            DateTime dateA = DateFormat('d MMM yyyy').parse(a['date']!);
            DateTime dateB = DateFormat('d MMM yyyy').parse(b['date']!);
            return dateA.compareTo(dateB);
          });
        });

        setState(() {
          _versesByMonth = tempMap;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _versesByMonth = {};
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> monthOrder = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    // Reset the expanded month when the page is rebuilt
    if (!monthOrder.contains(_expandedMonth)) {
      _expandedMonth = null; // Close the tile if the page has changed or reset
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('திருவசனம்'),
        centerTitle: true,
      ),
      body: _isLoading
          ?  Center(
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
            SizedBox(height: 1), // Add some space between the image and the text
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16, // Set the font size
                fontWeight: FontWeight.bold, // Set the font weight if desired
                color: Colors.black, // Change to your desired color
              ),
            ),
          ],
        ),
      )


          : _versesByMonth.isEmpty
          ? const Center(child: Text('No data available'))
          : ListView.builder(
        itemCount: monthOrder.length,
        itemBuilder: (context, index) {
          String month = monthOrder[index];
          bool isExpanded = _expandedMonth == month;

          return ExpansionTile(
            key: PageStorageKey(month),
            title: Text(
              month,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isExpanded ? Colors.lightBlueAccent : Colors.black, // Highlight the selected month
              ),
            ),
            children: [
              Wrap(
                spacing: 8.0, // Horizontal spacing between tiles
                runSpacing: 8.0, // Vertical spacing between tiles
                children: _versesByMonth[month]?.map((verseData) {
                  return GestureDetector(
                    onTap: () => _showVerseDetail(context, verseData),
                    child: Container(
                      width: 80, // Square tile width
                      height: 50, // Square tile height
                      decoration: BoxDecoration(
                        color: AppColors.mainColor.withOpacity(0.2), // Tile color
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        verseData['day']!, // Display only the day
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                }).toList() ?? [const Text('No verses available for this month')],
              ),
            ],
            onExpansionChanged: (expanded) {
              setState(() {
                // Set the expanded month if expanded, else close it
                _expandedMonth = expanded ? month : null;
              });
            },
            initiallyExpanded: isExpanded,
          );
        },
      ),
    );
  }


  // Function to display verse details in a dialog
// Function to display verse details in a dialog
  void _showVerseDetail(BuildContext context, Map<String, String> verseData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.themeLightGreenColor,
          title: Text(verseData['title']!),
          content: SingleChildScrollView( // Make content scrollable
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
              children: [
                Text("Date: ${verseData['date']}"), // Display full date here
                const SizedBox(height: 10),
                Text("Verse: ${verseData['verse']}"),
                const SizedBox(height: 15),
                Text("Verse (English): ${verseData['verseenglish']}"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
