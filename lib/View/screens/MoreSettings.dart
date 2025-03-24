import 'dart:ui'; // Required for BackdropFilter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Core/viewModels/TextBoxProvider.dart';
import 'ControlButtons.dart';

class MoreSettings extends StatelessWidget {
  const MoreSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TextBoxProvider>(
      builder: (context, textBoxProvider, _) {
        // Ensure a valid return if tooltip is not visible or no item is selected
        if (!(textBoxProvider.isTooltipVisible &&
            textBoxProvider.currentSelectedItemIndex != null)) {
          return SizedBox.shrink();
        }

        final selectedItem = textBoxProvider
            .textBoxModelList[textBoxProvider.currentSelectedItemIndex!];

        return Align(
          alignment: Alignment.topLeft,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.7,
            heightFactor: 0.3,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Card(
                  elevation: 0.1,
                  color: Colors.white.withAlpha(125),
                  margin: const EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: ListView(
                      children: [
                        // Toolbar with various options
                        CustomToolbar(
                          backgroundColor: Colors.transparent,
                          axis: Axis.horizontal,
                          buttons: [
                            IconButton(
                              icon: const Icon(Icons.align_vertical_top),
                              onPressed: () =>
                                  textBoxProvider.changeItemOffset(null, 0),
                            ),
                            IconButton(
                              icon: const Icon(Icons.align_horizontal_left),
                              onPressed: () =>
                                  textBoxProvider.changeItemOffset(0, null),
                            ),
                            IconButton(
                              icon: const Icon(Icons.align_vertical_bottom),
                              onPressed: () => textBoxProvider.changeItemOffset(
                                null,
                                841.890 - selectedItem.rec.height,
                              ),
                            ),
                          ],
                        ),
                        CustomToolbar(
                          backgroundColor: Colors.transparent,
                          axis: Axis.horizontal,
                          buttons: [
                            IconButton(
                              icon: const Icon(Icons.align_horizontal_right),
                              onPressed: () => textBoxProvider.changeItemOffset(
                                595.276 - selectedItem.rec.width,
                                null,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.align_horizontal_center),
                              onPressed: () => textBoxProvider.changeItemOffset(
                                297.638 - (selectedItem.rec.width / 2),
                                null,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.align_vertical_center),
                              onPressed: () => textBoxProvider.changeItemOffset(
                                null,
                                420.945 - (selectedItem.rec.height / 2),
                              ),
                            ),
                          ],
                        ),
                        CustomToolbar(
                          backgroundColor: Colors.transparent,
                          axis: Axis.horizontal,
                          buttons: [
                            IconButton(
                              icon: const Icon(Icons.move_down),
                              onPressed: textBoxProvider.itemMoveDown,
                            ),
                            IconButton(
                              icon: const Icon(Icons.move_up),
                              onPressed: textBoxProvider.itemMoveUp,
                            ),
                            IconButton(
                              icon: const Icon(Icons.color_lens_outlined),
                              onPressed: textBoxProvider.canSelect()
                                  ? null
                                  : () => textBoxProvider
                                      .changeTextboxStringColor(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
