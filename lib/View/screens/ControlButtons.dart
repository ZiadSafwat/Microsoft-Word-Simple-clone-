import 'package:flutter/material.dart';

import '../../Core/consts/appColors.dart';

class CustomToolbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomToolbar({
    required this.buttons,
    this.backgroundColor,
    this.axis = Axis.horizontal,
    this.dividerColor,
    this.dividerSpacing = 8.0,
    super.key,
  });

  final List<Widget> buttons;
  final Color? backgroundColor;
  final Axis axis;
  final Color? dividerColor;
  final double dividerSpacing;

  double get _toolbarSize => 56.0; // Default toolbar size

  @override
  Widget build(BuildContext context) {
    final divider = SizedBox(
      height: axis == Axis.horizontal ? _toolbarSize : null,
      width: axis == Axis.vertical ? _toolbarSize : null,
      child: _ToolbarDivider(axis: axis, color: dividerColor, space: dividerSpacing),
    );

    final List<Widget> toolbarButtons = [];
    for (int i = 0; i < buttons.length; i++) {
      if (i > 0) {
        toolbarButtons.add(divider);
      }
      toolbarButtons.add(buttons[i]);
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).canvasColor,
      ),
      constraints: BoxConstraints.tightFor(
        height: axis == Axis.horizontal ? _toolbarSize : null,
        width: axis == Axis.vertical ? _toolbarSize : null,
      ),
      child: Wrap(alignment: WrapAlignment.center,
        direction: axis, // Wrap items in the given direction
        spacing: dividerSpacing, // Space between items
        runSpacing: dividerSpacing, // Space between rows/columns when wrapping
        children: toolbarButtons,
      ),
    );
  }

  @override
  Size get preferredSize => axis == Axis.horizontal
      ? Size.fromHeight(_toolbarSize)
      : Size.fromWidth(_toolbarSize);
}

class _ToolbarDivider extends StatelessWidget {
  const _ToolbarDivider({
    required this.axis,
    this.color,
    this.space,
  });

  final Axis axis;
  final Color? color;
  final double? space;

  @override
  Widget build(BuildContext context) {
    return axis == Axis.vertical
        ? Divider(
      height: space,
      color: color,
      indent: 12,
      endIndent: 12,
    )
        : VerticalDivider(
      width: space,
      color: color,
      indent: 12,
      endIndent: 12,
    );
  }
}

Widget ControlButton(VoidCallback? func, IconData icon) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      onPressed: func,
      child: FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.scaleDown,
        child: Icon(icon),
      ),
    ),
  );
}
