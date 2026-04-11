
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

/// MODEL
class EventModel {
  final String title;
  final int status;

  EventModel({required this.title, this.status = 0});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      title: json['title'],
      status: json['status'] ?? 0,
    );
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  /// 🗂 Store events by date
  final Map<DateTime, List<EventModel>> _events = {};

  List<EventModel> _selectedEvents = [];

  /// ✅ JSON DATA (replace with API later)
  final List<Map<String, dynamic>> eventJson = [
    {
      "date": "2026-04-11",
      "title": "Meeting",
      "status": 1
    },
    {
      "date": "2026-04-11",
      "title": "Study Flutter",
      "status": 0
    },
    {
      "date": "2026-04-12",
      "title": "Project Discussion",
      "status": 0
    },
    {
      "date": "2026-04-12",
      "title": "Project Discussion",
      "status": 0
    },
    {
      "date": "2026-04-12",
      "title": "Project Discussion",
      "status": 0
    },
    {
      "date": "2026-04-12",
      "title": "Project Discussion",
      "status": 0
    },
    {
      "date": "2026-04-12",
      "title": "Project Discussion",
      "status": 0
    },
    {
      "date": "2026-04-13",
      "title": "Exam",
      "status": 1
    }
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    _loadFromJson();
    _loadEvents(_selectedDay!);
  }

  /// 📌 Normalize date (VERY IMPORTANT)
  DateTime _normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// 📥 Load JSON → Map<DateTime, List<EventModel>>
  void _loadFromJson() {
    for (var item in eventJson) {
      DateTime date = DateTime.parse(item['date']);
      DateTime normalized = _normalize(date);

      if (_events[normalized] == null) {
        _events[normalized] = [];
      }

      _events[normalized]!.add(EventModel.fromJson(item));
    }
  }

  /// 📅 Get events for calendar
  List<EventModel> _getEventsForDay(DateTime day) {
    return _events[_normalize(day)] ?? [];
  }

  /// 📋 Load selected day events
  void _loadEvents(DateTime day) {
    setState(() {
      _selectedEvents = _getEventsForDay(day);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Academic Calendar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// 📅 CALENDAR
          TableCalendar<EventModel>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,

            selectedDayPredicate: (day) =>
                isSameDay(_selectedDay, day),

            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _loadEvents(selectedDay);
            },

            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },

            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },

            eventLoader: _getEventsForDay,

            /// 🔴 MARKER
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isEmpty) return null;

                bool hasImportant =
                    events.any((e) => e.status == 1);

                return Positioned(
                  bottom: 6,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color:
                          hasImportant ? Colors.red : Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          /// 👇 SCROLLABLE LIST WITH RESPONSIVE CALENDAR
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scroll) {
                if (scroll is ScrollUpdateNotification) {
                  /// ⬇️ collapse
                  if (scroll.metrics.pixels > 20 &&
                      _calendarFormat == CalendarFormat.month) {
                    setState(() {
                      _calendarFormat = CalendarFormat.week;
                    });
                  }

                  /// ⬆️ expand
                  else if (scroll.metrics.pixels < -50 &&
                      _calendarFormat == CalendarFormat.week) {
                    setState(() {
                      _calendarFormat = CalendarFormat.month;
                    });
                  }
                }
                return true;
              },
              child: _selectedEvents.isEmpty
                  ? const Center(child: Text("No Events"))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _selectedEvents.length,
                      itemBuilder: (context, index) {
                        final event = _selectedEvents[index];

                        return ListTile(
                          leading: Icon(
                            Icons.circle,
                            size: 10,
                            color: event.status == 1
                                ? Colors.red
                                : Colors.blue,
                          ),
                          title: Text(event.title),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
