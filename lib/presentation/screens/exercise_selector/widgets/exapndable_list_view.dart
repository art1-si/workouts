import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:workouts/global/extensions/string_extensions.dart';
import 'package:workouts/presentation/theme/app_colors.dart';
import 'package:workouts/presentation/theme/typography.dart';

class ExpandableListView<GroupT, ElementT> extends StatefulWidget {
  const ExpandableListView({
    super.key,
    required this.entries,
    required this.groupBy,
    required this.groupTitle,
    required this.subElementTitle,
    this.onTap,
  });

  final List<ElementT> entries;
  final GroupT Function(ElementT) groupBy;

  final String Function(GroupT) groupTitle;
  final String Function(ElementT) subElementTitle;

  final void Function(List<ElementT>, int)? onTap;

  @override
  State<ExpandableListView<GroupT, ElementT>> createState() => _ExpandableListViewState<GroupT, ElementT>();
}

class _ExpandableListViewState<GroupT, ElementT> extends State<ExpandableListView<GroupT, ElementT>> {
  final _scrollController = ScrollController();

  final expansionAnimationDuration = const Duration(milliseconds: 20);

  Map<GroupT, List<ElementT>> get groupedEntries {
    return groupBy(widget.entries, widget.groupBy);
  }

  MapEntry<GroupT, List<ElementT>>? expandedTile;

  void onElementTapped(MapEntry<GroupT, List<ElementT>> tappedElement) {
    if (tappedElement.key == expandedTile?.key) {
      setState(() {
        expandedTile = null;
      });

      _scrollToStart();
      return;
    }

    setState(() {
      expandedTile = tappedElement;
    });

    _scrollToIndex(groupedEntries.keys.toList().indexOf(tappedElement.key));
  }

  void _scrollToStart() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToIndex(int index) async {
    final newScrollExtent = index * (ExpandableTile.tileHeight + 16);

    await Future.delayed(expansionAnimationDuration);

    await _scrollController.animateTo(
      newScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return ListView.builder(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          itemCount: groupedEntries.keys.length,
          itemBuilder: (context, index) {
            final elementKey = groupedEntries.keys.elementAt(index);
            return ExpandableTile<ElementT>(
              expanded: expandedTile?.key == elementKey,
              groupTitle: widget.groupTitle(elementKey),
              subElements: groupedEntries[elementKey]!,
              onSubElementTapped: widget.onTap,
              onElementTapped: () {
                onElementTapped(
                  MapEntry(elementKey, groupedEntries[elementKey]!),
                );
              },
              subElementTitle: widget.subElementTitle,
            );
          },
        );
      },
    );
  }
}

class ExpandableTile<ElementT> extends StatelessWidget {
  const ExpandableTile({
    super.key,
    required this.groupTitle,
    required this.subElements,
    required this.onElementTapped,
    required this.expanded,
    required this.subElementTitle,
    this.onSubElementTapped,
  });

  final String groupTitle;
  final List<ElementT> subElements;
  final String Function(ElementT) subElementTitle;

  final void Function(List<ElementT>, int)? onSubElementTapped;
  final VoidCallback onElementTapped;
  final bool expanded;

  final duration = const Duration(milliseconds: 150);

  static const tileHeight = 56.0;
  static const subTileHeight = 45.0;

  Widget get _exerciseTypeTile {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onTap: onElementTapped,
      title: StyledText.body(
        groupTitle.capitalize,
      ),
    );
  }

  Widget get _expandedExerciseTypeTile {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _exerciseTypeTile,
        _subList,
      ],
    );
  }

  Widget get _subList {
    return Column(
      children: subElements
          .mapIndexed(
            (index, e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () => onSubElementTapped?.call(subElements, index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: subTileHeight,
                    color: Colors.transparent,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: StyledText.body(subElementTitle(e)),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expandedHeight = (subElements.length * subTileHeight) + tileHeight + 8;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryShades.shade90,
            width: 2,
          ),
        ),
        height: expanded ? expandedHeight : tileHeight,
        duration: duration,
        child: expanded ? _expandedExerciseTypeTile : _exerciseTypeTile,
      ),
    );
  }
}
