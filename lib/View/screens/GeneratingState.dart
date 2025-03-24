import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Core/viewModels/TextBoxProvider.dart';

class GeneratingState extends StatelessWidget {
  const GeneratingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TextBoxProvider>(
      builder: (context, textBoxProvider, _) {
        // If not generating, return an empty widget
        if (!textBoxProvider.isGenerating) return SizedBox.shrink();

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
