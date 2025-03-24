import 'dart:ui';

import 'package:appflowy_editor/appflowy_editor.dart';


class TextBoxModel {
  String data;
  var editorState = EditorState.blank(withInitialText: true);
  Color dataColor;
  double dataRotation;
  bool isIcon;
  Rect rec;

  TextBoxModel({
    required this.isIcon,
    required this.dataColor,
    required this.dataRotation,
    required this.rec,
    required this.data,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        "isIcon": isIcon, "data": data,
        "dataColor": dataColor.value, // Store Color as an integer
        "dataRotation": dataRotation,
        "rec": {
          "dataOffset": {"dx": rec.left, "dy": rec.top},
          "dataSize": {"width": rec.width, "height": rec.height},
        }, // Store Rect as nested values
      };

  // Convert from JSON
  factory TextBoxModel.fromJson(Map<String, dynamic> json) {
    return TextBoxModel(
      isIcon: json["isIcon"], // Boolean value
      dataColor: Color(json["dataColor"]), // Convert stored int back to Color
      dataRotation: json["dataRotation"].toDouble(), // Ensure it's a double
      data: json["data"],
      rec: Rect.fromLTWH(
        json["rec"]["dataOffset"]["dx"],
        json["rec"]["dataOffset"]["dy"],
        json["rec"]["dataSize"]["width"],
        json["rec"]["dataSize"]["height"],
      ), // Reconstruct Rect from nested data
    );
  }
}
