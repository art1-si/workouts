// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'infinite_page_controller.dart';
import 'widgets/limited_page_scroll_physics.dart';
import 'widgets/size_notifier_widget.dart';

/// Infinite page view.
///
/// Allows for infinite scrolling including negative index.
class InfinitePageView extends StatefulWidget {
  const InfinitePageView({
    super.key,
    required this.itemBuilder,
    this.controller,
    this.controllerAutoDispose = true,
    this.initialPageHeight = 219,
    this.automaticResizing = true,
    this.scrollPhysics,
    required this.descendingIndexLimit,
  });

  final IndexedWidgetBuilder itemBuilder;
  final InfinitePageController? controller;

  /// Whether or not [InfinitePageController] should dispose.
  /// In cases where you don't want controller to be disposed, set it to false
  /// otherwise it will be disposed.
  final bool controllerAutoDispose;

  /// Initial height for the page.
  ///
  /// This is needed for calculation, but it will be overwritten when content of the page is rendered.
  /// The value should similar to the height of the rendered page, otherwise it may
  /// have strange animation on initial render.
  final double initialPageHeight;

  final bool automaticResizing;

  final ScrollPhysics? scrollPhysics;

  /// Limit in descending direction.
  final int? descendingIndexLimit;

  @override
  State<InfinitePageView> createState() => _InfinitePageViewState();
}

class _InfinitePageViewState extends State<InfinitePageView> {
  late final InfinitePageController controller;

  /// Map of the pages with it size.
  late final childSizeForIndex = <int, double>{0: widget.initialPageHeight};
  int _currentPage = 0;
  int _previousPage = 0;
  bool firstIndexInitialized = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? InfinitePageController();
    super.initState();
    controller.addListener(_updatePage);
    _currentPage = controller.initialPage;
    _previousPage = (_currentPage - 1 < 0) ? 0 : (_currentPage - 1);
  }

  @override
  void didUpdateWidget(covariant InfinitePageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller
        ?..removeListener(_updatePage)
        ..removeListener(currentScrollDirectionListener);

      controller
        ..addListener(_updatePage)
        ..addListener(currentScrollDirectionListener);
    }
  }

  void _updateSize(Size size, int index) {
    childSizeForIndex[index] = size.height;
    if (!firstIndexInitialized) {
      setState(() {
        firstIndexInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    if (widget.controllerAutoDispose) {
      controller.dispose();
    }
    controller
      ..removeListener(_updatePage)
      ..removeListener(currentScrollDirectionListener);
    super.dispose();
  }

  double _previousScrollPosition = 0;
  AxisDirection _scrollDirection = AxisDirection.left;

  /// Lister to scroll direction.
  ///
  /// updates `_scrollDirection` based on the which direction page is being scrolled.
  void currentScrollDirectionListener() {
    final page = controller.page!;
    if (page > _previousScrollPosition) {
      _scrollDirection = AxisDirection.left;
    } else {
      _scrollDirection = AxisDirection.right;
    }
    _previousScrollPosition = page;
  }

  /// page position on which setState was called.
  ///
  /// We need this stop unnecessary calls to setState while scrolling.
  int _pagePositionOnSetState = 0;

  void _updatePage() {
    final page = controller.page!;

    switch (_scrollDirection) {
      case AxisDirection.right:
        _previousPage = page.round() + 1;
        _currentPage = page.round();

        break;
      case AxisDirection.left:
        _previousPage = page.round() - 1;
        _currentPage = page.round();
        break;

      default:
        throw Error();
    }

    /// only update when `_currentPage` and `_pagePositionOnSetState`.
    /// this allows for better performance.
    if (_pagePositionOnSetState != _currentPage) {
      setState(() {
        _pagePositionOnSetState = _currentPage;
      });
    }
  }

  ScrollPhysics get scrollPhysics =>
      widget.scrollPhysics ?? LimitedPageScrollPhysics(descendingIndexLimit: widget.descendingIndexLimit);

  @override
  Widget build(BuildContext context) {
    if (!widget.automaticResizing) {
      return Scrollable(
        physics: scrollPhysics,
        axisDirection: AxisDirection.right,
        controller: controller,
        viewportBuilder: (BuildContext context, ViewportOffset position) {
          return InfiniteViewPort(position: position, itemBuilder: widget.itemBuilder, onSizeChanged: null);
        },
      );
    }

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 250),
      tween: Tween<double>(
          begin: childSizeForIndex[_previousPage] ?? widget.initialPageHeight,
          end: childSizeForIndex[_currentPage] ?? childSizeForIndex[_previousPage] ?? widget.initialPageHeight),
      builder: (context, value, child) {
        return SizedBox(
          height: value,
          child: child,
        );
      },
      child: Scrollable(
        physics: scrollPhysics,
        axisDirection: AxisDirection.right,
        controller: controller,
        viewportBuilder: (BuildContext context, ViewportOffset position) {
          return InfiniteViewPort(
              position: position,
              itemBuilder: widget.itemBuilder,
              onSizeChanged: widget.automaticResizing ? _updateSize : null);
        },
      ),
    );
  }
}

class InfiniteViewPort extends StatefulWidget {
  const InfiniteViewPort({
    super.key,
    required this.position,
    required this.itemBuilder,
    required this.onSizeChanged,
  });

  final ViewportOffset position;
  final IndexedWidgetBuilder itemBuilder;
  final void Function(Size, int)? onSizeChanged;

  @override
  State<InfiniteViewPort> createState() => _InfiniteViewPortState();
}

class _InfiniteViewPortState extends State<InfiniteViewPort> {
  late final state = Scrollable.of(context);

  late final InfinitePagePosition negativePagePosition = InfinitePagePosition(
    context: state,
    physics: const AlwaysScrollableScrollPhysics(),
    initialPixels: -0,
    useNegative: true,
  );

  @override
  void initState() {
    super.initState();
    widget.position.addListener(negativeListener);
  }

  void negativeListener() => negativePagePosition.forcePixels(widget.position.pixels);

  @override
  void dispose() {
    super.dispose();
    widget.position.removeListener(negativeListener);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: widget.onSizeChanged != null ? StackFit.expand : StackFit.loose,
      children: [
        Viewport(
          key: const ValueKey(-1),
          offset: negativePagePosition,
          axisDirection: AxisDirection.left,
          anchor: 1.0,
          slivers: [
            SliverFillViewport(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final negativeIndex = -1 - index;
                  if (widget.onSizeChanged == null) {
                    return widget.itemBuilder(context, negativeIndex);
                  }
                  return OverflowPage(
                    onSizeChange: (size) {
                      widget.onSizeChanged!(size, negativeIndex);
                    },
                    alignment: Alignment.center,
                    scrollDirection: Axis.horizontal,
                    child: widget.itemBuilder(context, negativeIndex),
                  );
                },
              ),
            ),
          ],
        ),
        Viewport(
          key: const ValueKey(1),
          axisDirection: AxisDirection.right,
          offset: widget.position,
          anchor: 0.0,
          slivers: [
            SliverFillViewport(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (widget.onSizeChanged == null) {
                    return widget.itemBuilder(context, index);
                  }
                  return OverflowPage(
                    onSizeChange: (size) {
                      widget.onSizeChanged!(size, index);
                    },
                    alignment: Alignment.center,
                    scrollDirection: Axis.horizontal,
                    child: widget.itemBuilder(context, index),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
