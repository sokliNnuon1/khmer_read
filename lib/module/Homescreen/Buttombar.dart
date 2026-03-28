import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.05),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          // Reduced outer padding from 15 to 8 to gain horizontal space
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 6, // Slightly reduced gap
            activeColor: Colors.brown,
            iconSize: 24,
            // Reduced horizontal padding inside the tab from 20 to 12
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.brown.withOpacity(0.1),
            color: Colors.grey,
            tabs: const [
              GButton(icon: Icons.home_filled, text: 'Home'),
              GButton(icon: Icons.explore_outlined, text: 'Explore'),
              GButton(icon: Icons.calendar_today_outlined, text: 'Calendar'),
              GButton(icon: Icons.bookmark_outline, text: 'Saved'),
              GButton(icon: Icons.settings_outlined, text: 'Settings'),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}