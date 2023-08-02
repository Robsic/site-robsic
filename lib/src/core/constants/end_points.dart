class EndPoints {
  EndPoints._internal();

  static var baseUrl = const String.fromEnvironment('BASE_URL');
  static const String about = '/api/about-page?populate=header&populate=images';
  static const String contact =
      '/api/contact-page?populate=header&populate=image';
  static const String home =
      '/api/home-page?populate[expertise_areas_section][populate]=*&populate[projects_section][populate]=*&populate[members_section][populate]=*&populate[publications_section][populate]=*';
  static const String members = '/api/members-page?populate=header';
  static const String membersList = '/api/members';
  static const String projects = '/api/projects-page?populate=header';
  static const String projectsList = '/api/projects';
}
