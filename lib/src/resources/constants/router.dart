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
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        restorationId: state.pageKey.value,
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: Routes.about,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        restorationId: state.pageKey.value,
        child: const AboutPage(),
      ),
    ),
    GoRoute(
      path: Routes.members,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        restorationId: state.pageKey.value,
        child: const MembersPage(),
      ),
    ),
    GoRoute(
      path: Routes.projects,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        restorationId: state.pageKey.value,
        child: const ProjectsPage(),
      ),
    ),
    GoRoute(
      path: Routes.publications,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        restorationId: state.pageKey.value,
        child: const PublicationsPage(),
      ),
    ),
    GoRoute(
      path: Routes.contact,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        restorationId: state.pageKey.value,
        child: const ContactPage(),
      ),
    ),
  ],
);
