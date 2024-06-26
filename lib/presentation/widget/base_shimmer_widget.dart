import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmerWidget extends StatelessWidget {
  final Widget child;
  final bool forceWrap;
  final double radius;
  const BaseShimmerWidget({
    super.key,
    required this.child,
    this.forceWrap = false,
    this.radius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.5),
      highlightColor: Colors.white,
      child: (child is Text ||
                  child is Container &&
                      (child as Container).decoration == null) ||
              forceWrap
          ? Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(radius)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                child: child is Text
                    ? Text(
                        (child as Text).data ?? ' ' * 30,
                        style: (child as Text)
                            .style
                            ?.copyWith(color: Colors.transparent),
                      )
                    : child,
              ),
            )
          : child,
    );
  }
}
