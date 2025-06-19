import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/events/evets_controller.dart';
import 'package:hobby_club_app/models/events_model.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/view/activities%20view/event_details_screen.dart';
import 'package:hobby_club_app/view/activities%20view/widgets/event_widget.dart';
import 'package:hobby_club_app/view/events%20view/event_details_page.dart';
import 'package:intl/intl.dart';

class EventsScreen extends StatefulWidget {
  EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> with SingleTickerProviderStateMixin{
  final List<Map<String, String>> events = [
    {
      'date': 'Fri, Jul 12 · 7:00 PM',
      'title': 'Outdoor Yoga',
      'location': 'Central Park',
      'Participants': '2000',
      'isParticipated': 'true',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCJGOq7MJKKSFRBIxvfj3uF5qZtvxpE13PUq0UMwj09cXDoHvf42-LWCFEj2Qo3VihJARI6At5D6oHfTyxjzXQW3Y9FJd3tDDLGObZ0ER05USIYGNS-sWLfO7mvfHW2u43QVzas1xn4YZKNagEGEtknT7WUEWX49a1KqmKOn94J2RXys8tm-vx3XhKknN_wcibT53b9IIEbymMWXbQHPWFEwavT10RNRyuF4PS4Ha7s0F6BttwgvjxgLI7kr78csQKHNt70Fkcq1wYP',
    },
    {
      'date': 'Sat, Jul 13 · 10:00 AM',
      'title': 'Book Club Meeting',
      'location': 'Coffee Shop',
      'Participants': '10',
      'isParticipated': 'false',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuANLjbO5AFdnkGS-pqDDtin0U2SsDHb_YnfJilIKhUH0YT-W6vEJsCm7KcD5nmXsVKKdSLxWPLGhAZLigvuGlJ779DeiCGs_SxP07mGSmIJX-Cynlj7ULMOg0Xn3kU0V_uBYPso26RODsKp9Qz23zNCcyW8OoBJjaX7Si12nzs2EXlDUljgPi7wq-h5wyknuXgotVU56CNPS2RTaFnmBHvQucrgRyhcgZfCwsngZZXwclzcwfrbugz99GeWSf66y-1MISCz_fnkiFEn',
    },
    {
      'date': 'Sun, Jul 14 · 2:00 PM',
      'title': 'Hiking Adventure',
      'location': 'Mountain Trail',
      'Participants': '700',
      'isParticipated': 'true',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBarfFUfhbafijkJD1Zc3fOkIFs_MIzSnXIbh-SyTSd3g33mGxAQ5RhurAIs68pshLCPiKI7Tx1IMKTtdGLIH121CzmRENPceh1OFcynaBDfnoqHFZ8F-gWILKJKk3DwZokICvVOjfA9sNxK8CjAyYo4kItWfcyZFxgD6E2V3zHvvQKZCWt3x1drFr5I0eT5VghQ9-ybxCfJRJYJaQ5um_cIVueJ06WQ99e_zyIikltNxbmqZ7ij97mVZmRtI2cyY8SaWwxtyaBaWEJ',
    },
  ];

  bool isMenuOpen = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2), // Start slightly below
      end: Offset(0, 0),     // End at original position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleMenu() {
    setState(() => isMenuOpen = !isMenuOpen);
    isMenuOpen ? _animationController.forward() : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Events',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return InkWell(
                onTap: () {
                  Get.to(() => EventDetailsPage());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Text Section
                      Expanded(
                        flex: 2,
                        child: Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['date'] ?? '',
                              style: TextStyle(
                                color: Color(0xFF6A7681),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              event['title'] ?? '',
                              style: TextStyle(
                                color: Color(0xFF121416),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              event['location'] ?? '',
                              style: TextStyle(
                                color: Color(0xFF6A7681),
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Participants: ${event['Participants'] ?? ''}',
                                  style: TextStyle(
                                    color: Color(0xFF6A7681),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  event['isParticipated'] == 'true'
                                      ? 'Joined'
                                      : 'Not Joined',
                                  style: TextStyle(
                                    color:
                                        event['isParticipated'] == 'true'
                                            ? Colors.green
                                            : Color(0xFF6A7681),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      // Image Section
                      Expanded(
                        flex: 1,
                        child: AspectRatio(
                          aspectRatio: 10 / 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              event['image'] ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _animationController,
                    child: Column(
                      children: [
                        FloatingActionButton.extended(
                          backgroundColor: Colors.white30,
                          heroTag: 'feed',
                          onPressed: () {
                            toggleMenu();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Create Feed tapped')),
                            );
                          },
                          icon: const Icon(Icons.create,color:Colors.black),
                          label: const Text('Create Feed',style: TextStyle(color:Colors.black),),
                        ),
                        SizedBox(height: 12),
                        FloatingActionButton.extended(
                          backgroundColor: Colors.white30,
                          heroTag: 'chat',
                          onPressed: () {
                            toggleMenu();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Chat tapped')),
                            );
                          },
                          icon: const Icon(Icons.chat,color:Colors.black),
                          label: const Text('Messenger',style: TextStyle(color:Colors.black),),
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.white30,
                  heroTag: 'main',
                  onPressed: toggleMenu,
                  child: Icon(isMenuOpen ? Icons.close : Icons.add,color:Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
