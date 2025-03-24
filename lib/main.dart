import 'package:flutter/material.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter_cv_maker/Core/viewModels/TextBoxProvider.dart';
import 'package:flutter_cv_maker/View/screens/customCVMake.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'Core/consts/appColors.dart';
import 'View/helperWidgets/pages/editor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(A4DocumentApp());
}

class A4DocumentApp extends StatefulWidget {
  @override
  _A4DocumentAppState createState() => _A4DocumentAppState();
}

class _A4DocumentAppState extends State<A4DocumentApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TextBoxProvider()),
      ],
      child: Consumer<TextBoxProvider>(
        builder: (context, textBoxProvider, child) {
          return MaterialApp(
            title: 'A4 Document Editor',
            themeMode: textBoxProvider.mode, // Ensures proper theme update
            theme: myTheme(Brightness.light),
            darkTheme: myTheme(Brightness.dark),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppFlowyEditorLocalizations.delegate,
            ],
            home: const EditorScreen(),
          );
        },
      ),
    );
  }
}

// Scaffold(
//   appBar: AppBar(
//     title: const Text("Dynamic A4 Document with AppFlowy Editor"),
//   ),
//
//   body: Column(
//     children: [
//
//       // Custom Toolbar (Example with basic buttons)
//       // Container(
//       //   color: toolbarColor,
//       //   child: Padding(
//       //     padding: const EdgeInsets.all(8.0),
//       //     child: Row(
//       //       children: [
//       //         IconButton(
//       //           icon: const Icon(Icons.format_bold),
//       //           onPressed: () {
//       //             // Add logic to toggle bold formatting
//       //             debugPrint("Bold button clicked");
//       //           },
//       //         ),
//       //         IconButton(
//       //           icon: const Icon(Icons.format_italic),
//       //           onPressed: () {
//       //             // Add logic to toggle italic formatting
//       //             debugPrint("Italic button clicked");
//       //           },
//       //         ),
//       //         // Add more toolbar buttons as needed
//       //       ],
//       //     ),
//       //   ),
//       // ),
//       Expanded(
//         child: Center(
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               double screenWidth = constraints.maxWidth;
//               double screenHeight = constraints.maxHeight;
//
//               double a4AspectRatio = 1 / 1.414;
//               double containerWidth = screenWidth * 0.9;
//               double containerHeight = containerWidth / a4AspectRatio;
//
//               if (containerHeight > screenHeight * 0.9) {
//                 containerHeight = screenHeight * 0.9;
//                 containerWidth = containerHeight * a4AspectRatio;
//               }
//
//               return SingleChildScrollView(
//                 child: Center(
//                   child: Container(
//                     width: containerWidth,
//                     height: containerHeight,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 10,
//                           offset: Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: FutureBuilder<String>(
//                         future: Future.value(
//                             "{\"document\":{\"type\":\"page\",\"children\":[{\"type\":\"paragraph\",\"data\":{\"delta\":[{\"insert\":\"sad ss\"}]}}]}}"), // Provide valid JSON here
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           } else if (snapshot.hasError) {
//                             return Center(
//                               child: Text(
//                                 "Error loading content: ${snapshot.error}",
//                                 style: const TextStyle(color: Colors.red),
//                               ),
//                             );
//                           } else if (snapshot.hasData) {
//                             return Editor(
//                               editorStyle:
//                                   UniversalPlatform.isDesktopOrWeb
//                                       ? const EditorStyle.desktop()
//                                       : const EditorStyle.mobile(),
//                               jsonString:  Future.value(snapshot.data),
//                               onEditorStateChange: (newState) {
//                                 // Handle editor state changes here
//                                 debugPrint("Editor state changed");
//                               },
//                             );
//                           } else {
//                             return const Center(
//                               child: Text("No content available."),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     ],
//   ),
// ),