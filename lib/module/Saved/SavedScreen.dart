import 'dart:ui';
import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  bool _isGrid = true;

  final List<Map<String, String>> items = List.generate(
    12,
    (index) => {
      'title': 'Minimalist Interior ${index + 1}',
      'category': 'Architecture',
      'image': 'https://picsum.photos/seed/${index + 90}/600/800',
      'price': '\$${(index + 1) * 120}',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // Soft off-white
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Modern Transparent AppBar
          SliverAppBar(
            expandedHeight: 120.0,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(0.8),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(start: 20, bottom: 16),
              title: const Text(
                'Collection',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 24),
              ),
              background: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
            actions: [
              _buildToggleButton(),
              const SizedBox(width: 12),
            ],
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: _isGrid ? _buildSliverGrid() : _buildSliverList(),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton() {
    return GestureDetector(
      onTap: () => setState(() => _isGrid = !_isGrid),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(_isGrid ? Icons.grid_view_rounded : Icons.format_list_bulleted_rounded, 
                 size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(_isGrid ? "Grid" : "List", 
                 style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverGrid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => _ModernGridCard(item: items[index]),
        childCount: items.length,
      ),
    );
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _ModernListTile(item: items[index]),
        ),
        childCount: items.length,
      ),
    );
  }
}

class _ModernGridCard extends StatelessWidget {
  final Map<String, String> item;
  const _ModernGridCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(image: NetworkImage(item['image']!), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10)),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12, right: 12,
                  child: _GlassButton(icon: Icons.favorite, color: Colors.redAccent),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        Text(item['category']!, style: TextStyle(color: Colors.grey[500], fontSize: 13)),
      ],
    );
  }
}

class _ModernListTile extends StatelessWidget {
  final Map<String, String> item;
  const _ModernListTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
              image: DecorationImage(image: NetworkImage(item['image']!), fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['category']!.toUpperCase(), 
                       style: const TextStyle(letterSpacing: 1.2, fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                  const SizedBox(height: 4),
                  Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          ),
          const Icon(Icons.more_vert_rounded, color: Colors.grey),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _GlassButton({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white.withOpacity(0.3),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}