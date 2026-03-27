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
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(.05),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.brown,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            // ignore: deprecated_member_use
            tabBackgroundColor: Colors.brown.withOpacity(0.1),
            color: Colors.grey,
            tabs: const [
              GButton(icon: Icons.home_filled, text: 'Home'),
              GButton(icon: Icons.explore_outlined, text: 'Explore'),
              GButton(icon: Icons.bookmark_outline, text: 'Saved'),
              GButton(icon: Icons.settings_outlined, text: 'Settings' ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}