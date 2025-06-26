import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/raw/theme_controller.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';
import 'package:hobby_club_app/view/activities%20view/widgets/event_widget.dart';
import 'package:intl/intl.dart';

class Event {
  final int id;
  final String name;
  final String description;
  final String date;
  final String day;
  final String time;
  final String participants;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.day,
    required this.time,
    required this.participants,
  });
}

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDate = DateTime.now();
  DateTime? _selectedDate;
  String currentView = 'Monthly'; // Changed from currentScreen to currentView
  final List<Event> _events = [
    Event(
      id: 1,
      name: "name",
      description: "description",
      date: '04-06-2025',
      day: "Wednesday",
      time: "time",
      participants: '10',
    ),
    Event(
      id: 1,
      name: "name",
      description: "description",
      date: '05-06-2025',
      day: "Thursday",
      time: "time",
      participants: '4',
    ),
    Event(
      id: 1,
      name: "name",
      description: "description",
      date: '06-06-2025',
      day: "Friday",
      time: "time",
      participants: '8',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  List<Event> _getEventsForDate(DateTime date) {
    final dateString = DateFormat('dd-MM-yyyy').format(date);
    return _events.where((event) => event.date == dateString).toList()
      ..sort((a, b) => a.time.compareTo(b.time));
  }

  String _getPeriodLabel() {
    if (currentView == 'Monthly') {
      return DateFormat('MMMM yyyy').format(_focusedDate);
    } else {
      DateTime weekStart = _focusedDate.subtract(
        Duration(days: (_focusedDate.weekday % 7)),
      );
      DateTime weekEnd = weekStart.add(const Duration(days: 6));
      return "${DateFormat('MMM d').format(weekStart)} – ${DateFormat('MMM d, yyyy').format(weekEnd)}";
    }
  }

  void _navigateNext() {
    setState(() {
      if (currentView == 'Monthly') {
        int newMonth = _focusedDate.month + 1;
        int newYear = _focusedDate.year;
        if (newMonth > 12) {
          newMonth = 1;
          newYear += 1;
        }
        _focusedDate = DateTime(newYear, newMonth, 1);
      } else {
        _focusedDate = _focusedDate.add(const Duration(days: 7));
      }
    });
  }

  void _navigatePrevious() {
    setState(() {
      if (currentView == 'Monthly') {
        int newMonth = _focusedDate.month - 1;
        int newYear = _focusedDate.year;
        if (newMonth < 1) {
          newMonth = 12;
          newYear -= 1;
        }
        _focusedDate = DateTime(newYear, newMonth, 1);
      } else {
        _focusedDate = _focusedDate.subtract(const Duration(days: 7));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find<ThemeController>();
    // final bool isDark = themeController.themeMode.value == ThemeMode.dark;
    return Obx(() {
      final isDark = themeController.themeMode.value == ThemeMode.dark;

      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: Dimensions.screenPaddingHorizontal,
            child: Column(
              children: [
                const SizedBox(height: 18),
                // Custom Tab Bar - UI remains exactly the same
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 10,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: Get.height * 0.055,
                      decoration: BoxDecoration(
                        color:
                            isDark
                                ? Colors.grey.withValues(alpha: 0.3)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color:
                                isDark
                                    ? Colors.transparent
                                    : Colors.grey.withValues(alpha: 0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                              vertical: 4,
                            ),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 300),
                              alignment:
                                  currentView == 'Monthly'
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                              child: Container(
                                width: Get.width * 0.4,
                                // height: 100,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentView = 'Monthly';
                                    });
                                  },
                                  child: Center(
                                    child: buildStatusItem(
                                      title: 'Monthly',
                                      bgColor: Colors.transparent,
                                      textColor:
                                          currentView == 'Monthly'
                                              ? Colors.white
                                              : AppColors.secondary,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentView = 'Weekly';
                                    });
                                  },
                                  child: Center(
                                    child: buildStatusItem(
                                      title: 'Weekly',
                                      bgColor: Colors.transparent,
                                      textColor:
                                          currentView == 'Weekly'
                                              ? Colors.white
                                              : AppColors.secondary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Navigation controls
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          size: 30,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        onPressed: _navigatePrevious,
                      ),
                      Text(
                        _getPeriodLabel(),
                        style: AppStyles.heading.copyWith(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),

                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          size: 30,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        onPressed: _navigateNext,
                      ),
                    ],
                  ),
                ),
                // Calendar View
                currentView == 'Monthly'
                    ? _buildMonthlyView(isDark: isDark)
                    : _buildWeeklyView(isDark: isDark),
                // Event List
                SizedBox(height: 30),
                if (_selectedDate != null) _buildEventList(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildMonthlyView({required bool isDark}) {
    DateTime firstDay = DateTime(_focusedDate.year, _focusedDate.month, 1);
    int daysToSubtract = (firstDay.weekday % 7);
    DateTime gridStart = firstDay.subtract(Duration(days: daysToSubtract));
    List<DateTime> dates = List.generate(
      42,
      (index) => gridStart.add(Duration(days: index)),
    );

    return Column(
      children: [
        _buildWeekdayHeaders(isDark: isDark),
        const SizedBox(height: 10),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: 42,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            DateTime date = dates[index];
            bool isToday =
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day;
            bool isInCurrentMonth = date.month == _focusedDate.month;
            bool hasEvents = _getEventsForDate(date).isNotEmpty;
            return DateCell(
              isDark: isDark,
              date: date,
              isToday: isToday,
              isInCurrentPeriod: isInCurrentMonth,
              hasEvents: hasEvents,
              showWeekday: false,
              onTap: () {
                setState(() {
                  _selectedDate = date;
                });
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildWeeklyView({required bool isDark}) {
    DateTime weekStart = _focusedDate.subtract(
      Duration(days: (_focusedDate.weekday % 7)),
    );
    List<DateTime> weekDates = List.generate(
      7,
      (index) => weekStart.add(Duration(days: index)),
    );

    return Column(
      children: [
        _buildWeekdayHeaders(isDark: isDark),
        Row(
          children:
              weekDates.map((date) {
                bool isToday =
                    date.year == DateTime.now().year &&
                    date.month == DateTime.now().month &&
                    date.day == DateTime.now().day;
                bool hasEvents = _getEventsForDate(date).isNotEmpty;
                return Expanded(
                  child: SizedBox(
                    // width: 50,
                    height: 50,
                    child: DateCell(
                      isDark: isDark,
                      date: date,
                      isToday: isToday,
                      isInCurrentPeriod: true,
                      hasEvents: hasEvents,
                      showWeekday: true,
                      onTap: () {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildWeekdayHeaders({required bool isDark}) {
    List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      children:
          weekdays.map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: AppStyles.body.copyWith(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildEventList() {
    final events = _getEventsForDate(_selectedDate!);
    if (events.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'No events for this date',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return SizedBox();
        // return EventWidget(
        //   event: {
        //     'date': 'Sun, Jul 14 · 2:00 PM',
        //     'title': 'Hiking Adventure',
        //     'location': 'Mountain Trail',
        //     'Participants': '700',
        //     'isParticipated': 'true',
        //     'image':
        //         'https://lh3.googleusercontent.com/aida-public/AB6AXuBarfFUfhbafijkJD1Zc3fOkIFs_MIzSnXIbh-SyTSd3g33mGxAQ5RhurAIs68pshLCPiKI7Tx1IMKTtdGLIH121CzmRENPceh1OFcynaBDfnoqHFZ8F-gWILKJKk3DwZokICvVOjfA9sNxK8CjAyYo4kItWfcyZFxgD6E2V3zHvvQKZCWt3x1drFr5I0eT5VghQ9-ybxCfJRJYJaQ5um_cIVueJ06WQ99e_zyIikltNxbmqZ7ij97mVZmRtI2cyY8SaWwxtyaBaWEJ',
        //   },
        // );
      },
    );
  }

  Widget buildStatusItem({
    required String title,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DateCell extends StatelessWidget {
  final DateTime date;
  final bool isToday;
  final bool isInCurrentPeriod;
  final bool hasEvents;
  final bool showWeekday;
  final VoidCallback onTap;
  final bool isDark;

  const DateCell({
    super.key,
    required this.date,
    required this.isToday,
    required this.isInCurrentPeriod,
    required this.hasEvents,
    required this.showWeekday,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius10),
            color:
                isToday
                    ? isDark
                        ? Colors.white
                        : Colors.black
                    : hasEvents
                    ? Colors.green
                    : isDark
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date.day.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      isToday
                          ? isDark
                              ? Colors.black
                              : Colors.white
                          : isInCurrentPeriod
                          ? Colors.white
                          : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (hasEvents)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 255, 123, 0),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
