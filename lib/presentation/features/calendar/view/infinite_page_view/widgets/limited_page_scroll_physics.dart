import 'package:flutter/material.dart';

class LimitedPageScrollPhysics extends PageScrollPhysics {
  /// Creates physics for a [PageView].
  const LimitedPageScrollPhysics({
    super.parent,
    this.descendingIndexLimit,
  });

  final int? descendingIndexLimit;

  @override
  LimitedPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return LimitedPageScrollPhysics(parent: buildParent(ancestor), descendingIndexLimit: descendingIndexLimit);
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final limitedPosition =
        descendingIndexLimit != null ? (position.viewportDimension * (descendingIndexLimit! + 1)) : null;

    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= (limitedPosition ?? position.minScrollExtent))) {
      final tolerance = toleranceFor(position);
      final target = _getTargetPixels(position, tolerance, velocity);
      if (target != position.pixels) {
        return ScrollSpringSimulation(spring, position.pixels, target, velocity, tolerance: tolerance);
      }
      return null;
    }
    return super.createBallisticSimulation(position, velocity);
  }

  double _getTargetPixels(ScrollMetrics position, Tolerance tolerance, double velocity) {
    return (position.viewportDimension * (descendingIndexLimit! + 1));
  }
}
