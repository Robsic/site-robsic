import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';

class PageLoading extends StatelessWidget {
  const PageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 2 * appBarHeight,
      width: double.infinity,
      child: const Center(
        child: CircularLoadingAtom(),
      ),
    );
  }
}
