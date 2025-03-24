import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:flutter_cv_maker/Core/viewModels/TextBoxProvider.dart';
import 'package:flutter_cv_maker/View/helperWidgets/pages/editor.dart';
import 'package:flutter_cv_maker/View/screens/AppBar.dart';
import 'package:flutter_cv_maker/View/screens/BackgroundSelectionBar.dart';
import 'package:flutter_cv_maker/View/screens/GeneratingState.dart';
import 'package:flutter_cv_maker/View/screens/LayesEditsBar.dart';
import 'package:flutter_cv_maker/View/screens/MoreSettings.dart';
import 'package:flutter_cv_maker/View/screens/RemoveVisibilityButton.dart';
import 'package:flutter_cv_maker/View/screens/ShapesSelectionBar.dart';
import 'package:interactive_box/interactive_box.dart';
import 'package:provider/provider.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: InteractiveViewer(
                      maxScale: 3.0,
                      minScale: 0.5,
                      boundaryMargin: EdgeInsets.all(50),
                      child: Center(
                        child: FittedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                width: 595.276,
                                height: 841.890,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Consumer<TextBoxProvider>(
                                    builder: (context, textBoxProvider, _) {
                                  return Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<TextBoxProvider>()
                                              .selectCurrentItem(null);
                                          FocusScope.of(context).unfocus();
                                        },
                                        child: textBoxProvider
                                                .backgroundImage.isEmpty
                                            ? Container(
                                                color: context
                                                    .read<TextBoxProvider>()
                                                    .backgroundColor)
                                            : Image.asset(
                                                'assets/png/${textBoxProvider.backgroundImage}.png',
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                      for (int i = 0;
                                          i <
                                              textBoxProvider
                                                  .textBoxModelList.length;
                                          i++)
                                        InteractiveBox(
                                          initialSize: textBoxProvider
                                              .textBoxModelList[i].rec.size,
                                          onTap: () => textBoxProvider
                                              .selectCurrentItem(i),
                                          defaultScaleBorderDecoration:
                                              BoxDecoration(
                                            border: Border.all(
                                              width: 5,
                                              color: Colors.purple[700]!,
                                            ),
                                            shape: BoxShape.rectangle,
                                          ),
                                          onActionSelected:
                                              (actionType, boxInfo) {
                                            if (actionType ==
                                                ControlActionType.copy) {
                                              textBoxProvider.copyItem(i);
                                            } else if (actionType ==
                                                ControlActionType.delete) {
                                              textBoxProvider.removeTextBox();
                                            }
                                          },
                                          initialPosition: Offset(
                                              textBoxProvider
                                                  .textBoxModelList[i].rec.left,
                                              textBoxProvider
                                                  .textBoxModelList[i].rec.top),
                                          includedActions: textBoxProvider
                                              .checkVisibleHandlers(i),
                                          initialRotateAngle: textBoxProvider
                                              .textBoxModelList[i].dataRotation,
                                          onInteractiveActionPerformed:
                                              (_, importantData, __) {
                                            textBoxProvider
                                                .changeItemPhysicalData(
                                                    importantData.rotateAngle,
                                                    Rect.fromLTWH(
                                                        importantData
                                                            .position.dx,
                                                        importantData
                                                            .position.dy,
                                                        importantData
                                                            .size.width,
                                                        importantData
                                                            .size.height),
                                                    i);
                                          },
                                          child: textBoxProvider
                                                  .textBoxModelList[i].isIcon
                                              ? FittedBox(
                                                  fit: BoxFit.fill,
                                                  child: Center(
                                                    child: textBoxProvider
                                                                .textBoxModelList[
                                                                    i]
                                                                .dataColor
                                                                .a ==
                                                            0
                                                        ? Image.asset(
                                                            "assets/png/${textBoxProvider.textBoxModelList[i].data}.png")
                                                        : ColorFiltered(
                                                            colorFilter:
                                                                ColorFilter
                                                                    .mode(
                                                              textBoxProvider
                                                                  .textBoxModelList[
                                                                      i]
                                                                  .dataColor,
                                                              BlendMode.srcIn,
                                                            ),
                                                            child: Image.asset(
                                                                "assets/png/${textBoxProvider.textBoxModelList[i].data}.png"),
                                                          ),
                                                  ),
                                                )
                                              : Container(
                                                  //  margin: const EdgeInsets.all(10),
                                                  width: textBoxProvider
                                                      .textBoxModelList[i]
                                                      .rec
                                                      .width,
                                                  height: textBoxProvider
                                                      .textBoxModelList[i]
                                                      .rec
                                                      .height,
                                                  child: FutureBuilder<String>(
                                                    future: textBoxProvider
                                                        .getJsonString(
                                                            i,
                                                            textBoxProvider
                                                                .textBoxModelList[i]),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (!snapshot.hasData) {
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      }
                                                      return Editor(
                                                        jsonString:
                                                            snapshot.data!,
                                                        onEditorStateChange:
                                                            (editorState) {
                                                          WidgetsBinding
                                                              .instance
                                                              .addPostFrameCallback(
                                                                  (_) {
                                                            textBoxProvider
                                                                .changeState(
                                                                    editorState,
                                                                    i);
                                                          });
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                        )
                                    ],
                                  );
                                })),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const RemoveVisibilityButton(),
            const ShapesSelectionBar(),
            const BackgroundSelectionBar(),
            const MoreSettings(),
            const LayesEditsBar(),
            const GeneratingState(),
          ],
        ),
      ),
    );
  }
}
