import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedCategory = "All";
  final List<String> categories = ["All", "Digital Art", "Architecture", "Photography", "UI Design"];

  final List<Map<String, dynamic>> searchData = [
    {
      'title': 'Minimalist Abstract',
      'author': 'Alex Rivers',
      'category': 'Digital Art',
      'rating': 4.8,
      'image': 'https://picsum.photos/seed/61/400/500',
    },
    {
      'title': 'Concrete Jungle',
      'author': 'Sara Chen',
      'category': 'Architecture',
      'rating': 4.5,
      'image': 'https://picsum.photos/seed/65/400/500',
    },
    {
      'title': 'Golden Hour',
      'author': 'Marcus Vane',
      'category': 'Photography',
      'rating': 4.9,
      'image': 'https://picsum.photos/seed/99/400/500',
    },
    {
      'title': 'Minimalist Abstract',
      'author': 'Alex Rivers',
      'category': 'Digital Art',
      'rating': 4.8,
      'image': 'https://picsum.photos/seed/61/400/500',
    },
    {
      'title': 'Concrete Jungle',
      'author': 'Sara Chen',
      'category': 'Architecture',
      'rating': 4.5,
      'image': 'https://picsum.photos/seed/65/400/500',
    },
    {
      'title': 'Golden Hour',
      'author': 'Marcus Vane',
      'category': 'Photography',
      'rating': 4.9,
      'image': 'https://picsum.photos/seed/99/400/500',
    },
    {
      'title': 'Minimalist Abstract',
      'author': 'Alex Rivers',
      'category': 'Digital Art',
      'rating': 4.8,
      'image': 'https://picsum.photos/seed/61/400/500',
    },
    {
      'title': 'Concrete Jungle',
      'author': 'Sara Chen',
      'category': 'Architecture',
      'rating': 4.5,
      'image': 'https://picsum.photos/seed/65/400/500',
    },
    {
      'title': 'Golden Hour',
      'author': 'Marcus Vane',
      'category': 'Photography',
      'rating': 4.9,
      'image': 'https://picsum.photos/seed/99/400/500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredData = selectedCategory == "All"
        ? searchData
        : searchData.where((item) => item['category'] == selectedCategory).toList();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 160, // Increased height to fit search + categories
            floating: true,
            pinned: true,
            elevation: 0,
            stretch: true,
            backgroundColor: const Color(0xFFF8F9FD),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.blurBackground],
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 70), // Space for the 'bottom' widget
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: _buildCategoryRow(),
            ),
          ),

          // 🔷 Results List
          filteredData.isEmpty 
          ? const SliverFillRemaining(
              child: Center(child: Text("No items found in this category")),
            )
          : SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildResultCard(filteredData[index]),
                  childCount: filteredData.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: const TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search, color: Color(0xFF00519C)),
            hintText: "Explore amazing creations...",
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow() {
    return Container(
      height: 70,
      color: const Color(0xFFF8F9FD), // Matches background
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = categories[index]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF00519C) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected 
                  ? [BoxShadow(color: const Color(0xFF00519C).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] 
                  : [],
              ),
              alignment: Alignment.center,
              child: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(item['image'], width: 100, height: 100, fit: BoxFit.cover),
              ),
              Positioned(
                top: 8, left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(8)),
                  child: Text(item['category'], style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(item['author'], style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(item['rating'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.amber)),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xFF00519C)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}