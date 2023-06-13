import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/templates/page_template.dart';
import 'package:robsic/src/modules/publications/domain/entities/publication_entity.dart';
import 'package:robsic/src/modules/publications/presentation/widgets/publication_card_widget.dart';

import '../../../../core/ui/organisms/footer_organism.dart';
import '../../../../core/ui/tokens/tokens.dart';
import '../../../core/core.dart';

class PublicationsPage extends StatefulWidget {
  const PublicationsPage({super.key});

  @override
  State<PublicationsPage> createState() => _PublicationsPageState();
}

class _PublicationsPageState extends State<PublicationsPage> {
  final publication = PublicationEntity(
    title:
        'An Improoved Voltage-Shifting Strategy to Attain Concomitant Accurat Power Sharing and Voltage Restoration In Droop-Controlled Microgrids',
    autors: ['Waner Wodson Aparecido Gonçalves Silva'],
    publicationDate: DateTime(2020, 04, 01),
    abstract:
        ' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc consectetur ligula ipsum, nec auctor risus scelerisque quis. Vestibulum varius turpis sed sagittis faucibus. Integer a ipsum sit amet est rhoncus fringilla et ut ligula. Nunc nibh sapien, dapibus eu orci vel, molestie interdum dolor. Mauris eu aliquam mi. Nullam fermentum mauris non blandit aliquet. Quisque tortor mi, sagittis nec ultricies et, accumsan non metus. Curabitur eget purus et tortor gravida efficitur ut a nisi. Aliquam posuere quis quam eget egestas.',
    urlLink: '',
    thumbUrl:
        'https://images.unsplash.com/photo-1614332625575-6bef549fcc7b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1441&q=80',
  );

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBar: const CustomAppBar(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const DefaultHeaderSection(
              title: 'Publications',
              text:
                  'It is a interdisciplinary team, composed of researchers with solid klowledge in Robotics, Electronics, and Computing.',
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: TokenSpaces.xl,
              ),
              color: TokenColors.gray100,
              width: double.infinity,
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Wrap(
                  spacing: TokenSpaces.md,
                  runSpacing: TokenSpaces.md,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.start,
                  children: [
                    for (int i = 0; i < 10; i++)
                      Publicationcard(
                        publication: publication,
                      ),
                  ],
                ),
              ),
            ),
            const FooterOrganism(),
          ],
        ),
      ),
    );
  }
}
