import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalendarScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "Reading Calendar",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _CalendarDelegate(
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                calendarFormat: _calendarFormat,
                onDaySelected: _onDaySelected,
                onFormatChanged: (format) => setState(() => _calendarFormat = format),
                onPageChanged: (focusedDay) => _focusedDay = focusedDay,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildItem(index),
                  childCount: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: const Icon(Icons.menu_book, color: Color(0xFF7B88FF)),
        title: Text("Reading Chapter ${index + 1}"),
        subtitle: const Text("Progress: 45%"),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _CalendarDelegate extends SliverPersistentHeaderDelegate {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final CalendarFormat calendarFormat;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;

  _CalendarDelegate({
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool isCollapsed = shrinkOffset > 100;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          if (isCollapsed)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: ClipRect(
        child: OverflowBox(
          minHeight: 0,
          maxHeight: maxExtent,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: TableCalendar(
              key: const ValueKey('calendar'),
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay,
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              calendarFormat: isCollapsed ? CalendarFormat.week : calendarFormat,
              rowHeight: 52,
              daysOfWeekHeight: 30,
              onDaySelected: onDaySelected,
              onFormatChanged: onFormatChanged,
              onPageChanged: onPageChanged,
              onHeaderTapped: (date) async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime.utc(2020, 1, 1),
                  lastDate: DateTime.utc(2030, 12, 31),
                );
                if (picked != null) onPageChanged(picked);
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(Icons.chevron_left_rounded, color: Colors.black54),
                rightChevronIcon: Icon(Icons.chevron_right_rounded, color: Colors.black54),
                titleTextStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),

              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: const Color(0xFF7B88FF),
                  shape: BoxShape.rectangle, 
                  borderRadius: BorderRadius.circular(12),
                ),

                // 2. Today
                todayDecoration: BoxDecoration(
                  color: const Color(0xFFF0F2FF),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),

                // 3. Weekends
                weekendDecoration: const BoxDecoration(
                  shape: BoxShape.rectangle, 
                ),

                // 4. Default Days
                defaultDecoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                ),

                // 5. Outside Days (dates from other months)
                outsideDecoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                ),

                // 6. Holiday/Disabled/Marker decorations
                holidayDecoration: const BoxDecoration(shape: BoxShape.rectangle),
                disabledDecoration: const BoxDecoration(shape: BoxShape.rectangle),

                todayTextStyle: const TextStyle(
                  color: Color(0xFF7B88FF),
                  fontWeight: FontWeight.bold,
                ),
                outsideDaysVisible: false,
              ),

              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 12),
                weekendStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 440; 

  @override
  double get minExtent => 180; 

  @override
  bool shouldRebuild(covariant _CalendarDelegate oldDelegate) {
    return oldDelegate.focusedDay != focusedDay || 
      oldDelegate.selectedDay != selectedDay ||
      oldDelegate.calendarFormat != calendarFormat;
  }
}