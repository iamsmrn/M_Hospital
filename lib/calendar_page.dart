import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String id;
  final String title;
  final String time;
  final String description;
  final Color color;

  Event({
    String? id,
    required this.title,
    required this.time,
    required this.description,
    required this.color,
  }) : id = id ?? DateTime.now().toString();
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> _events = {};

  final List<Color> _eventColors = [
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.pink,
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // Add sample events
    _events = {
      DateTime.now(): [
        Event(
          title: 'Medical Checkup',
          time: '06:00 PM',
          description: 'Blood Donation and Medical checkup',
          color: Colors.blue,
        ),
      ],
    };
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _addEvent(Event event) {
    setState(() {
      if (_events[_selectedDay!] != null) {
        _events[_selectedDay!]!.add(event);
      } else {
        _events[_selectedDay!] = [event];
      }
    });
  }

  void _editEvent(Event oldEvent, Event newEvent) {
    setState(() {
      final events = _events[_selectedDay!];
      final index = events!.indexWhere((e) => e.id == oldEvent.id);
      events[index] = newEvent;
    });
  }

  void _deleteEvent(Event event) {
    setState(() {
      _events[_selectedDay!]!.removeWhere((e) => e.id == event.id);
      if (_events[_selectedDay!]!.isEmpty) {
        _events.remove(_selectedDay!);
      }
    });
  }

  void _showEventDialog({Event? event}) {
    final isEditing = event != null;
    final titleController = TextEditingController(text: event?.title ?? '');
    final timeController = TextEditingController(text: event?.time ?? '');
    final descriptionController = TextEditingController(text: event?.description ?? '');
    Color selectedColor = event?.color ?? _eventColors[0];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Edit Event' : 'Add Event'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Time (e.g., 06:00 PM)',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: _eventColors.map((color) {
                  return GestureDetector(
                    onTap: () {
                      selectedColor = color;
                      (context as Element).markNeedsBuild();
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: color == selectedColor
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          if (isEditing)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteEvent(event);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && timeController.text.isNotEmpty) {
                final newEvent = Event(
                  id: event?.id, // Reuse ID if editing
                  title: titleController.text,
                  time: timeController.text,
                  description: descriptionController.text,
                  color: selectedColor,
                );

                if (isEditing) {
                  _editEvent(event, newEvent);
                } else {
                  _addEvent(newEvent);
                }
                Navigator.pop(context);
              }
            },
            child: Text(isEditing ? 'Save' : 'Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_focusedDay.year}/${_focusedDay.month.toString().padLeft(2, '0')}/${_focusedDay.day.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: _getEventsForDay,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Color(0xFF00B894),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color(0xFF6C5CE7),
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Color(0xFF6C5CE7),
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Today's plan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _showEventDialog(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _getEventsForDay(_selectedDay!).length,
                      itemBuilder: (context, index) {
                        final event = _getEventsForDay(_selectedDay!)[index];
                        return GestureDetector(
                          onTap: () => _showEventDialog(event: event),
                          child: _buildEventCard(event),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Event event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: event.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: event.color.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.time,
            style: TextStyle(
              color: event.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            event.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            event.description,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}