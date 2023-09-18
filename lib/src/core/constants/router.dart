import 'package:go_router/go_router.dart';
import 'package:robsic/src/modules/contact/contact.dart';
import 'package:robsic/src/modules/publications/presentation/pages/publications_page.dart';

import '../../modules/about/about.dart';
import '../../modules/home/home.dart';
import '../../modules/members/members.dart';
import '../../modules/projects/projects.dart';
import 'routes.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: Routes.about,
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      path: Routes.members,
      builder: (context, state) => const MembersPage(),
    ),
    GoRoute(
      path: Routes.projects,
      builder: (context, state) => const ProjectsPage(),
    ),
    GoRoute(
      path: Routes.publications,
      builder: (context, state) => const PublicationsPage(),
    ),
    GoRoute(
      path: Routes.contact,
      builder: (context, state) => const ContactPage(),
    ),
  ],
);
