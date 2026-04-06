import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static const Color primaryPurple = Color(0xFF6C4EE3);
  static const Color backgroundLight = Color(0xFFF7F8FA);
  static const Color textDark = Color(0xFF1F1F1F);
  static const Color textGrey = Color(0xFF717171);
  static const Color starOrange = Color(0xFFFF9A02);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      bottomNavigationBar: _buildBottomActionButton(),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              _buildCustomAppBar(context),
              _buildCourseHeroSection(),
              _buildTabBarHeader(),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildLessonsList(),
              const Center(
                child: Text(
                  "No reviews yet",
                  style: TextStyle(color: textGrey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 1. App Bar
  SliverAppBar _buildCustomAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: backgroundLight,
      elevation: 0,
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: textDark),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      title: const Text(
        "Course Details",
        style: TextStyle(
          color: textDark,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      pinned: true, 
    );
  }
  SliverToBoxAdapter _buildCourseHeroSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: const DecorationImage(
                    image: NetworkImage("https://picsum.photos/id/180/800/450"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow_rounded, color: primaryPurple, size: 32),
                  ),
                ),
              ),
            ),
          ),

          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Intro to UI/UX Design in Figma",
              style: TextStyle(
                color: textDark,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                height: 1.2,
              ),
            ),
          ),

          // Instructor & Price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=lee"),
                      radius: 22,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Lee Yasmin",
                          style: TextStyle(color: textDark, fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.star, color: starOrange, size: 14),
                            SizedBox(width: 4),
                            Text("4.5", style: TextStyle(color: textGrey, fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Text(
                  "\$250",
                  style: TextStyle(color: primaryPurple, fontWeight: FontWeight.w800, fontSize: 22),
                ),
              ],
            ),
          ),

          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                _buildStatItem(Icons.timer_outlined, "1h 15m"),
                const SizedBox(width: 20),
                _buildStatItem(Icons.file_copy_outlined, "12 Lessons"),
              ],
            ),
          ),

          // Description
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
            child: Text(
              "Descriptions",
              style: TextStyle(color: textDark, fontWeight: FontWeight.w800, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(color: textGrey, fontSize: 15, height: 1.6),
                children: [
                  TextSpan(text: "UI/UX design is a process which displays a result in the form of a view that can be seen by the user. It covers... "),
                  TextSpan(
                    text: "Read More",
                    style: TextStyle(color: primaryPurple, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: textGrey, size: 18),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: textGrey, fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }

  // 3. Pinned TabBar
  SliverPersistentHeader _buildTabBarHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        TabBar(
          controller: _tabController,
          labelColor: primaryPurple,
          unselectedLabelColor: textGrey,
          indicatorColor: primaryPurple,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          tabs: const [
            Tab(text: "Lessons"),
            Tab(text: "Reviews"),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(0.03)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: primaryPurple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow_rounded, color: primaryPurple, size: 28),
            ),
            title: Text(
              "Lesson ${index + 1}: Getting Started",
              style: const TextStyle(color: textDark, fontWeight: FontWeight.w700, fontSize: 15),
            ),
            subtitle: const Text("Video • 12:40", style: TextStyle(color: textGrey, fontSize: 13)),
            trailing: const Icon(Icons.lock_outline, color: textGrey, size: 20),
          ),
        );
      },
    );
  }

  // 5. Bottom Enroll Button
  Widget _buildBottomActionButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: const BoxDecoration(
        color: backgroundLight,
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 60),
          elevation: 8,
          shadowColor: primaryPurple.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: const Text("Enroll Now", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      ),
    );
  }
}

// Delegate for the sticky TabBar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFFF7F8FA),
      alignment: Alignment.centerLeft,
      child: _tabBar,
    );
  }
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}