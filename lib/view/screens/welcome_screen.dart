import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/screens/club/club_details_page.dart';
import 'package:hobby_club_app/view/screens/club/joined_club_detail_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       backgroundColor: Colors.white,
  //       // appBar: AppBar(
  //       //   title: const Text('Hobby Club', style: TextStyle(color: Color(0xFF212121), fontSize: 24)),
  //       //   backgroundColor: Colors.white,
  //       //   elevation: 0,
  //       //   actions: [
  //       //     IconButton(
  //       //       icon: const Icon(Icons.search, color: Color(0xFF212121)),
  //       //       onPressed: () {
  //       //         // TODO: Implement search functionality
  //       //       },
  //       //     ),
  //       //   ],
  //       // ),
  //       body: SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(height: 50),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text(
  //                     'My Clubs',
  //                     style: TextStyle(
  //                       fontSize: 24,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   TextButton(
  //                     onPressed: () {
  //                       // TODO: Navigate to all trending clubs
  //                     },
  //                     child: const Text(
  //                       'See All',
  //                       style: TextStyle(color: Colors.black),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             // Carousel Section
  //             CarouselSlider(
  //               options: CarouselOptions(
  //                 enableInfiniteScroll: false,
  //                 height: 200.0,
  //                 // autoPlay: true,
  //                 enlargeCenterPage: false,
  //               ),
  //               items:
  //                   featuredClubs
  //                       .map(
  //                         (club) => _buildCarouselItem(
  //                           club['image'] as String,
  //                           club['title'] as String,
  //                         ),
  //                       )
  //                       .toList(),
  //             ),
  //             const SizedBox(height: 20),
  //
  //             // Categories Section
  //             const Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 16.0),
  //               child: Text(
  //                 'Categories',
  //                 style: TextStyle(
  //                   fontSize: 24,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             SizedBox(
  //               height: 100,
  //               child: ListView(
  //                 scrollDirection: Axis.horizontal,
  //                 children:
  //                     categories
  //                         .map(
  //                           (cat) => _buildCategoryCard(
  //                             cat['title'] as String,
  //                             cat['icon'] as IconData,
  //                           ),
  //                         )
  //                         .toList(),
  //               ),
  //             ),
  //             const SizedBox(height: 20),
  //
  //             // Trending Clubs Section
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text(
  //                     'Trending Clubs',
  //                     style: TextStyle(
  //                       fontSize: 24,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   TextButton(
  //                     onPressed: () {
  //                       // TODO: Navigate to all trending clubs
  //                     },
  //                     child: const Text(
  //                       'See All',
  //                       style: TextStyle(color: Colors.black),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             SizedBox(
  //               height: 250,
  //               child: ListView(
  //                 scrollDirection: Axis.horizontal,
  //                 children:
  //                     trendingClubs
  //                         .map(
  //                           (club) => SizedBox(
  //                             width: 200,
  //                             child: ClubCard(
  //                               imageUrl: club['image'] as String,
  //                               title: club['title'] as String,
  //                               members: club['members'] as int,
  //                               onTap: () {
  //                                 // TODO: Navigate to club details
  //                               },
  //                             ),
  //                           ),
  //                         )
  //                         .toList(),
  //               ),
  //             ),
  //             const SizedBox(height: 20),
  //
  //             // Explore Section
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text(
  //                     'Explore',
  //                     style: TextStyle(
  //                       fontSize: 24,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   TextButton(
  //                     onPressed: () {
  //                       // TODO: Navigate to explore page
  //                     },
  //                     child: const Text(
  //                       'See All',
  //                       style: TextStyle(color: Colors.black),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             GridView.count(
  //               crossAxisCount: 2,
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //               children:
  //                   exploreClubs
  //                       .map(
  //                         (club) => ClubCard(
  //                           imageUrl: club['image'] as String,
  //                           title: club['title'] as String,
  //                           members: club['members'] as int,
  //                           onTap: () {
  //                             // TODO: Navigate to club details
  //                           },
  //                         ),
  //                       )
  //                       .toList(),
  //             ),
  //           ],
  //         ),
  //       ),
  //       // bottomNavigationBar: BottomNavigationBar(
  //       //   items: const [
  //       //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  //       //     BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
  //       //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  //       //   ],
  //       //   selectedItemColor: const Colors.black,
  //       //   unselectedItemColor: const Color(0xFF64B5F6),
  //       // ),
  //       floatingActionButton: FloatingActionButton(
  //         onPressed: () {
  //           // TODO: Navigate to join new club screen
  //         },
  //         backgroundColor: Colors.black,
  //         child: const Icon(Icons.add),
  //       ),
  //     );
  //   }
  //
  //   // Helper method to build carousel items
  //
  //   Widget _buildCarouselItem(
  //     String imageUrl,
  //     String title, {
  //     int totalMembers = 120,
  //     int totalEvents = 5,
  //     int newMessages = 3,
  //   }) {
  //     return Container(
  //       margin: const EdgeInsets.all(5.0),
  //       child: ClipRRect(
  //         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  //         child: Stack(
  //           children: [
  //             Column(
  //               children: [
  //                 Image.asset(
  //                   AppImages.dummyimage,
  //                   width: double.infinity,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ],
  //             ),
  //             // ✨ Only blur this specific area
  //             Positioned(
  //               bottom: 0,
  //               left: 0,
  //               right: 0,
  //               child: ClipRRect(
  //                 borderRadius: const BorderRadius.only(
  //                   bottomLeft: Radius.circular(10),
  //                   bottomRight: Radius.circular(10),
  //                 ),
  //                 child: BackdropFilter(
  //                   filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
  //                   child: Container(
  //                     padding: const EdgeInsets.symmetric(
  //                       vertical: 12,
  //                       horizontal: 16,
  //                     ),
  //                     color: Colors.black.withOpacity(0.3),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           title,
  //                           style: const TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 18.0,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         const SizedBox(height: 8),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             _infoIcon(
  //                               Icons.group,
  //                               "$totalMembers",
  //                               Colors.cyan,
  //                             ),
  //                             _infoIcon(
  //                               Icons.event,
  //                               "$totalEvents",
  //                               Colors.purple,
  //                             ),
  //                             _infoIcon(
  //                               Icons.message,
  //                               "$newMessages",
  //                               Colors.orange,
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  //
  //   // Reusable icon-text widget
  //   Widget _infoIcon(IconData icon, String label, Color color) {
  //     return Row(
  //       children: [
  //         Icon(icon, size: 18, color: color),
  //         const SizedBox(width: 4),
  //         Text(label, style: TextStyle(color: Colors.white, fontSize: 14)),
  //       ],
  //     );
  //   }
  //
  //   // Helper method to build category cards
  //   Widget _buildCategoryCard(String title, IconData icon) {
  //     return Container(
  //       width: 70,
  //       height: 70,
  //       margin: const EdgeInsets.symmetric(horizontal: 10),
  //       decoration: BoxDecoration(
  //         color: Colors.black,
  //         shape: BoxShape.circle,
  //         border: Border.all(color: AppColors.primary),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(icon, size: 20, color: Colors.white),
  //             const SizedBox(height: 10),
  //             Text(
  //               title,
  //               style: const TextStyle(fontSize: 16, color: Colors.white),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }
  //
  // // Club Card Widget
  // class ClubCard extends StatelessWidget {
  //   final String imageUrl;
  //   final String title;
  //   final int members;
  //   final VoidCallback onTap;
  //
  //   const ClubCard({
  //     super.key,
  //     required this.imageUrl,
  //     required this.title,
  //     required this.members,
  //     required this.onTap,
  //   });
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return GestureDetector(
  //       onTap: onTap,
  //       child: Container(
  //         margin: const EdgeInsets.all(10),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(10),
  //               child: Image.network(
  //                 imageUrl,
  //                 height: 120,
  //                 width: double.infinity,
  //                 fit: BoxFit.cover,
  //                 errorBuilder: (context, error, stackTrace) {
  //                   return Container(
  //                     height: 120,
  //                     width: double.infinity,
  //                     color: Colors.grey.shade300,
  //                     alignment: Alignment.center,
  //                     child: const Icon(
  //                       Icons.broken_image,
  //                       size: 40,
  //                       color: Colors.grey,
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             Text(
  //               title,
  //               style: const TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //                 color: Color(0xFF212121),
  //               ),
  //             ),
  //             const SizedBox(height: 5),
  //             Text(
  //               '$members members',
  //               style: const TextStyle(fontSize: 14, color: Color(0xFF64B5F6)),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }
  //
  // // Dummy data
  // const List<Map<String, dynamic>> featuredClubs = [
  //   {'image': 'https://via.placeholder.com/1000x200', 'title': 'Featured Club 1'},
  //   {'image': 'https://via.placeholder.com/1000x200', 'title': 'Featured Club 2'},
  //   {'image': 'https://via.placeholder.com/1000x200', 'title': 'Featured Club 3'},
  // ];
  //
  // const List<Map<String, dynamic>> categories = [
  //   {'title': 'Sports', 'icon': Icons.sports_soccer},
  //   {'title': 'Arts', 'icon': Icons.brush},
  //   {'title': 'Tech', 'icon': Icons.computer},
  //   {'title': 'Music', 'icon': Icons.music_note},
  // ];
  //
  // const List<Map<String, dynamic>> trendingClubs = [
  //   {
  //     'image': 'https://via.placeholder.com/200x120',
  //     'title': 'Club One',
  //     'members': 150,
  //   },
  //   {
  //     'image': 'https://via.placeholder.com/200x120',
  //     'title': 'Club Two',
  //     'members': 200,
  //   },
  //   {
  //     'image': 'https://via.placeholder.com/200x120',
  //     'title': 'Club Three',
  //     'members': 180,
  //   },
  // ];
  //
  // const List<Map<String, dynamic>> exploreClubs = [
  //   {
  //     'image': 'https://via.placeholder.com/200x120',
  //     'title': 'Explore Club 1',
  //     'members': 100,
  //   },
  //   {
  //     'image': 'https://via.placeholder.com/200x120',
  //     'title': 'Explore Club 2',
  //     'members': 120,
  //   },
  //   {
  //     'image': 'https://via.placeholder.com/200x120',
  //     'title': 'Explore Club 3',
  //     'members': 90,
  //   },
  //   {
  //     'image': 'https://via.placeholder.com/200x120',
  //     'title': 'Explore Club 4',
  //     'members': 110,
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    final trendingClubs = [
      {
        'title': 'Photography Club',
        'members': '120 members · 2 events',
        'image': 'assets/photo_club.png',
      },
      {
        'title': 'Book Club',
        'members': '85 members · 1 event',
        'image': 'assets/book_club_new.png',
      },
      {
        'title': 'Reading Club',
        'members': '150 members · 3 events',
        'image': 'assets/book_club.png',
      },
    ];

    final exploreCategories = [
      {'title': 'Photography', 'icon': 'assets/icons/photography.png'},
      {'title': 'Reading', 'icon': 'assets/icons/reading.png'},
      {'title': 'Hiking', 'icon': 'assets/icons/hiking.png'},
      {'title': 'art', 'icon': 'assets/icons/art.png'},
      {'title': 'social', 'icon': 'assets/icons/social.png'},
      {'title': 'music', 'icon': 'assets/icons/music.png'},
    ];

    final List<Map<String, String>> clubs = [
      {
        'category': 'Photography Club',
        'title': 'Photo Walk',
        'description': 'Join us for a photo walk in Central Park',
        'image': 'assets/photo_club_new.jpg',
        'members': '120',
        'events': '5',
      },
      {
        'category': 'Book Club',
        'title': 'Book Discussion',
        'description': 'Discuss the latest bestseller',
        'image': 'assets/book_club.png',
        'members': '12000',
        'events': '20',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('Clubs', style: Theme.of(context).textTheme.displayLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text(
                  'Trending Clubs',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingClubs.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final club = trendingClubs[index];
                    return SizedBox(
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                club['image']!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[800],
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            club['title']!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            club['members']!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF9daebe),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Explore Clubs',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      'Visit All',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: exploreCategories.length,
                    itemBuilder: (context, index) {
                      final cat = exploreCategories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          spacing: 5,
                          children: [
                            Image.asset('${cat['icon']}',width: 40),
                            const SizedBox(width: 10),
                            Text(
                              '${cat['title']}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'My Clubs',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: clubs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final club = clubs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  club['category']!,
                                  style: const TextStyle(
                                    color: Color(0xFF5C748A),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  club['title']!,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  club['description']!,
                                  style: const TextStyle(
                                    color: Color(0xFF5C748A),
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Members: ${club['members']!}',
                                      style: const TextStyle(
                                        color: Color(0xFF5C748A),
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Events: ${club['events']!}',
                                      style: const TextStyle(
                                        color: Color(0xFF5C748A),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: AspectRatio(
                              aspectRatio: 10 / 9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  club['image']!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[800],
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
