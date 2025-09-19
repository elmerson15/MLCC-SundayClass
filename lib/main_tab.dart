import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mllccsundayclass/notificationalert_dialog.dart';
import 'package:mllccsundayclass/provider_data.dart';
import 'home_page.dart';
import 'memoryverse_page.dart';
import 'songs_text.dart';
import 'verse.dart';
import 'attendance_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'colors.dart';

class MainTab extends ConsumerStatefulWidget {
  const MainTab({super.key});

  @override
  ConsumerState<MainTab> createState() => _MainTabState();
}

class _MainTabState extends ConsumerState<MainTab> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SongsList(),
    MemoryVersePage(),
    VersePage(),
    AttendancePage(),
  ];

  @override
  Widget build(BuildContext context) {

    double defaultTextSize = MediaQuery.of(context).size.width * 0.04; // Set a default text size based on screen width

    final data = ref.watch(productdataprovider);

    if (data.value == true){
      return WillPopScope(
        onWillPop: () async {
          if (_selectedIndex != 0) {
            setState(() {
              _selectedIndex = 0;
            });
            return false;
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: Container(
            height: 70, // Fixed height for bottom navigation
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                gap: 8,
                iconSize: 24,
                mainAxisAlignment: MainAxisAlignment.center,
                selectedIndex: _selectedIndex,
                color: AppColors.blackColor,
                duration: const Duration(milliseconds: 400),
                activeColor: AppColors.blackColor,
                tabBackgroundColor: AppColors.mainColor.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                tabs: [
                  GButton(
                    text: 'Home',
                    icon: LineIcons.home,
                    textStyle: TextStyle(
                      fontSize: defaultTextSize, // Fixed text size
                      color: AppColors.blackColor,
                    ),
                  ),
                  GButton(
                    text: 'பாடல்கள்',
                    icon: LineIcons.music,
                    textStyle: TextStyle(
                      fontSize: defaultTextSize, // Fixed text size
                      color: AppColors.blackColor,
                    ),
                  ),
                  GButton(
                    text: 'திருவசனம்',
                    icon: LineIcons.bible,
                    textStyle: TextStyle(
                      fontSize: defaultTextSize, // Fixed text size
                      color: AppColors.blackColor,
                    ),
                  ),
                  GButton(
                    text: 'Verses',
                    icon: LineIcons.book,
                    textStyle: TextStyle(
                      fontSize: defaultTextSize, // Fixed text size
                      color: AppColors.blackColor,
                    ),
                  ),
                  GButton(
                    text: 'User',
                    icon: LineIcons.user,
                    textStyle: TextStyle(
                      fontSize: defaultTextSize, // Fixed text size
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      );
    }
    if (data.value == false){
      return NotificationalertDialog();
    }
    else {
      return Center(child: CircularProgressIndicator(color: AppColors.mainColor.withOpacity(0.2),));
    }
  }
}
