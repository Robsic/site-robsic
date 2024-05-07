import 'package:robsic/src/modules/core/core.dart';

class MemberEntity {
  final String name;
  final String role;
  final ImageEntity? photo;
  final String description;
  final String orcidUrl;
  final String lattesUrl;
  final String linkedinUrl;
  final String email;
  final bool canReceiveEmail;

  MemberEntity({
    required this.name,
    required this.role,
    this.photo,
    required this.description,
    required this.orcidUrl,
    required this.lattesUrl,
    required this.linkedinUrl,
    required this.email,
    required this.canReceiveEmail,
  });
}
