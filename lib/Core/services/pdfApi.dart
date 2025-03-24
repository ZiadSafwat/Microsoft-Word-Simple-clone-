import 'dart:io';
import 'package:appflowy_editor/appflowy_editor.dart' as Ap;
import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../models/TextBoxModel.dart';

class PdfApi {
//////////////////////////////////////////////////////////////////

  static Future<File> generateTable(List<TextBoxModel> textBoxModelList,
      String backgroundImage, Color backgroundColor) async {
    // Preload all SVG contents
    Map<String, String> loadedSvgData = {};

    for (var textBox in textBoxModelList) {
      if (textBox.isIcon) {
        String svgPath = 'assets/svg/${textBox.data}.svg';
        loadedSvgData[textBox.data] = await rootBundle.loadString(svgPath);
      }
    }
    // Load Quill Text Widgets
     List<Future<Widget?>> widgetFutures = textBoxModelList.map((textBox) async {
      if (!textBox.isIcon && textBox.editorState != null) {
        try {
          List<Widget> pwWidgets = await HTMLToPdf().convert(Ap.documentToHTML(textBox.editorState.document));

          return pwWidgets.isNotEmpty ? Column(children: pwWidgets) :   SizedBox();
        } catch (e) {
      //    debugPrint("Error converting text box: $e");
          return SizedBox(); // Default widget in case of error
        }
      }
      return   SizedBox();
    }).toList();

    List<Widget?> loadedTextWidgets = await Future.wait(widgetFutures);

    var backgroundImageSvg = backgroundImage.isEmpty
        ? ""
        : await rootBundle.loadString('assets/svg/${backgroundImage}.svg');

    final myTheme = ThemeData.withFont(
      base: Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("assets/fonts/Roboto-Bold.ttf")),
      italic: Font.ttf(await rootBundle.load("assets/fonts/Roboto-Italic.ttf")),
      boldItalic: Font.ttf(await rootBundle.load("assets/fonts/Roboto-BoldItalic.ttf")),
      fontFallback: [
       // Font.ttf(await rootBundle.load("assets/fonts/Amiri-Regular.ttf")), // Arabic font fallback
      ],
    );

    final pdf = Document(theme: myTheme);

    pdf.addPage(Page(
      pageFormat: PdfPageFormat.a4,
      margin: EdgeInsets.zero,
      build: (Context context) {
        return Stack(
          children: [
            backgroundImage == ""
                ? Opacity(
                    opacity: backgroundColor.opacity,
                    child: Container(
                      color: PdfColor(
                        backgroundColor.r,
                        backgroundColor.g,
                        backgroundColor.b,
                      ),
                      width: double.infinity,
                      height: double.infinity,
                    ))
                : SvgImage(
                    svg: backgroundImageSvg,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            for (int i=0;i<textBoxModelList.length;i++)
              Positioned(
                top: textBoxModelList[i].rec.top,
                left: textBoxModelList[i].rec.left,
                child: Transform.rotate(
                  angle: -textBoxModelList[i].dataRotation,
                  child: Container(
                    alignment: Alignment.center,
                    height: textBoxModelList[i].rec.height,
                    width: textBoxModelList[i].rec.width,
                    child: Opacity(
                      opacity: textBoxModelList[i].dataColor.opacity,
                      child: textBoxModelList[i].isIcon
                          ? SvgImage(
                              width: textBoxModelList[i].rec.width,
                              height: textBoxModelList[i].rec.height,
                              fit: BoxFit.fill,
                              colorFilter: PdfColor(
                                textBoxModelList[i].dataColor.r,
                                textBoxModelList[i].dataColor.g,
                                textBoxModelList[i].dataColor.b,
                              ),
                              svg: loadedSvgData[textBoxModelList[i].data] ??
                                  "", // Use preloaded SVG
                            )
                          : loadedTextWidgets[i] ?? SizedBox(),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    ));

    return saveDocument(name: 'my_pdf.pdf', pdf: pdf);
  }

  //////////////////////////////////////////////////////////////////////

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFilex(File file) async {
    final url = file.path;
    await OpenFilex.open(url);
  }
  // Future<pw.Widget> buildPdfTextBox(TextBoxModel textBox) async {
  //   final pdfDocument = await QuillToPdfConverter().convert(
  //     textBox.controller.document,
  //
  //   );
  //
  //   return pw.Container(
  //     width: textBox.rec.width,
  //     height: textBox.rec.height,
  //     alignment: pw.Alignment.center,
  //     child: pdfDocument,
  //   );
  // }
}

extension PdfColorExtension on PdfColor {
  PdfColor flattenWithBackground(PdfColor background) {
    return PdfColor(
      alpha * red + (1 - alpha) * background.red,
      alpha * green + (1 - alpha) * background.green,
      alpha * blue + (1 - alpha) * background.blue,
    );
  }
}

final flattenedColor =
    PdfColor(0.2, 0.4, 0.4, 0.1).flattenWithBackground(PdfColors.white);

// if (backgroundModel.imageString != "")
//   Positioned(
//     top: backgroundModel.imageOffset.dy,
//     left: backgroundModel.imageOffset.dx,
//     child: Transform.rotate(
//         angle: -backgroundModel.imageRotation,
//         child: Container(
//           alignment: Alignment.center,
//           height: imageSize.height,
//           width: imageSize.width,
//           child: ClipOval(
//               child: Image(
//                   MemoryImage(
//                     File(imageString).readAsBytesSync(),
//                   ),
//                   height: imageSize.height,
//                   width: imageSize.width,
//                   fit: BoxFit.contain)),
//         )),
//   )
