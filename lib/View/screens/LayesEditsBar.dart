import 'dart:ui';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Core/viewModels/TextBoxProvider.dart';

class LayesEditsBar extends StatelessWidget {
  const LayesEditsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TextBoxProvider>(
      builder: (context, textBoxProvider, _) {
        if (!textBoxProvider.isLayersBarVisible) return SizedBox.shrink();

        return Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.45,
            heightFactor: 1,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black.withAlpha(125),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ReorderableListView(
                        onReorderStart: (index) {
                          textBoxProvider.selectCurrentItem(index);
                        },
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        onReorder: (oldIndex, newIndex) {
                          textBoxProvider.onReorder(oldIndex, newIndex);
                        },
                        padding: const EdgeInsets.all(10),
                        children: List.generate(
                          textBoxProvider.textBoxModelList.length,
                          (i) {
                            final item = textBoxProvider.textBoxModelList[i];

                            return Card(
                              key: ValueKey(item),
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ReorderableDragStartListener(
                                index: i,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Colors.white,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Center(
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                            item.dataColor,
                                            BlendMode.srcIn,
                                          ),
                                          child: item.isIcon
                                              ? Image.asset(
                                                  "assets/png/${item.data}.png",
                                                )
                                              : Icon(Icons.text_fields),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
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
