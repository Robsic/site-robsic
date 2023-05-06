import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/organisms/appbar_organism.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOrganism(),
      body: const Center(
        child: Text(
          'Home Page',
        ),
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
    );
  }
}
