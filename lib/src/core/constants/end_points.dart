class EndPoints {
  EndPoints._internal();

  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String unifeiSiteUrl = 'https://unifei.edu.br/';

  static const String about = '/api/about-page?populate=header&populate=images';
  static const String contact =
      '/api/contact-page?populate=header&populate=image';
  static const String sendEmail = '/api/emails';
  static const String home =
      '/api/home-page?populate[header][populate]=*&populate[expertise_areas_section][populate]=*&populate[projects_section][populate]=*&populate[members_section][populate]=*&populate[publications_section][populate]=*&populate[partnerships_section][populate]=*';
  static const String members = '/api/members-page?populate=header';
  static const String membersList = '/api/members?populate=photo';
  static const String projects = '/api/projects-page?populate=header';
  static const String projectsList = '/api/projects?populate=images';
  static const String publications = '/api/publications-page?populate=header';
  static const String publicationsList = '/api/publications?populate=image';
}
