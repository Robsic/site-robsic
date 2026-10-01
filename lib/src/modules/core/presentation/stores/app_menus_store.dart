import 'package:flutter/material.dart';

enum AppMenus { home, about, members, projects, publications, contact, none }

class AppMenusStore extends ValueNotifier<AppMenus> {
  AppMenusStore() : super(AppMenus.none);

  void setMenu(AppMenus newMenu) {
    if (newMenu != value) {
      value = newMenu;
    }
  }

  bool get isAboutPage => value == AppMenus.about;
  bool get isMembersPage => value == AppMenus.members;
  bool get isProjectsPage => value == AppMenus.projects;
  bool get isPublicationsPage => value == AppMenus.publications;
}
