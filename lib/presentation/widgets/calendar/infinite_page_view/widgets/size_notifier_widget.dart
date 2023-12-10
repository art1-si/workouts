import 'package:flutter/material.dart';

/// Widget that allows its child to overflow its boundaries in a controlled manner.
/// It is designed to report the size of its child to a callback function when its size changes.
/// This class is useful when you want to measure the size of a widget
/// that can potentially overflow its parent container.
class OverflowPage extends StatelessWidget {
  final ValueChanged<Size> onSizeChange;
  final Widget child;
  final Alignment alignment;
  final Axis scrollDirection;

  const OverflowPage({
    required this.onSizeChange,
    required this.child,
    required this.alignment,
    required this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minHeight: scrollDirection == Axis.horizontal ? 0 : null,
      minWidth: scrollDirection == Axis.vertical ? 0 : null,
      maxHeight: scrollDirection == Axis.horizontal ? double.infinity : null,
      maxWidth: scrollDirection == Axis.vertical ? double.infinity : null,
      alignment: alignment,
      child: SizeReportingWidget(
        onSizeChange: onSizeChange,
        child: child,
      ),
    );
  }
}

/// Widget that wraps another widget and reports changes in the size of the wrapped widget to a callback function.
/// It is used internally by the [OverflowPage] class but can be reused in other contexts where size reporting is needed.
class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const SizeReportingWidget({
    Key? key,
    required this.child,
    required this.onSizeChange,
  }) : super(key: key);

  @override
  _SizeReportingWidgetState createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  final _widgetKey = GlobalKey();
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Container(
          key: _widgetKey,
          child: widget.child,
        ),
      ),
    );
  }

  void _notifySize() {
    final context = _widgetKey.currentContext;
    if (context == null) return;
    final size = context.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size!);
    }
  }
}
