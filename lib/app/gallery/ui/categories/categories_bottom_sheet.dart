import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:ruko/core/router/router.gr.dart';
import 'package:ruko/core/theme/modals/scrollable_sheet_page.dart';
import 'package:ruko/core/theme/text_extension.dart';

@RoutePage()
class CategoriesBottomSheetPage extends StatelessWidget {
  const CategoriesBottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableSheetPage(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            spacing: 8,
            children: [
              ListTile(
                leading: Icon(Pixel.calendar),
                title: const Text("months").bodySmall(),
                onTap: () {
                  HapticFeedback.selectionClick();
                  context.router.push(const MonthsRoute());
                },
              ),
              ListTile(
                leading: Icon(Pixel.map),
                title: const Text("places").bodySmall(),
                onTap: () {
                  HapticFeedback.selectionClick();
                  context.router.push(const LocationsRoute());
                },
              ),
              ListTile(
                leading: Icon(Pixel.shuffle),
                title: const Text("shuffled").bodySmall(),
                onTap: () {
                  HapticFeedback.selectionClick();
                  context.router.push(const ShuffledAssetsRoute());
                },
              ),
              ListTile(
                leading: Icon(Pixel.calendararrowleft),
                title: const Text("oldest first").bodySmall(),
                onTap: () {
                  HapticFeedback.selectionClick();
                  context.router.push(const OldAssetsFirstRoute());
                },
              ),
              ListTile(
                leading: Icon(Pixel.group),
                title: const Text("albums").bodySmall(),
                onTap: () {
                  HapticFeedback.selectionClick();
                  context.router.push(const AlbumsRoute());
                },
              ),
              ListTile(
                leading: Icon(Pixel.video),
                title: const Text("videos only").bodySmall(),
                onTap: () {
                  HapticFeedback.selectionClick();
                  context.router.push(const VideosOnlyRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
