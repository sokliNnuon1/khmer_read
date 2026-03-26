import 'package:flutter/material.dart';

class BookReaderHome extends StatelessWidget {
  const BookReaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCFB), // Soft "book page" off-white
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "My Library",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section: Currently Reading ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Currently Reading",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 15),
            _buildCurrentBookCard(),

            const SizedBox(height: 35),

            // --- Section: For You / Recommendations ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Recommended for You",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                children: [
                  _buildBookItem("The Great Gatsby", "F. Scott Fitzgerald", Colors.teal),
                  _buildBookItem("1984", "George Orwell", Colors.redAccent),
                  _buildBookItem("Brave New World", "Aldous Huxley", Colors.blueGrey),
                ],
              ),
            ),
          ],
        ),
      ),
      // Modern Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: "Saved"),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: "Settings"),
        ],
      ),
    );
  }

  // Large Featured Card for the book you're currently reading
  Widget _buildCurrentBookCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.brown.shade400,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
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

  // Small vertical book item for horizontal lists
  Widget _buildBookItem(String title, String author, Color color) {
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
}