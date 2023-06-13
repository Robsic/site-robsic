import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/atoms/body_text_atom.dart';
import 'package:robsic/src/core/ui/atoms/label_atom.dart';
import 'package:robsic/src/core/ui/organisms/footer_organism.dart';
import 'package:robsic/src/core/ui/templates/page_template.dart';
import 'package:robsic/src/core/ui/tokens/token_spaces.dart';
import 'package:robsic/src/modules/core/presentation/widgets/custom_app_bar.dart';

import '../../../core/presentation/widgets/default_header_section.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBar: const CustomAppBar(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const DefaultHeaderSection(
              title: 'About Us',
              text:
                  'Technology research has changed, the barriers no longer exists.',
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: TokenSpaces.xxl),
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  children: [
                    Center(
                      child: LabelAtom(
                        text:
                            'Laboratory of Robotics, Inteligent and Complex Systems',
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                                fontSize: 32.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: TokenSpaces.xxl),
                    BodyTextAtom(
                      text: '''
                          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc consectetur ligula ipsum, nec auctor risus scelerisque quis. Vestibulum varius turpis sed sagittis faucibus. Integer a ipsum sit amet est rhoncus fringilla et ut ligula. Nunc nibh sapien, dapibus eu orci vel, molestie interdum dolor. Mauris eu aliquam mi. Nullam fermentum mauris non blandit aliquet. Quisque tortor mi, sagittis nec ultricies et, accumsan non metus. Curabitur eget purus et tortor gravida efficitur ut a nisi. Aliquam posuere quis quam eget egestas.
                          Maecenas malesuada, magna sit amet tristique hendrerit, neque orci tristique leo, sit amet finibus sapien ex nec velit. Aliquam consequat dignissim lacinia. Proin sit amet nisi sit amet massa tincidunt lobortis et id metus. Phasellus fermentum diam sed nisl tempor dignissim in sit amet odio. Cras vel finibus massa. Nulla laoreet mi nec magna fringilla, ac condimentum purus convallis. Phasellus bibendum viverra est a vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aenean maximus neque eu lorem euismod dapibus. Nam ornare a lectus sit amet posuere. Sed at ipsum sem. Vivamus a felis a libero porttitor volutpat vitae sit amet quam. Integer convallis auctor tellus. Suspendisse ullamcorper nisi ut velit semper faucibus. Aenean vestibulum urna sit amet quam condimentum dignissim. Etiam metus eros, vulputate ut sollicitudin ut, commodo nec quam.
                          ''',
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                    BodyTextAtom(
                      text: '''
                          Pellentesque eu convallis erat. Curabitur ut felis nec magna dignissim rutrum et ut ex. Donec maximus sollicitudin leo, nec gravida nulla condimentum ut. Nullam eget lobortis felis, id fringilla augue. Duis ultrices odio et finibus congue. Nunc eu iaculis urna. Sed eu leo purus. Nullam bibendum nisl ipsum, eget gravida enim tempus sit amet. Vivamus at laoreet massa. Nunc egestas nibh in luctus eleifend. Curabitur lacinia molestie commodo. Morbi id ante urna. Suspendisse a urna urna. Morbi quis pulvinar lorem, fermentum euismod turpis.
                          Quisque massa tortor, euismod sed placerat ut, mollis blandit ligula. Nam sed neque accumsan, congue eros sit amet, fermentum est. Sed pharetra elit ac mollis hendrerit. Ut mi sapien, faucibus eget consequat ac, suscipit eget massa. Pellentesque gravida, enim luctus sollicitudin laoreet, risus arcu lobortis massa, eu vehicula sapien mi id odio. Vestibulum luctus volutpat enim, id ullamcorper purus tincidunt ac. Sed in elit at eros rutrum eleifend sed nec tortor. Ut id fermentum ligula, nec lobortis est. Donec lobortis semper ipsum, a ultricies metus auctor eget. Donec quis ipsum quis odio sodales placerat. In consectetur auctor odio, id ornare mauris condimentum sit amet. Nunc fermentum vehicula tortor. Phasellus sed massa sit amet sapien tincidunt vestibulum. Donec molestie lectus arcu, id tristique enim efficitur quis. Praesent auctor vestibulum scelerisque. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                          Sed sapien justo, tristique non sagittis at, tempor et metus. Donec auctor purus ante, non molestie ligula elementum quis. Aenean finibus nisi nec ligula lobortis scelerisque. Integer feugiat eu lectus vitae aliquet. Nunc congue nulla quis erat iaculis, eget lacinia elit ullamcorper. Vestibulum euismod leo a metus vulputate suscipit. Sed scelerisque arcu et pellentesque gravida. Phasellus dictum rutrum risus, vitae dictum sem ultricies in. Nunc convallis hendrerit ultricies. Mauris laoreet vulputate ex, ac hendrerit turpis finibus et. Donec vestibulum ante eu congue egestas.
                          Vestibulum luctus volutpat enim, id ullamcorper purus tincidunt ac. Sed in elit at eros rutrum eleifend sed nec tortor. Ut id fermentum ligula, nec lobortis est. Donec lobortis semper ipsum, a ultricies metus auctor eget. Donec quis ipsum quis odio sodales placerat. In consectetur auctor odio, id ornare mauris condimentum sit amet. Nunc fermentum vehicula tortor. Phasellus sed massa sit amet sapien tincidunt vestibulum. Donec molestie lectus arcu, id tristique enim efficitur quis. Praesent auctor vestibulum scelerisque. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                          Sed sapien justo, tristique non sagittis at, tempor et metus. Donec auctor purus ante, non molestie ligula elementum quis. Aenean finibus nisi nec ligula lobortis scelerisque. Integer feugiat eu lectus vitae aliquet. Nunc congue nulla quis erat iaculis, eget lacinia elit ullamcorper. Vestibulum euismod leo a metus vulputate suscipit. Sed scelerisque arcu et pellentesque gravida. Phasellus dictum rutrum risus, vitae dictum sem ultricies in. Nunc convallis hendrerit ultricies. Mauris laoreet vulputate ex, ac hendrerit turpis finibus et. Donec vestibulum ante eu congue egestas.
                          ''',
                      textStyle: Theme.of(context).textTheme.bodyLarge,
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
