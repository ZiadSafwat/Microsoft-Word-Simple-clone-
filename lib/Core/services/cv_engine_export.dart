import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cv_maker/Core/models/cvDataModel.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart' as p;
import 'package:pdf/widgets.dart';

class PdfGenerator {
  final CvModel cvModel;

  PdfGenerator(this.cvModel);

  Future<void> exportToPdf() async {

      var myTheme = pw.ThemeData.withFont(
        base: Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf")),
        bold: Font.ttf(await rootBundle.load("assets/fonts/Roboto-Bold.ttf")),
        italic: Font.ttf(await rootBundle.load("assets/fonts/Roboto-Italic.ttf")),
        boldItalic:
        Font.ttf(await rootBundle.load("assets/fonts/Roboto-BoldItalic.ttf")),
      );

      final pdf = Document(
        theme: myTheme,
      );

    // Add the first page
    pdf.addPage(
      pw.Page(

        pageFormat: p.PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Stack(
              children: _buildComponents(cvModel),
            ),
          );
        },
      ),
    );

    // Save PDF to a file
    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/CV.pdf");
    await file.writeAsBytes(await pdf.save());
    if (kDebugMode) {
      print("PDF saved at ${file.path}");
    }
    await OpenFilex.open(file.path);
  }

  // Build components from CvModel
  List<pw.Widget> _buildComponents(CvModel model) {
    List<pw.Widget> widgets = [];

    // Add Contact Information if present
    if (model.contactInformation != null) {
      widgets.addAll(_buildContactInformation(model.contactInformation!));
    }

    // Add Professional Summary if present
    if (model.professionalSummary != null) {
      widgets.add(_buildTextComponent(model.professionalSummary!));
    }

    // Add Work Experience if present
    if (model.workExperience != null && model.workExperience!.isNotEmpty) {
      for (var experience in model.workExperience!) {
        widgets.addAll(_buildWorkExperience(experience));
      }
    }

    // Add Education if present
    if (model.education != null && model.education!.isNotEmpty) {
      for (var edu in model.education!) {
        widgets.addAll(_buildEducation(edu));
      }
    }

    // Add Skills if present
    if (model.skills != null) {
      widgets.addAll(_buildSkills(model.skills!));
    }

    return widgets;
  }

  // Build Contact Information if present
  List<pw.Widget> _buildContactInformation(ContactInformation info) {
    List<pw.Widget> widgets = [];
    final fields = [
      info.fullName,
      info.phoneNumber,
      info.email,
      info.linkedin,
      info.address,
    ];
    for (var field in fields) {
      if (field != null && field.value != null && field.value!.isNotEmpty) {
        widgets.add(_buildTextComponent(field));
      }
    }
    return widgets;
  }

  // Build Work Experience if present
  List<pw.Widget> _buildWorkExperience(WorkExperience experience) {
    List<pw.Widget> widgets = [];

    if (experience.jobTitle != null && experience.jobTitle!.value != null) {
      widgets.add(_buildTextComponent(experience.jobTitle!));
    }
    if (experience.company != null && experience.company!.value != null) {
      widgets.add(_buildTextComponent(experience.company!));
    }
    if (experience.location != null && experience.location!.value != null) {
      widgets.add(_buildTextComponent(experience.location!));
    }
    if (experience.employmentDates != null) {
      if (experience.employmentDates!.start != null &&
          experience.employmentDates!.start!.value != null) {
        widgets.add(_buildTextComponent(experience.employmentDates!.start!));
      }
      if (experience.employmentDates!.end != null &&
          experience.employmentDates!.end!.value != null) {
        widgets.add(_buildTextComponent(experience.employmentDates!.end!));
      }
    }
    if (experience.responsibilities != null &&
        experience.responsibilities!.isNotEmpty) {
      for (var responsibility in experience.responsibilities!) {
        if (responsibility.value != null && responsibility.value!.isNotEmpty) {
          widgets.add(_buildTextComponent(responsibility));
        }
      }
    }
    return widgets;
  }

  // Build Education if present
  List<pw.Widget> _buildEducation(Education edu) {
    List<pw.Widget> widgets = [];

    if (edu.degree != null && edu.degree!.value != null) {
      widgets.add(_buildTextComponent(edu.degree!));
    }
    if (edu.institution != null && edu.institution!.value != null) {
      widgets.add(_buildTextComponent(edu.institution!));
    }
    if (edu.location != null && edu.location!.value != null) {
      widgets.add(_buildTextComponent(edu.location!));
    }
    if (edu.graduationDate != null && edu.graduationDate!.value != null) {
      widgets.add(_buildTextComponent(edu.graduationDate!));
    }

    return widgets;
  }

  // Build Skills if present
  List<pw.Widget> _buildSkills(Skills skills) {
    List<pw.Widget> widgets = [];

    if (skills.technicalSkills != null && skills.technicalSkills!.isNotEmpty) {
      for (var skill in skills.technicalSkills!) {
        if (skill.value != null && skill.value!.isNotEmpty) {
          widgets.add(_buildTextComponent(skill));
        }
      }
    }

    if (skills.interpersonalSkills != null &&
        skills.interpersonalSkills!.isNotEmpty) {
      for (var skill in skills.interpersonalSkills!) {
        if (skill.value != null && skill.value!.isNotEmpty) {
          widgets.add(_buildTextComponent(skill));
        }
      }
    }

    return widgets;
  }

  // Generic Text Component Builder with null checks
  pw.Widget _buildTextComponent(ProfessionalSummary component) {
    if (component.value == null || component.value!.isEmpty) {
      return pw.SizedBox
          .shrink(); // If there's no value, return an empty widget
    }

    return pw.Positioned(
      left: component.componentPlaceInX?.toDouble() ?? 0.0,
      top: component.componentPlaceInY?.toDouble() ?? 0.0,
      child: pw.Container(
          width: component.componentWidth?.toDouble(),
          height: component.componentHeight?.toDouble(),
          child: pw.FittedBox(fit: pw.BoxFit.contain,
            child: pw.Text(
              component.value ?? "",
              style: pw.TextStyle(
                fontSize: component.font?.toDouble() ?? 12.0,
                fontWeight: component.isBold == IsBold.YES
                    ? pw.FontWeight.bold
                    : pw.FontWeight.normal,
                color: _getColor(component.color),
              ),
            ),
          )),
    );
  }

  // Helper to convert Color enum to PdfColor
  p.PdfColor _getColor(Color? color) {
    switch (color) {
      case Color.THE_000000:
        return p.PdfColor.fromHex("#000000");
      case Color.THE_0000_FF:
        return p.PdfColor.fromHex("#0000FF");
      case Color.THE_333333:
        return p.PdfColor.fromHex("#333333");
      case Color.THE_555555:
        return p.PdfColor.fromHex("#555555");
      default:
        return p.PdfColor.fromHex("#000000");
    }
  }
}
