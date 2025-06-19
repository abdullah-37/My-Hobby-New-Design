import 'package:flutter/material.dart';
import 'package:hobby_club_app/view/chat%20view/chat_screen.dart';

class ClubDetailsPage extends StatelessWidget {
  const ClubDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = const Color(0xFF111518);
    final secondaryTextColor = const Color(0xFF60768a);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: CustomAppBarTitle(title: 'Club Details')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            //   child: Row(
            //     children: [
            //       InkWell(
            //         onTap: () => Get.close(1),
            //         child: const Icon(
            //           Icons.arrow_back,
            //           color: Color(0xFF111518),
            //         ),
            //       ),
            //       const SizedBox(width: 8),
            //       Expanded(
            //         child: Center(
            //           child: Text(
            //             'Club Details',
            //             style: TextStyle(
            //               color: textColor,
            //               fontSize: 18,
            //               fontWeight: FontWeight.bold,
            //               letterSpacing: -0.015,
            //             ),
            //           ),
            //         ),
            //       ),
            //       const SizedBox(width: 24), // To balance the back button space
            //     ],
            //   ),
            // ),

            // Cover Image
            Container(
              height: 218,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAa6qHrduK_83-nldlOFWp7ZEJoHbECNsDoF-pU2BoJMsSwtyMQhdRO-dFspdQHK8N-5Mke0FaA2cGDiUo03d6ANsO0M_8D-7wS6QPImP7YfpXPDoBJVpyL3Z6-u31LKwqEXpH73pRKf3ctqrd2hA3r9DPK5Co86NPvj4-eGDw45GR6w3VcwL8G2FgVkbOUz-CwVzgc4NqoXkp9IC74XuPDht-y1CP2d9jNDzO7lhjfk_N_KKiQE_oynqBtn3uf0AdtcLOUdOIhEr62',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Club Name & Description
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Photography Enthusiasts',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  letterSpacing: -0.015,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(
                'A community for photography lovers to share their work, learn new techniques, and connect with fellow enthusiasts.',
                style: TextStyle(fontSize: 16, color: textColor, height: 1.5),
              ),
            ),

            // Member Count
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.group, color: Color(0xFF111518)),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '125 members',
                    style: TextStyle(fontSize: 16, color: textColor),
                  ),
                ],
              ),
            ),

            // Upcoming Events
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Upcoming Events',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  letterSpacing: -0.015,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _eventCard(
                    title: 'Photography Workshop',
                    subtitle: 'Learn advanced techniques',
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuB0of5WjDNopd9IHtcLLzz6_Piitszdlz9rP7v60lrTNfWwlc6cEXIVI_VmFlyQ8OfY0sfAtMvBJRY7vhGqKAkQtUYIkPHXUh8pnF5lcNT2S985IEJ7PuVF1jUKhTE09dqDnAg0PgNKmozjsTOg3GVc9tz483Vp_Ysr-NP2F5rpA6dmVMBiH-kveVE2e0Rfak_NQkeKfdOpoumhB2Q8RxcartNIEyi9Ubdqes7xDp2k2LJRq7pln1Rj3T5VYV4pOCw9Ux4dQlu_9PAk',
                  ),
                  const SizedBox(width: 12),
                  _eventCard(
                    title: 'Photo Walk',
                    subtitle: 'Explore city\'s hidden gems',
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuADwPMLnjDQoHaeflMfxpDvSV1hUYxmTcoELxjPF34XVVN6-I9GjPc-kk60zdyfrTWmmr0VqCv85bEzPmEH6uRdnEJzsEff9wknyuv1jbuCRa_rDTgAsoGw-xGHzl_sktSiN97lMvbisMky4u8btqG2bqta5YZrS7gpJexqRXNSSkjxFSvruF_I85dAPh3QnHzZ5O2pOM774DFzRlwU7CgJM6gBn2w6sbAO8kF8A8lwot-cpnKdsLQUpu4PUujOyxesvZSRkhqGkgsu',
                  ),
                ],
              ),
            ),

            // Recent Activities
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Recent Activities',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  letterSpacing: -0.015,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _activityItem(
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCLzC3Ny3fdcvvc1-cAnQdUTWZcl7vFVqg-2HLawQDGV8W7oSDXlTrHzvUl6LmJDPUecFXCNUODh0yeJggNhOn1PIiaQrBHUld4VbPEkU5bbV-fPdPOg_EYkspUP5fht2gweuPkZb9cszFpvdnlE-LoTZZcjesRYWP8oClI09H1MIfgzvA2Jjuptgakvuz84gZBJR2zsIyvcuQHrenAT3xm6V8GU4l-Ecch1SSMtkwzgFgQa9CWv5aNJsfr4wzA5b8sYjUWoZw7jJE_',
                    name: 'Liam Carter posted a photo',
                    comment: 'Beautiful shot!',
                    time: '2 hours ago',
                  ),
                  const SizedBox(height: 16),
                  _photoPost(
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBtPcRIJrcAnzTc_1pK7kcijMRyS19VMMWnBEFZLRVFdNIg4ZUy155mUtQXf1UeTCDzeq74JBNltHEqnLsAMKu_FlNs3-dOaBV2TGlmFM2KLe7P2RVJqqQMphN6-YUKP50lXH19NJfN1Tb_2JjG-YY5pIj-D7uuz0joUZ6ZimaQup0Vu0Vq6GbQ4ug3AR7P1ERJz-5trGOJ0QKawZ2wKN1y7faDCV53_UAoGuUKWvfQcWwqUeou2q4ui9t7fksTFzNcICBRNDt3zzP8',
                  ),
                  const SizedBox(height: 8),
                  _actionButtons(likes: 18, comments: 3),
                ],
              ),
            ),

            // Member Testimonials
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Member Testimonials',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    letterSpacing: -0.015,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _testimonialCard(
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCI511Z7iUNM3p4Sc9k9vgXdZ5EOZyOZP3kn0uxx0d8Xm4bLl0pz2l0IBBNUiq1S_eZa7sOBTf4XSlGmGdzhxOLWS3UQExBan4Oiz7023XIO7qDYZu42JKXQRz370r8IfQcKQktJVhFLMQgtBupKBBcc0ABC-otvmWU3gUp6q83ijIt2F-CoEZPMbw2I3jfBv5nJOjpOkaMJPhoOq2gaC-dphkLGeTHIQjj7jBHk3GW2I-NR-7J_8XqOmN28dEyHye4PpoM4OblD5qE',
                    name: 'Sophia Clark',
                    text:
                        '"This club has helped me grow so much as a photographer. The community is supportive and inspiring."',
                  ),
                  const SizedBox(width: 16),
                  _testimonialCard(
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDG7n5y52vJ4vWRSnZ4YGG3oacgD6DCfAN2Mwb0tQ9F1OYxg1wyu_-0eG2RJ-JP5d5pSqapVTky3h7Treh-zVqObH4AMja6bdt2nj6l0znYphMB1SDdMDZU2Mk0mxxiSu7h-gX460hHVWI13aheA0jsTgFR8QTd9jTvOtlWV__qWjIYmCRcOtp__TJ-M_MLR8OpG_rwoqTvLk4iDg3raMkl8z5GVKTlRQwmeqVNCOZZIzhU6WlerZpPXyjfwc-6ReXLFrAkCqi4rcCw',
                    name: 'Ethan Bennett',
                    text:
                        '"I\'ve met some great people and learned a lot from the workshops and events."',
                  ),
                ],
              ),
            ),

            // Admins
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Admins',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  letterSpacing: -0.015,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _adminCard(
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBW884QPnTlvimEECGfb_q6E2HRXnJlIPnWQY9uoBSQibTgnoaVsUaEWtrQM3orfWQ5vE-T78Z0YrBOjxYUT3laD_hevOMY-GbOKFzF-OJhcl4XnfogRbqC9MxqSBGaICWhG4vv1Tapu7ReKZ8wupAbKSiiwvaSv57qopkUpm0bT4YLzZS3R5RnnUzHceyb3dPyxC3PyHv-YG0CEnjZcjh4mX9yI44pl3C3HKYsqtfPcLb3FNU-_rd3IDEIfEhlZ81uhP9GiFMuBOrb',
                name: 'Ava Harper',
                role: 'Admin',
              ),
            ),

            // Join Club Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B80EE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    // Handle join action
                  },
                  child: const Text(
                    'Join Club',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventCard({
    required String title,
    required String subtitle,
    required String imageUrl,
  }) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF111518),
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Color(0xFF60768a)),
          ),
        ],
      ),
    );
  }

  Widget _activityItem({
    required String imageUrl,
    required String name,
    required String comment,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF111518),
                ),
              ),
              Text(
                comment,
                style: TextStyle(fontSize: 14, color: Color(0xFF60768a)),
              ),
              Text(
                time,
                style: const TextStyle(fontSize: 14, color: Color(0xFF60768a)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _photoPost({required String imageUrl}) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _articlePost({
    required String title,
    required String headline,
    required String description,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF60768a),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  headline,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111518),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF60768a),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButtons({required int likes, required int comments}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.favorite_border,
              color: Color(0xFF60768a),
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              likes.toString(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF60768a),
                letterSpacing: 0.015,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.chat_bubble_outline,
              color: Color(0xFF60768a),
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              comments.toString(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF60768a),
                letterSpacing: 0.015,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _testimonialCard({
    required String imageUrl,
    required String name,
    required String text,
  }) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF111518),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color(0xFF60768a)),
          ),
        ],
      ),
    );
  }

  Widget _adminCard({
    required String imageUrl,
    required String name,
    required String role,
  }) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF111518),
              ),
            ),
            Text(
              role,
              style: const TextStyle(fontSize: 14, color: Color(0xFF60768a)),
            ),
          ],
        ),
      ],
    );
  }
}
