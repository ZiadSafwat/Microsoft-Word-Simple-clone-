import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Core/viewModels/TextBoxProvider.dart';
import 'ControlButtons.dart';

class RemoveVisibilityButton extends StatelessWidget {
  const RemoveVisibilityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TextBoxProvider>(
      builder: (context, textBoxProvider, _) {
        bool isAnyVisible = textBoxProvider.isShapesSelectVisible ||
            textBoxProvider.isBackgroundSelectVisible ||
            textBoxProvider.isTooltipVisible||textBoxProvider.isLayersBarVisible;

        if (!isAnyVisible) return SizedBox.shrink(); // Ensures no empty return

        return MaterialButton(
          onPressed: () {
            textBoxProvider.changesShapesSelectionVisibilty(false);
            textBoxProvider.changesBackgroundSelectionVisibilty(false);
            textBoxProvider.changeTooltipVisibilty(false);
          },
          height: double.infinity,
          minWidth: double.infinity,

        );
      },
    );
  }
}
