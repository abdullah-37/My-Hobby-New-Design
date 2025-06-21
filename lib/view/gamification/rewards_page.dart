import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> rewards = [
      {
        'title': 'Gift Card',
        'description': 'Redeem for a \$25 gift card to your favorite store.',
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBPPrMb-78KAMy70Of0KRkaTsAdAiLw0R1H7jh2CMT1eorPrhmehGJLgqjOvA2mgklwERaaHWwm0FkpQEdMLcPjJaw0GR14EiELICFENpNR0wN0LmcN8t4PSFlCKRNLYH_8Rfqd9lWesygxw-K4s33mcJezJ0eO1_8bJYu5kYG8vNLWblx9lP8J_gIKzvPZbxr7f0Q43Inage5q5lJ41dDDeGC_ljwjsl3xbF6Me71RFzz4pQ_xYZe-RpEB5HYNL9ZMVkCKdzlXmKna',
        'points': '1800',
      },
      {
        'title': 'Recognition Certificate',
        'description': 'Receive a certificate recognizing your contributions.',
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDlzP0aSQWoqhdCROFSPtJe31DMcLM9PlzSKp4NIupdPughYq4liIbk9OxArGBceggHTXwYgX9LnaY5tla4smxnKoRj6JBVIXgLiY0lpc0SrF1R7RkbNv2Ckb6gYrR7WB73_Z57nDFPzinrIPs7bhd0ojQZl9Y65R_Mqsdj_fMpkT7tjiQgOdTc-izA7l-7CglCY0pvTm4N5jEAkHtU9zm85WU1zeRZ1BGbIZWmOQhRGfw3Rthx2HwcqEz2PcLBhrM30fQadhBAdb9N',
        'points': '12000',
      },
      {
        'title': 'Extra Break Time',
        'description': 'Enjoy an additional 15 minutes of break time.',
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBxvlj5rr9kDwfjH8TRIBOGrPZNefYkoL14HlPumt_L6ucsuMHRFlQkCsfipx-fI9IUW8f50BMDkDDX33XSi5fEwEOWf5wLo6mAMq8lAzZp0ird_J-1FxKkNvheoLOv-okv6U5NW5Tcnz0kK8AJxlYrxc8qCaitffLI91fRfoBGtq9N4xEHlGXObfm5OsKP_kxEyk65F8-TlKJyvkEgLq-pK41QPTZQWQWUT3b5kXarINWi-iCK-BnWxs7Ru2qem2yVekQ8xF2ktCGu',
        'points': '50',
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(title: 'Rewards',centerTitle: true,isLeading: true,),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Available Rewards',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              itemCount: rewards.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final reward = rewards[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reward['title']!,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              reward['description']!,
                              style: const TextStyle(
                                color: Color(0xFF5C748A),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE7EFF3),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Center(
                                child: Text(
                                  '${reward['points']!} points',
                                  style: const TextStyle(
                                    color: Color(0xFF0E171B),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
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
                            child: Image.network(
                              reward['image']!,
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
    );
  }
}
