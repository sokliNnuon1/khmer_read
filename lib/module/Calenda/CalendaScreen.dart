import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCFB),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 1. App Bar
            const SliverAppBar(
              pinned: true,
              backgroundColor: Color(0xFFFDFCFB),
              surfaceTintColor: Colors.transparent,
              title: Text(
                "Reading Calendar",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),

            // 2. STICKY CALENDAR HEADER
            SliverPersistentHeader(
              pinned: true, // This keeps it at the top
              delegate: _StickyCalendarDelegate(
                child: Container(
                  color: const Color(0xFFFDFCFB),
                  child: TableCalendar(
                    // Set to week format so it stays as one row
                    calendarFormat: CalendarFormat.week, 
                    availableCalendarFormats: const {CalendarFormat.week: 'Week'},
                    headerVisible: false, // Hide header to keep it compact
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(color: Colors.teal, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ),
            ),

            // 3. SCROLLABLE LIST
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildListItem(index),
                  childCount: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.book, color: Colors.brown),
        title: Text("Reading Chapter ${index + 1}"),
        subtitle: const Text("Progress: 45%"),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

// The Delegate that handles the "Sticky" behavior
class _StickyCalendarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyCalendarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 100.0; // Height of the calendar row
  @override
  double get minExtent => 100.0; // Height stays the same when pinned

  @override
  bool shouldRebuild(covariant _StickyCalendarDelegate oldDelegate) => false;
}