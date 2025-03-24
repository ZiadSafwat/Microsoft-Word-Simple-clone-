import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:interactive_box/interactive_box.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../models/TextBoxModel.dart';
import '../services/pdfApi.dart';

class TextBoxProvider extends ChangeNotifier {
  List<TextBoxModel> textBoxModelList = [];
  bool isShapesSelectVisible = false;
  bool isLayersBarVisible = false;
  bool isBackgroundSelectVisible = false;
  bool isTooltipVisible = false;
  Map<int, Future<String>> cachedJsonStrings = {};
  String backgroundImage = '';
  Color backgroundColor = Colors.white;
  bool isGenerating = false;
  int? currentSelectedItemIndex;
  List<String> Shapes = [
    "home",
    "letter",
    "location",
    "phone",
    "world",
    'circle',
    'rect',
    'cir',
    'cir2',
    "chain",
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    's1',
    's2',
    's3',
    's4',
    's5',
    's6',
    's7',
    's8',
    's9',
    's10',
    's11',
    's12',
    's13',
    's14',
    's15',
  ];
  int localBackgroundNumber = 12;
  ThemeMode mode = ThemeMode.light;
  setMode() {
    if (mode == ThemeMode.light) {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }
    notifyListeners();
  }

  addShape(int index) {
    textBoxModelList.add(TextBoxModel(
        rec: Rect.fromLTWH(0, 0, 150, 150),
        data: Shapes[index],
        isIcon: true,
        dataColor: Colors.redAccent,
        dataRotation: 0));
    currentSelectedItemIndex = textBoxModelList.length - 1;

    notifyListeners();
  }

  addTextBox() {
    textBoxModelList.add(TextBoxModel(
      data: '',
      isIcon: false,
      dataColor: Colors.black,
      dataRotation: 0,
      rec: Rect.fromLTWH(0, 0, 150, 150),
    ));
    currentSelectedItemIndex = textBoxModelList.length - 1;
    notifyListeners();
  }

  removeTextBox() {
    textBoxModelList.removeAt(currentSelectedItemIndex!);
    notifyListeners();
    currentSelectedItemIndex = null;
  }

  selectCurrentItem(int? index) {
    currentSelectedItemIndex = index;
    notifyListeners();
  }

  changeLayersBarVisibilty(bool? value) {
    isBackgroundSelectVisible = false;
    isShapesSelectVisible = false;
    isTooltipVisible = false;
    if (value != null) {
      isLayersBarVisible = value;
    } else {
      isLayersBarVisible = !isLayersBarVisible;
    }

    notifyListeners();
  }

  changesShapesSelectionVisibilty(bool? value) {
    isBackgroundSelectVisible = false;
    isLayersBarVisible = false;
    isTooltipVisible = false;
    if (value != null) {
      isShapesSelectVisible = value;
    } else {
      isShapesSelectVisible = !isShapesSelectVisible;
    }

    notifyListeners();
  }

  changeTooltipVisibilty(bool? value) {
    isBackgroundSelectVisible = false;
    isLayersBarVisible = false;
    isShapesSelectVisible = false;
    if (value != null) {
      isTooltipVisible = value;
    } else {
      isTooltipVisible = !isTooltipVisible;
    }
    print(isTooltipVisible);
    notifyListeners();
  }

  changesBackgroundSelectionVisibilty(bool? value) {
    isShapesSelectVisible = false;
    isTooltipVisible = false;
    isLayersBarVisible = false;
    if (value != null) {
      isBackgroundSelectVisible = value;
    } else {
      isBackgroundSelectVisible = !isBackgroundSelectVisible;
    }
    notifyListeners();
  }

  changesGeneratingPdfVisibilty() {
    isGenerating = !isGenerating;
    notifyListeners();
  }

  void onReorder(oldIndex, newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = textBoxModelList.removeAt(oldIndex);
    textBoxModelList.insert(newIndex, item);
    currentSelectedItemIndex = newIndex;
    notifyListeners();
  }

  exportPdf() async {
    changesGeneratingPdfVisibilty();

    final pdfFile = await PdfApi.generateTable(
        textBoxModelList, backgroundImage, backgroundColor);

    PdfApi.openFilex(pdfFile);

    changesGeneratingPdfVisibilty();
  }

  void changeBackgroundColor(BuildContext context) {
    Future.microtask(() {
      Alert(
        context: context,
        content: Center(
          child: HueRingPicker(
            portraitOnly: true,
            pickerColor: backgroundColor,
            onColorChanged: (value) {
              backgroundColor = value;
              backgroundImage = '';
              notifyListeners();
            },
            enableAlpha: true,
            displayThumbColor: true,
          ),
        ),
      ).show();
    });
  }

  void changeTextboxStringColor(BuildContext context) {
    Future.microtask(() {
      Alert(
        context: context,
        content: Center(
          child: HueRingPicker(
            portraitOnly: true,
            pickerColor: textBoxModelList[currentSelectedItemIndex!].dataColor,
            onColorChanged: (value) {
              textBoxModelList[currentSelectedItemIndex!].dataColor = value;
              notifyListeners();
            },
            enableAlpha: true,
            displayThumbColor: true,
          ),
        ),
      ).show();
    });
  }

  updateTextData(String value) {
    if (currentSelectedItemIndex != null) {
      textBoxModelList[currentSelectedItemIndex!].data = value;
      notifyListeners();
    }
  }

//preserve current editor json state
  Future<String> getJsonString(int index, item) {
    if (!cachedJsonStrings.containsKey(index)) {
      cachedJsonStrings[index] =
          Future.value(jsonEncode(item.editorState.document.toJson()));
    }
    return cachedJsonStrings[index]!;
  }

  changeState(EditorState editorState, int index) {
    textBoxModelList[index].editorState = editorState;
    notifyListeners();
  }

  changeItemPhysicalData(double rotation, Rect rec, int index) {
    selectCurrentItem(index);
    textBoxModelList[index].dataRotation = rotation;
    textBoxModelList[index].rec = rec;

    notifyListeners();
  }

  chooseBackground(String value) {
    backgroundImage = value;
    notifyListeners();
  }

  void changeItemOffset(double? dx, double? dy) {
    if (currentSelectedItemIndex == null) return;

    final item = textBoxModelList[currentSelectedItemIndex!];

    dx = dx ?? item.rec.left;
    dy = dy ?? item.rec.top;

    // Correctly update the Rect position
    item.rec = Rect.fromLTWH(dx, dy, item.rec.width, item.rec.height);

    notifyListeners();
  }

  itemMoveDown() {
    if (currentSelectedItemIndex != null) {
      int index = currentSelectedItemIndex!;
      if (index > 0) {
        var selectedItem = textBoxModelList[index];

        textBoxModelList[index] = textBoxModelList[index - 1];
        textBoxModelList[index - 1] = selectedItem;
        currentSelectedItemIndex = index - 1;
        notifyListeners();
      }
    }
  }

  itemMoveUp() {
    if (currentSelectedItemIndex != null) {
      int? index = currentSelectedItemIndex;
      if (index! < textBoxModelList.length - 1) {
        var selectedItem = textBoxModelList[index];
        textBoxModelList[index] = textBoxModelList[index + 1];
        textBoxModelList[index + 1] = selectedItem;
        currentSelectedItemIndex = index + 1;

        notifyListeners();
      }
    }
  }
void copyItem(int index){
    TextBoxModel textBoxModel=textBoxModelList[index];
    textBoxModel.rec=Rect.fromLTWH(textBoxModel.rec.left+10, textBoxModel.rec.top+10, textBoxModel.rec.size.width, textBoxModel.rec.size.height );

    textBoxModelList.add(textBoxModel);
    notifyListeners();
}

  List<ControlActionType> checkVisibleHandlers(int index) {
    if (currentSelectedItemIndex != null) {
      // Show all handles when selected
      if (index == currentSelectedItemIndex) {
        return [
          ControlActionType.move,
          ControlActionType.copy,
          ControlActionType.scale,
          ControlActionType.delete,
          ControlActionType.rotate,
        ];
      } else {
        return [ControlActionType.move]; // Hide handles when not selected
      }
    }
    return [ControlActionType.move]; // Hide handles when not selected
  }

  bool canSelect() {
    if (currentSelectedItemIndex == null) {
      return false;
    } else if (textBoxModelList[currentSelectedItemIndex!].isIcon) {
      return false;
    } else {
      return true;
    }
  }
}
