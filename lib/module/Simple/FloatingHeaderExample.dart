import 'package:flutter/material.dart';

class FloatingHeaderExample extends StatelessWidget {
  const FloatingHeaderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                height: 50,
                child: Container(
                  color: Colors.red,
                  child: Center(child: Text('PINNED')),
                ),
              ),
            ),
            SliverPersistentHeader(
              floating: true,
              delegate: _SliverAppBarDelegate(
                height: 80,
                child: Container(
                  color: Colors.green,
                  child: Center(child: Text('FLOATING')),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 1000,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade900,
                      Colors.grey.shade500,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.height,
    required this.child,
  });

  final double height;
  final Widget child;

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return height != oldDelegate.height || child != oldDelegate.child;
  }
}