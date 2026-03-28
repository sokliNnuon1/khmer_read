import 'package:flutter/material.dart';
import 'package:khmer_read/module/Homescreen/Homescreen_widget.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCFB),

      body: CustomScrollView(
        slivers: [
          // ✅ SLIVER APP BAR (modern style)
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            backgroundColor: const Color(0xFFFDFCFB),
            elevation: 0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                "My Library",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              titlePadding: EdgeInsets.only(left: 20, bottom: 16),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Currently Reading",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 15),
                  buildCurrentBookCard(),

                  const SizedBox(height: 35),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Categories",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20),
                      children: [
                        buildCategoryCard("Fiction", Colors.brown),
                        buildCategoryCard("Non-Fiction", Colors.deepOrange),
                        buildCategoryCard("Sci-Fi", Colors.teal),
                        buildCategoryCard("Fantasy", Colors.purple),
                        buildCategoryCard("Biography", Colors.indigo),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // 📚 Authors (NEW SECTION - "auth list")
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Popular Authors",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 25),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Recommended for You",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    height: 240,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20),
                      children: [
                        buildBookItem(
                          "The Great Gatsby",
                          "F. Scott Fitzgerald",
                          const Color.fromRGBO(0, 150, 136, 1),
                        ),
                        buildBookItem(
                            "1984", "George Orwell", Colors.redAccent),
                        buildBookItem("Brave New World", "Aldous Huxley",
                            Colors.blueGrey),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Continue Reading",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        buildBookCard(
                          title: "The Great Gatsby",
                          subtitle: "You are at Chapter 4",
                          progress: 0.4,
                        ),
                        buildBookCard(
                          title: "1984",
                          subtitle: "Almost finished!",
                          progress: 0.9,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}