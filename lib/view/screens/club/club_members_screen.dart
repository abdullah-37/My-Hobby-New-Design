import 'package:flutter/material.dart';
import 'package:hobby_club_app/controller/club/members/club_members_controller.dart';
import 'package:hobby_club_app/models/club/members/club_members_model.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ClubMembersView extends StatefulWidget {
  final String clubId;
  const ClubMembersView({super.key, required this.clubId});

  @override
  _ClubMembersViewState createState() => _ClubMembersViewState();
}

class _ClubMembersViewState extends State<ClubMembersView> {
  final clubMembersController = Get.put(ClubMembersController());

  @override
  void initState() {
    clubMembersController.fetchClubMembers(clubId: widget.clubId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: 'Club Members', isLeading: true),
      body: Obx(() {
        if (clubMembersController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: colorScheme.primary,
            ),
          );
        }

        if (clubMembersController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              clubMembersController.errorMessage.value,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
            ),
          );
        }

        final members = clubMembersController.clubMembersModel.value?.data ?? [];

        if (members.isEmpty) {
          return _buildEmptyState();
        }

        return Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.people,
                            color: colorScheme.primary,
                            size: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            members.length.toString(),
                            style: theme.textTheme.titleMedium!.copyWith(
                                color: Colors.black
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Total Members',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return _buildMemberCard(members[index]);
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMemberCard(ClubMember member) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(member.img),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${member.firstName} ${member.lastName}',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '@${member.userName}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                if (member.badges.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [colorScheme.primary, colorScheme.secondary],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${member.badges.length} Badge${member.badges.length > 1 ? 's' : ''}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.emoji_events,
                      color: colorScheme.secondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Badges',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (member.badges.isEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_events, color: Colors.grey[400], size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'No badges yet',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  )
                else
                  ...member.badges.map((badge) => _buildBadgeItem(badge)).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem(MemberBadge badge) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.secondary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              badge.img,
              width: 32,
              height: 32,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Colors.white,
                    size: 16,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  badge.title,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  badge.type.toUpperCase(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Earned: ${DateFormat('MMM dd, yyyy').format(badge.assignedAt)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No members found',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filter criteria',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}