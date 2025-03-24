import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Core/viewModels/TextBoxProvider.dart';

class ShapesSelectionBar extends StatelessWidget {
  const ShapesSelectionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TextBoxProvider>(
      builder: (context, textBoxProvider, _) {
        if (!textBoxProvider.isShapesSelectVisible) {
          return const SizedBox.shrink(); // Hide when not needed
        }

        return DraggableScrollableSheet(
          initialChildSize: 0.4, // Default open height (40%)
          minChildSize: 0.3, // Can shrink to 30%
          maxChildSize: 0.7, // Can expand to 70%
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Drag handle
                  Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // Tab Bar (Stickers & Emojis)
                  DefaultTabController(
                    length: 2,
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.blue,
                            tabs: const [
                              Tab(icon: Icon(Icons.image), text: "Stickers"),
                              Tab(
                                  icon: Icon(Icons.format_color_fill_sharp),
                                  text: "Backgrounds"),
                            ],
                          ),

                          // Expandable content (scrolls inside the sheet)
                          Expanded(
                            child: TabBarView(
                              children: [
                                // Stickers Tab
                                GridView.builder(
                                  controller:
                                      scrollController, // Enables scrolling inside the sheet
                                  padding: const EdgeInsets.all(10),
                                  itemCount: textBoxProvider.Shapes.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width < 600
                                            ? 4
                                            : 6, // Responsive
                                    childAspectRatio: 1,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        textBoxProvider.addShape(index);
                                      },
                                      child: Image.asset(
                                        "assets/png/${textBoxProvider.Shapes[index]}.png",
                                        fit: BoxFit.contain,
                                      ),
                                    );
                                  },
                                ),
                                GridView.builder(
                                  controller:
                                      scrollController, // Enables scrolling inside the sheet
                                  padding: const EdgeInsets.all(10),
                                  itemCount:
                                      textBoxProvider.localBackgroundNumber +
                                          1, // +1 for the extra item
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width < 600
                                            ? 4
                                            : 6, // Responsive
                                    childAspectRatio: 1,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, i) {
                                    if (i == 0) {
                                      // ✅ Constant Item (E.g., "No Background" option)
                                      return InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: () {
                                          textBoxProvider
                                              .changeBackgroundColor(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .grey[300], // Placeholder color
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                              Icons.color_lens_outlined,
                                              size: 40,
                                              color: Colors
                                                  .black54), // A clear icon
                                        ),
                                      );
                                    } else {
                                      // 🔥 Dynamically Loaded Backgrounds
                                      return InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: () {
                                          textBoxProvider.chooseBackground(
                                              (i - 1)
                                                  .toString()); // Adjust index
                                        },
                                        child: Image.asset(
                                          fit: BoxFit.cover,
                                          "assets/png/${i - 1}.png",
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
