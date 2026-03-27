import 'package:flutter/material.dart';

Widget buildBookItem(String title, String author, Color color) {
  return Padding(
    padding: const EdgeInsets.only(right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 130,
          height: 180,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(author, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    ),
  );
}

Widget buildCurrentBookCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    height: 160,
    decoration: BoxDecoration(
      color: Colors.brown.shade400,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        // ignore: deprecated_member_use
        BoxShadow(color: Colors.brown.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
      ],
    ),
    child: Row(
      children: [
        // Mock Book Cover
        Container(
          width: 100,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Icon(Icons.book, color: Colors.white, size: 40)),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Atomic Habits",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text("James Clear", style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 15),
              const Text("75% Completed", style: TextStyle(color: Colors.white, fontSize: 12)),
              const SizedBox(height: 5),
              // Progress Bar
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: LinearProgressIndicator(
                  value: 0.75,
                  backgroundColor: Colors.white24,
                  color: Colors.white,
                  minHeight: 4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildBookCard({required String title, required String subtitle, required double progress}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12), // Adds space between cards
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.brown[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.book, color: Colors.brown),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.brown),
                  minHeight: 4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCategoryCard(String category, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: const EdgeInsets.only(right: 15),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
    ),
    alignment: Alignment.center,
    child: Text(
      category,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}