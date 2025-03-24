import 'dart:ui'; // Required for BackdropFilter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Core/viewModels/TextBoxProvider.dart';

// class TextBoxToolTip extends StatelessWidget {
//   const TextBoxToolTip({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TextBoxProvider>(
//       builder: (context, textBoxProvider, _) {
//         // Ensure a valid return if tooltip is not visible or no item is selected
//         if (textBoxProvider.currentSelectedItemIndex == null) {
//           return Container(
//               alignment: Alignment.centerLeft, child: SizedBox.shrink());
//         }
//         final selectedItem = textBoxProvider
//             .textBoxModelList[textBoxProvider.currentSelectedItemIndex!];
//
//         if (selectedItem.isIcon) {
//           return Container(
//               alignment: Alignment.centerLeft, child: SizedBox.shrink());
//         }
//
//         return Expanded(
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: FractionallySizedBox(
//               alignment: Alignment.centerRight,
//               widthFactor: 1,
//               heightFactor: 1,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//                 child: Card(
//                   elevation: 0.1,
//                   color: Colors.white.withAlpha(125),
//                   margin: const EdgeInsets.all(5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: SingleChildScrollView(
//                     child: QuillSimpleToolbar(
//                       controller: selectedItem.controller,
//                       config: const QuillSimpleToolbarConfig(
//                           showBackgroundColorButton: true,
//                           showCodeBlock: true,
//                           showRightAlignment: true,
//                           showLineHeightButton: true,
//                           showCenterAlignment: true,
//                           showDirection: true,
//                           showDividers: true,
//                           showQuote: true,
//                           showFontSize: true,
//                           showIndent: true,
//                           showJustifyAlignment: true,
//                           showAlignmentButtons: true,
//                           multiRowsDisplay: true,
//                           showHeaderStyle: true,
//                           showSmallButton: true,
//                           showStrikeThrough: true,
//                           showLeftAlignment: true),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
