class ApiEndpoints {
  static const String users = '/users';
  static const String login = '/api/login';
  static const String register = '/api/register';
  static const String members = '/members';
  static const String home = '/home';
  static const String myProjects = '/api/my-projects';

  static String projects(String id) => '/api/projects/$id/summary';
  static String activities(String id) => '/api/projects/$id/activity';
  static String insights(String id) => '/api/projects/$id/insights';
  static String userById(String id) => '/users/$id';
  static String userProjects(String id) => '/api/users/$id/projects';
  static String userActivities(String id) => '/users/$id/activities';
}
