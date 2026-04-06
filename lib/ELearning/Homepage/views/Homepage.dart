import 'package:flutter/material.dart';
import 'package:khmer_read/ELearning/Homepage/widget/VideoWidget.dart';


// ================= CATEGORY CHIP =================
class CategoryChip extends StatelessWidget {
  final String title;
  const CategoryChip({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6),
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}

// ================= VIDEO CARD =================
class VideoCard extends StatelessWidget {
  final String title;
  final String duration;
  final Color color;

  const VideoCard({
    super.key,
    required this.title,
    required this.duration,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: const Center(
              child: Icon(Icons.play_circle_fill, color: Colors.white, size: 42),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= MAIN HOME SCREEN =================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF4A90E2),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF6A5AE0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hello 👋 Student",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Find your next skill to learn",
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search courses, videos...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Content
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  // Categories
                  SizedBox(
                    height: 48,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      children: const [
                        CategoryChip(title: "All"),
                        CategoryChip(title: "Design"),
                        CategoryChip(title: "Flutter"),
                        CategoryChip(title: "Marketing"),
                        CategoryChip(title: "Coding"),
                        CategoryChip(title: "Business"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Popular Courses
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "🎬 Popular Courses",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 195,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      children: const [
                        VideoCard(title: "Flutter Widgets Guide", duration: "12:45", color: Color(0xFF6A5AE0)),
                        VideoCard(title: "Clean UI Design", duration: "08:20", color: Color(0xFF4A90E2)),
                        VideoCard(title: "State Management", duration: "15:10", color: Color(0xFFFF6B6B)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Premium Courses
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "💰 Premium Courses",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),

                  CourseListCard(
                    title: "Full-Stack Flutter Development",
                    instructor: "John Doe",
                    thumbnailUrl: "https://img.youtube.com/vi/aqz-KE-bpKQ/0.jpg",
                    price: "\$19.99",
                    originalPrice: "\$49.99",
                    isBestSeller: true,
                  ),

                  CourseListCard(
                    title: "Mastering UI/UX in Figma",
                    instructor: "Sarah Jenkins",
                    thumbnailUrl: "https://img.youtube.com/vi/FTFaQW9AfG0/0.jpg",
                    price: "Free",
                  ),

                  CourseListCard(
                    title: "Advanced Dart & Flutter Concepts",
                    instructor: "Michael Chen",
                    thumbnailUrl: "https://picsum.photos/id/1015/800/600",
                    price: "\$29.99",
                    originalPrice: "\$79.99",
                    rating: "4.9",
                    isBestSeller: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}