import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @aboutUsLabel.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUsLabel;

  /// No description provided for @membersLabel.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get membersLabel;

  /// No description provided for @projectsLabel.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projectsLabel;

  /// No description provided for @publicationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Publications'**
  String get publicationsLabel;

  /// No description provided for @contactUsLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUsLabel;

  /// No description provided for @linksLabel.
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get linksLabel;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressLabel;

  /// No description provided for @ourMembersLabel.
  ///
  /// In en, this message translates to:
  /// **'Our Members'**
  String get ourMembersLabel;

  /// No description provided for @seeProjectsLabel.
  ///
  /// In en, this message translates to:
  /// **'See Projects'**
  String get seeProjectsLabel;

  /// No description provided for @papersLabel.
  ///
  /// In en, this message translates to:
  /// **'Papers'**
  String get papersLabel;

  /// No description provided for @allRightsReservedLabel.
  ///
  /// In en, this message translates to:
  /// **'All Rights Reserved'**
  String get allRightsReservedLabel;

  /// No description provided for @moreDetailsLabel.
  ///
  /// In en, this message translates to:
  /// **'More Details'**
  String get moreDetailsLabel;

  /// No description provided for @lattesLabel.
  ///
  /// In en, this message translates to:
  /// **'Lattes'**
  String get lattesLabel;

  /// No description provided for @orcidLabel.
  ///
  /// In en, this message translates to:
  /// **'Orcid'**
  String get orcidLabel;

  /// No description provided for @linkedinLabel.
  ///
  /// In en, this message translates to:
  /// **'Linkedin'**
  String get linkedinLabel;

  /// No description provided for @sendEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Send email'**
  String get sendEmailLabel;

  /// No description provided for @errorLoadingPage.
  ///
  /// In en, this message translates to:
  /// **'Error loading page!'**
  String get errorLoadingPage;

  /// No description provided for @errorLoadingMembersList.
  ///
  /// In en, this message translates to:
  /// **'Error loading members list!'**
  String get errorLoadingMembersList;

  /// No description provided for @errorLoadingProjectsList.
  ///
  /// In en, this message translates to:
  /// **'Error loading projects list!'**
  String get errorLoadingProjectsList;

  /// No description provided for @errorLoadingPublicationsList.
  ///
  /// In en, this message translates to:
  /// **'Error loading publications list!'**
  String get errorLoadingPublicationsList;

  /// No description provided for @seeDetailsLabel.
  ///
  /// In en, this message translates to:
  /// **'See Details'**
  String get seeDetailsLabel;

  /// No description provided for @getAccessLabel.
  ///
  /// In en, this message translates to:
  /// **'Get Access'**
  String get getAccessLabel;

  /// No description provided for @sendAMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Send a Message'**
  String get sendAMessageLabel;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get nameLabel;

  /// No description provided for @yourNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Full Name'**
  String get yourNameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get emailLabel;

  /// No description provided for @emailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'youremail@example.com'**
  String get emailPlaceholder;

  /// No description provided for @messageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageLabel;

  /// No description provided for @typeYourMessageHere.
  ///
  /// In en, this message translates to:
  /// **'Type your message here...'**
  String get typeYourMessageHere;

  /// No description provided for @sendMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessageLabel;

  /// No description provided for @sendMessageSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully!'**
  String get sendMessageSuccess;

  /// No description provided for @sendMessageError.
  ///
  /// In en, this message translates to:
  /// **'The message could not be sent.'**
  String get sendMessageError;

  /// No description provided for @emptyFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'The field cannot be empty!'**
  String get emptyFieldErrorMessage;

  /// No description provided for @invalidNameMessage.
  ///
  /// In en, this message translates to:
  /// **'Fill in the full name!'**
  String get invalidNameMessage;

  /// No description provided for @invalidEmailMessage.
  ///
  /// In en, this message translates to:
  /// **'Fill in a valid email!'**
  String get invalidEmailMessage;

  /// No description provided for @searchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchLabel;

  /// No description provided for @professorsLabel.
  ///
  /// In en, this message translates to:
  /// **'Professors'**
  String get professorsLabel;

  /// No description provided for @phdStudentsLabel.
  ///
  /// In en, this message translates to:
  /// **'Ph.D. Students'**
  String get phdStudentsLabel;

  /// No description provided for @masterStudentsLabel.
  ///
  /// In en, this message translates to:
  /// **'Master\'s Students'**
  String get masterStudentsLabel;

  /// No description provided for @undergraduateStudentsLabel.
  ///
  /// In en, this message translates to:
  /// **'Undergraduate Students'**
  String get undergraduateStudentsLabel;

  /// No description provided for @studentsLabel.
  ///
  /// In en, this message translates to:
  /// **'Students'**
  String get studentsLabel;

  /// No description provided for @noMembersFound.
  ///
  /// In en, this message translates to:
  /// **'No members found.'**
  String get noMembersFound;

  /// No description provided for @noProjectsFound.
  ///
  /// In en, this message translates to:
  /// **'No projects found.'**
  String get noProjectsFound;

  /// No description provided for @noPublicationsFound.
  ///
  /// In en, this message translates to:
  /// **'No publications found.'**
  String get noPublicationsFound;

  /// No description provided for @loadImageError.
  ///
  /// In en, this message translates to:
  /// **'Error loading image.'**
  String get loadImageError;

  /// No description provided for @cnpqGroupLabel.
  ///
  /// In en, this message translates to:
  /// **'CNPq Research Group'**
  String get cnpqGroupLabel;

  /// No description provided for @youtubeChannelLabel.
  ///
  /// In en, this message translates to:
  /// **'YouTube Channel'**
  String get youtubeChannelLabel;

  /// No description provided for @githubLabel.
  ///
  /// In en, this message translates to:
  /// **'GitHub Repository'**
  String get githubLabel;

  /// No description provided for @ourGroupAndMediaLabel.
  ///
  /// In en, this message translates to:
  /// **'Our Group & Media'**
  String get ourGroupAndMediaLabel;

  /// No description provided for @cnpqDescLabel.
  ///
  /// In en, this message translates to:
  /// **'Access the official page of the RobSIC research group on CNPq.'**
  String get cnpqDescLabel;

  /// No description provided for @youtubeDescLabel.
  ///
  /// In en, this message translates to:
  /// **'Watch our project videos, demonstrations, and research.'**
  String get youtubeDescLabel;

  /// No description provided for @accessPageLabel.
  ///
  /// In en, this message translates to:
  /// **'Access Page'**
  String get accessPageLabel;

  /// No description provided for @watchChannelLabel.
  ///
  /// In en, this message translates to:
  /// **'Watch on YouTube'**
  String get watchChannelLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
