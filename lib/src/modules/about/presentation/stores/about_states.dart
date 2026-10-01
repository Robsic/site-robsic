import 'package:robsic/src/modules/about/domain/entities/about_page_entity.dart';
import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';

abstract class AboutState {
  const AboutState();
}

class AboutStateIdle extends AboutState {
  const AboutStateIdle();
}

class AboutStateLoading extends AboutState {
  const AboutStateLoading();
}

class AboutStateSuccess extends AboutState {
  final AboutPageEntity aboutEntity;
  const AboutStateSuccess(this.aboutEntity);
}

class AboutStateFailure extends AboutState {
  final AppFailure failure;
  const AboutStateFailure(this.failure);
}
