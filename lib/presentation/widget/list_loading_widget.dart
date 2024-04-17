import 'package:flutter/material.dart';

import 'base_shimmer_widget.dart';

class ListLoadingWidget extends StatelessWidget {
  const ListLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: BaseShimmerWidget(
          child: Card(
            child: Ink(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              height: 75,
              child: Container(),
            ),
          ),
        ),
      ),
    );
  }
}
