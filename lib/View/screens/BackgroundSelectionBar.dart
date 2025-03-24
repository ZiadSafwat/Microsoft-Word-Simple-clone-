import 'dart:ui'; // Required for BackdropFilter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Core/viewModels/TextBoxProvider.dart';

class BackgroundSelectionBar extends StatelessWidget {
  const BackgroundSelectionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TextBoxProvider>(
      builder: (context, textBoxProvider, _) {
        if (!textBoxProvider.isBackgroundSelectVisible) return SizedBox.shrink(); // Ensure a valid return

        return  Align(alignment:Alignment.centerLeft,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.5,
            heightFactor: 1,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Container(color: Colors.black.withAlpha(75),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              textBoxProvider
                                  .changeBackgroundColor(context);
                            },
                            child: Icon(
                              Icons.color_lens_outlined,
                              size: MediaQuery.of(context).size.height *
                                  0.2,
                            )),
                      ),
                      for (int i = 0;
                      i < textBoxProvider.localBackgroundNumber;
                      i++)
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                textBoxProvider
                                    .chooseBackground(i.toString());
                              },
                              child: Image.asset(
                                  scale:
                                  MediaQuery.of(context).size.height *
                                      0.004,
                                  "assets/png/$i.png")),
                        )
                    ],
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
