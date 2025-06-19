import 'package:flutter/material.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/activities%20view/widgets/event_widget.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({super.key});

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

  // @override
  // Widget build(BuildContext context) {
  //   EvetsController evetsController = Get.put(EvetsController());
  //   return
  //   // Scaffold(
  //   //   appBar: AppBar(
  //   //     centerTitle: true,
  //   //     title: const CustomAppBarTitle(title: AppStrings.clubActivities),
  //   //     scrolledUnderElevation: 0,
  //   //     backgroundColor: AppColors.scaffoldBG,
  //   //   ),
  //   //   body:
  //   Obx(
  //     () =>
  //         evetsController.isLoading.value
  //             ? Center(
  //               child: CircularProgressIndicator(color: AppColors.primary),
  //             )
  //             : evetsController.upcommingEvents.isEmpty
  //             ? Center(child: Text('No Upcomming events'))
  //             : ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: evetsController.upcommingEvents.length,
  //               itemBuilder: (context, index) {
  //                 EventModel event = evetsController.upcommingEvents[index];
  //                 final formatter = DateFormat('MMMM, dd yyyy');
  //                 return GestureDetector(
  //                   onTap: () {
  //                     Get.to(() => EventDetailsScreen(event: event));
  //                   },
  //                   child: EventWidget(
  //                     isJoined: event.isPrticipated,
  //                     name: event.title,
  //                     clubName: event.clubName,
  //                     description: event.desc,
  //                     date: formatter.format(event.date),
  //                     day: DateFormat('EEEE').format(event.date),
  //                     time: '${event.startTime} - ${event.endTime}',
  //                     participants: event.totalParticipants,
  //                   ),
  //                 );
  //               },
  //             ),
  //   );
  // }
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
      body: Padding(
        padding: Dimensions.screenPaddingHorizontal,
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return EventWidget(event: event);
          },
        ),
      ),
    );
  }
}
