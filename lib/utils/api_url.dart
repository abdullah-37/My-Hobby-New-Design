class ApiUrl {
  static const String domainUrl = 'https://hobby.codedebuggers.com/';
  // static const String domainUrl = 'http://192.168.1.9:4343/public/';
  static const String baseUrl = '${domainUrl}api/';

  static const String registrationEndPoint = 'register';
  static const String loginEndPoint = 'login';
  static const String userLogoutEndPoint = 'logout';

  static const String profileEndPoint = 'profile_setting';
  static const String createClubEndPoint = 'create_club';
  static const String getAllClub = 'all_clubs';
  static const String getUserClub = 'user_clubs';
  static const String getJoinedClub = 'my_join_club';
  static const String getClubFeed = 'club_feeds/';

  static const String createComment = 'comment_create';
  static const String likePost = 'like';
  static const String getClubDiscussions = 'get_discussion';
  static const String createClubDiscussions = 'discussion';
  static const String getDiscussionsDetails = 'discuss_details';
  static const String discussionreply = 'discussion_reply';
  static const String upcomingschedule = 'upcoming_schedule';
}
