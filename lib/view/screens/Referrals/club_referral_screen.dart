import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hobby_club_app/controller/club/referral/referral_controller.dart';
import 'package:hobby_club_app/models/club/referral/referral_model.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ReferralScreen extends StatefulWidget {
  final String clubId;
  const ReferralScreen({super.key,required this.clubId});

  @override
  _ReferralScreenState createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final ReferralController referralController = Get.put(ReferralController());
  final int pointRate = 20;

  void _copyReferralCode(String referralCode) {
    Clipboard.setData(ClipboardData(text: referralCode));
  }

  void _shareReferralCode(String referralCode) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share feature would be implemented here'),
        backgroundColor: Colors.deepPurple.shade300,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    referralController.fetchReferralDetails(clubId: widget.clubId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Referrals',
        isLeading: true,
        centerTitle: true,
      ),
      body: Obx(() {
        if (referralController.isLoading.value) {
          return _buildShimmerLoading();
        }

        if (referralController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(referralController.errorMessage.value),
          );
        }

        final referralData = referralController.referralModel.value?.data;
        if (referralData == null) {
          return Center(child: Text('No referral data available'));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Referral Code Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple.shade300, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Referral Code',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            referralData.referralCode,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => _copyReferralCode(referralData.referralCode),
                                icon: Icon(Icons.copy, color: Colors.white),
                                tooltip: 'Copy',
                              ),
                              IconButton(
                                onPressed: () => _shareReferralCode(referralData.referralCode),
                                icon: Icon(Icons.share, color: Colors.white),
                                tooltip: 'Share',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Stats Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Total Referrals',
                      '${referralData.referrals.length}',
                      Icons.group,
                      Colors.blue,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Total Points',
                      '${(referralData.totalReferrals * pointRate).toString()} pts',
                      Icons.stars,
                      Colors.amber.shade700,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Commission Rate Info
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple.shade100),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.purple),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'You earn $pointRate Points per Referral for each success',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.purple.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Members Section
              Text(
                'Referred Members',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              SizedBox(height: 16),

              // Members List
              if (referralData.referrals.isEmpty)
                _buildEmptyState(100, 'No referrals found')
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: referralData.referrals.length,
                  itemBuilder: (context, index) {
                    final member = referralData.referrals[index];
                    return _buildMemberCard(member);
                  },
                ),
              SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildEmptyState(double height, String message) {
    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          message,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(Referral member) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                member.image,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.deepPurple.shade600,
                      size: 28,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 16),

          // Member Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.fullname,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  member.email,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                SizedBox(height: 4),
                Text(
                  'Joined: ${member.joinDate}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),

          // Status and Commission
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Active',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                '$pointRate pts',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Referral Code Card shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          SizedBox(height: 24),

          // Stat Cards shimmer
          Row(
            children: List.generate(2, (index) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index == 0 ? 12 : 0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: 24),

          // Commission Info shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          SizedBox(height: 24),

          // Title shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 16,
                width: 120,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 16),

          // List shimmer
          Column(
            children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

}