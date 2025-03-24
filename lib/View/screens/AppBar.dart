import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Core/viewModels/TextBoxProvider.dart';
import 'ControlButtons.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TextBoxProvider>(
      builder: (context, textBoxProvider, _) {
        bool isSelected = textBoxProvider.currentSelectedItemIndex != null;

        return AppBar(
         centerTitle: true,
          title: SingleChildScrollView(scrollDirection: Axis.horizontal,
            child: CustomToolbar(
              backgroundColor: Colors.transparent,
              buttons: [
                Text(
                  isSelected
                      ? 'Item ${textBoxProvider.currentSelectedItemIndex}'
                      : "No item selected",
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  onPressed: isSelected
                      ? () => textBoxProvider.changeTooltipVisibilty(null)
                      : null,
                  icon: const Icon(Icons.settings_suggest_sharp),
                  tooltip: "Edit Tooltip",
                ),
                IconButton(
                  onPressed: textBoxProvider.addTextBox,
                  icon: const Icon(Icons.format_shapes),
                  tooltip: "Add Text Box",
                ),
                IconButton(
                  onPressed: isSelected
                      ? () => textBoxProvider.removeTextBox()
                      : null,
                  icon: const Icon(Icons.delete_forever),
                  tooltip: "Remove Selected Item",
                ),
                IconButton(
                  onPressed: () =>
                      textBoxProvider.changeLayersBarVisibilty(null),
                  icon: Icon(textBoxProvider.isLayersBarVisible?Icons.layers:Icons.layers_clear),
                  tooltip: "Change Shape Selection",
                ),
                IconButton(
                  onPressed: () =>
                      textBoxProvider.changesShapesSelectionVisibilty(null),
                  icon: const Icon(Icons.imagesearch_roller),
                  tooltip: "Change Shape Selection",
                ),

                IconButton(
                  onPressed: textBoxProvider.exportPdf,
                  icon: const Icon(Icons.picture_as_pdf),
                  tooltip: "Export to PDF",
                ),
                IconButton(
                  onPressed: textBoxProvider.setMode,
                  icon: Icon(
                    textBoxProvider.mode == ThemeMode.light
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                  tooltip: "Toggle Theme",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
