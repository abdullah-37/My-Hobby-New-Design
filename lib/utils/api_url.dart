class ApiUrl {
  static const String domainUrl = 'https://club.codedebuggers.com/';
  // static const String domainUrl = 'http://192.168.1.3:500/';
  static const String baseUrl = '${domainUrl}api/';

  static const String registrationEndPoint = 'register';
  static const String loginEndPoint = 'login';
  static const String userLogoutEndPoint = 'logout';

  static const String profileEndPoint = 'profile_setting';
  static const String createClubEndPoint = 'create_club';
  static const String getAllClub = 'all_clubs';

  static const String getTrendingClub = 'trending_clubs';
  static const String getCategories = 'get_category';

  static const String getUserClub = 'user_clubs';
  static const String getJoinClub = 'join_club';
  static const String getJoinedClub = 'my_join_club';
  static const String getClubFeed = 'club_feeds/';
  static const String getClubFeedPost = 'create_feeds';
  static const String getClubEvent = 'club_schedule/';
  static const String getClubEventPost = 'create_schedule';
  static const String getAllClubEvent = 'all_upcoming_schedule';
  static const String JOINClubEvent = 'participate';

  static const String createComment = 'comment_create';
  static const String likePost = 'like';
  static const String getClubDiscussions = 'get_discussion/';
  static const String createClubDiscussions = 'discussion';
  static const String getDiscussionsDetails = 'discuss_details/';
  static const String discussionReply = 'discussion_reply';
  static const String upcomingschedule = 'upcoming_schedule';

  static const String CLUBMESSAGE = 'club/send-message';
  static const String GETCLUBMESSAGE = 'club/get_chat/';
  static const String SavePlayerId = 'save-player-id';

  static const String CLUBReferral = 'user_club_referrals';
  static const String UserBadges = 'user_badges';
  static const String UserPoints = 'user_club_points';
  static const String UserClubAllPoints = 'user_club_all_points';
  static const String Redeems = 'redeem';
  static const String RedeemReward = 'purchase_redeem';
}
