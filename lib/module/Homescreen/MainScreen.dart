import 'package:flutter/material.dart';
import 'package:khmer_read/module/Calenda/CalendaScreen.dart';
import 'package:khmer_read/module/Homescreen/Buttombar.dart';
import 'package:khmer_read/module/Homescreen/Homescreen.dart';
import 'package:khmer_read/module/Saved/SavedScreen.dart';
import 'package:khmer_read/module/Search/Searchscreen.dart';
import 'package:khmer_read/module/Setting/Settingscreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCFB),

      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          Homescreen(),
          SearchScreen(),
          CalendarScreen(),
          SavedScreen(),
          SettingsScreen(),
        ],
      ),

      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}