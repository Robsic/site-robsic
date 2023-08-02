import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/organisms/footer_organism.dart';

import '../../../core/core.dart';
import '../../home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      endDrawer: CustomEndDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            AreasOfExpertiseSection(),
            Divider(height: 2.0, color: Colors.green),
            ProjectsSectionWidget(),
            Divider(height: 2.0, color: Colors.green),
            MembersSection(),
            Divider(height: 2.0, color: Colors.green),
            PapersSection(),
            FooterOrganism()
          ],
        ),
      ),
    );
  }
}
