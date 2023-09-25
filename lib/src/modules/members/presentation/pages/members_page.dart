import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/modules/core/core.dart';
import 'package:robsic/src/modules/members/domain/domain.dart';
import 'package:robsic/src/modules/members/presentation/stores/stores.dart';

import '../../../../core/core.dart';
import '../widgets/widgets.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  late final MembersStore _membersStore;

  @override
  void initState() {
    super.initState();
    _membersStore = serviceLocator.get<MembersStore>();
    _membersStore.getMembersData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPageScaffold(
      child: ValueListenableBuilder<MembersState>(
          valueListenable: _membersStore,
          builder: (context, state, _) {
            if (state is MembersStateFailure) {
              return PageError(
                errorMessage: AppLocalizations.of(context)!.errorLoadingPage,
                reloadAction: () => _membersStore.getMembersData(),
              );
            } else if (state is MembersStateSuccess) {
              MembersEntity membersPageData = state.membersEntity;
              HeaderSectionEntity? headerSection = membersPageData.header;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    DefaultHeaderSection(
                      title: headerSection?.title ?? '',
                      text: headerSection?.content ?? '',
                    ),
                    ValueListenableBuilder<MembersState>(
                      valueListenable: _membersStore,
                      builder: (context, stateList, _) {
                        if (stateList is MembersListStateFailure) {
                          return PageError(
                            errorMessage: AppLocalizations.of(context)!
                                .errorLoadingMembersList,
                            reloadAction: () => _membersStore.getMembersList(),
                          );
                        } else if (stateList is MembersListStateSuccess) {
                          List<MemberEntity> members = stateList.members;
                          return Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              vertical: 32.0,
                            ),
                            width: double.infinity,
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Wrap(
                                  spacing: TokenSpaces.md,
                                  runSpacing: TokenSpaces.md,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.start,
                                  children: List.generate(
                                    members.length,
                                    (index) {
                                      MemberEntity member = members[index];
                                      return Membercard(member: member);
                                    },
                                  )),
                            ),
                          );
                        } else {
                          return const PageLoading();
                        }
                      },
                    ),
                    const FooterOrganism(),
                  ],
                ),
              );
            } else {
              return const PageLoading();
            }
          }),
    );
  }
}
