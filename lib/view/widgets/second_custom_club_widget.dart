import 'package:flutter/material.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';

import 'custom_network_image.dart';

/// Detailed club card with rich snapshot info
class CustomClubCard2 extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String subtitle;
  final String status;
  final int eventsCount;
  final int membersCount;
  final String description;
  final String nextMeeting;
  final String frequency;
  final String location;
  final List<String> tags;
  final String fee;
  final String membershipType;
  final double averageRating;
  final int reviewCount;
  final List<String> upcomingEvents;
  final String lastActive;
  final int totalPosts;
  final String organizerName;
  final String organizerAvatarUrl;
  final String contactInfo;
  final String websiteUrl;
  final List<String> galleryImages;
  final double progress;
  final List<String> achievements;
  final VoidCallback? onTap;

  const CustomClubCard2({
    super.key,
    this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.eventsCount,
    required this.membersCount,
    required this.description,
    required this.nextMeeting,
    required this.frequency,
    required this.location,
    required this.tags,
    required this.fee,
    required this.membershipType,
    required this.averageRating,
    required this.reviewCount,
    required this.upcomingEvents,
    required this.lastActive,
    required this.totalPosts,
    required this.organizerName,
    required this.organizerAvatarUrl,
    required this.contactInfo,
    required this.websiteUrl,
    required this.galleryImages,
    required this.progress,
    required this.achievements,
    this.onTap,
  });

  Color _statusColor() {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'inactive':
        return Colors.grey;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.cardRadius),
        ),
        child: Padding(
          padding: Dimensions.cardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  ClipOval(
                    child: CustomNetworkImage(
                      size: Dimensions.width60,
                      imageUrl: imageUrl ?? '',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppStyles.cardTitle.copyWith(
                            fontSize: Dimensions.font18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: AppStyles.body.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: Text(
                      status,
                      style: AppStyles.body.copyWith(color: Colors.white),
                    ),
                    backgroundColor: _statusColor(),
                  ),
                ],
              ),

              SizedBox(height: Dimensions.height10),

              // Description
              Text(
                description,
                style: AppStyles.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: Dimensions.height10),

              // Tags
              Wrap(
                spacing: 6,
                children:
                    tags
                        .map((t) => Chip(label: Text(t, style: AppStyles.body)))
                        .toList(),
              ),

              SizedBox(height: Dimensions.height10),

              // Meeting info
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 15),
                  SizedBox(width: 4),
                  Text(nextMeeting, style: AppStyles.body),
                  SizedBox(width: 12),
                  Icon(Icons.schedule, size: 15),
                  SizedBox(width: 4),
                  Text(frequency, style: AppStyles.body),
                ],
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.location_on, size: 15),
                  SizedBox(width: 4),
                  Expanded(child: Text(location, style: AppStyles.body)),
                ],
              ),

              SizedBox(height: Dimensions.height10),

              // Membership details
              Row(
                children: [
                  Icon(Icons.attach_money, size: 15),
                  SizedBox(width: 4),
                  Text(fee, style: AppStyles.body),
                  SizedBox(width: 12),
                  Icon(Icons.lock, size: 15),
                  SizedBox(width: 4),
                  Text(membershipType, style: AppStyles.body),
                ],
              ),

              SizedBox(height: Dimensions.height10),

              // Rating & reviews
              Row(
                children: [
                  Icon(Icons.star, size: 15),
                  SizedBox(width: 4),
                  Text(averageRating.toStringAsFixed(1), style: AppStyles.body),
                  SizedBox(width: 8),
                  Text('($reviewCount reviews)', style: AppStyles.body),
                ],
              ),

              SizedBox(height: Dimensions.height10),

              // Upcoming events
              if (upcomingEvents.isNotEmpty) ...[
                Text('Upcoming Events', style: AppStyles.greysubtitle),
                ...upcomingEvents
                    .take(2)
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.only(left: 8, top: 4),
                        child: Text('• $e', style: AppStyles.body),
                      ),
                    ),
                SizedBox(height: Dimensions.height10),
              ],

              // Recent activity
              Row(
                children: [
                  Icon(Icons.access_time, size: 15),
                  SizedBox(width: 4),
                  Text('Last active $lastActive', style: AppStyles.body),
                  SizedBox(width: 12),
                  Icon(Icons.forum, size: 15),
                  SizedBox(width: 4),
                  Text('$totalPosts posts', style: AppStyles.body),
                ],
              ),

              SizedBox(height: Dimensions.height10),

              // Organizer & contact
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(organizerAvatarUrl),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(organizerName, style: AppStyles.body),
                      Text(
                        contactInfo,
                        style: AppStyles.body.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                  Spacer(),
                  if (websiteUrl.isNotEmpty)
                    IconButton(
                      icon: Icon(Icons.link),
                      onPressed: () {
                        /* launch websiteUrl */
                      },
                    ),
                ],
              ),

              SizedBox(height: Dimensions.height10),

              // Gallery
              if (galleryImages.isNotEmpty)
                SizedBox(
                  height: Dimensions.height60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: galleryImages.length.clamp(0, 3),
                    separatorBuilder: (_, __) => SizedBox(width: 6),
                    itemBuilder:
                        (_, i) => ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimensions.cardRadius,
                          ),
                          child: Image.network(
                            galleryImages[i],
                            width: Dimensions.width60,
                            height: Dimensions.height60,
                            fit: BoxFit.cover,
                          ),
                        ),
                  ),
                ),

              SizedBox(height: Dimensions.height10),

              // Progress & achievements
              LinearProgressIndicator(value: progress),
              SizedBox(height: 6),
              Wrap(
                spacing: 6,
                children:
                    achievements
                        .map((a) => Chip(label: Text(a, style: AppStyles.body)))
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
