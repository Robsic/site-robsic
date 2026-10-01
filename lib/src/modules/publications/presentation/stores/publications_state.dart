import '../../../core/core.dart';
import '../../domain/domain.dart';

abstract class PublicationsState {
  const PublicationsState();
}

class PublicationsStateIdle extends PublicationsState {
  const PublicationsStateIdle();
}

class PublicationsStateLoading extends PublicationsState {
  const PublicationsStateLoading();
}

class PublicationsStateSuccess extends PublicationsState {
  final PublicationsPageEntity publicationsPageEntity;
  const PublicationsStateSuccess(this.publicationsPageEntity);
}

class PublicationsStateFailure extends PublicationsState {
  final AppFailure failure;
  const PublicationsStateFailure(this.failure);
}

class PublicationsListStateLoading extends PublicationsStateSuccess {
  const PublicationsListStateLoading(super.publicationsPageEntity);
}

class PublicationsListStateSuccess extends PublicationsStateSuccess {
  final List<PublicationEntity> publications;
  const PublicationsListStateSuccess(
    super.publicationsEntity,
    this.publications,
  );
}

class PublicationsListStateFailure extends PublicationsStateSuccess {
  final AppFailure failure;
  const PublicationsListStateFailure(
    super.publicationsEntity,
    this.failure,
  );
}
