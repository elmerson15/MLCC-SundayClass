import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Service {
  Future<bool> fetchData() async {
    // Reference to the database location where tokens are stored
    final ref = FirebaseDatabase.instance.ref("usertoken");

    // Set the OneSignal App ID
    OneSignal.shared.setAppId("875ea179-ee15-4e10-a399-cc94d4781856");

    // Request permission for notifications
    await OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Notification permission accepted: $accepted");
    });

    // Get the device's unique OneSignal token
    var status = await OneSignal.shared.getDeviceState();
    String? tokenId = status?.userId;

    if (tokenId == null) {
      // If token is not generated, return false
      print("Token generation failed.");
      return false;
    }

    print("Generated Token: $tokenId");

    // Check if the token already exists in the database
    DatabaseEvent snap = await ref.orderByChild("tokenId").equalTo(tokenId).once();

    if (snap.snapshot.value == null) {
      // Token doesn't exist in the database, so add it
      String newKey = ref.push().key!; // Generate a new unique key
      await ref.child(newKey).set({
        "tokenId": tokenId,
      }).then((_) {
        print("Token added successfully.");
      }).catchError((error) {
        print("Failed to add token: $error");
      });

      // Return true since the token was successfully generated and stored
      return true;
    } else {
      // Token already exists in the database
      print("Token already exists in the database.");
      return true;
    }
  }
}

// Riverpod provider for accessing the Service class
final provider = Provider<Service>((ref) => Service());
