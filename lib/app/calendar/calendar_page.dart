import 'package:auto_route/auto_route.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:image_delete_demo/core/router/router.dart';
import 'package:image_delete_demo/core/theme/button.dart';
import 'package:image_delete_demo/core/widgets/custom_appbar.dart';

@RoutePage()
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final entries =
        context.watch<GalleryAssetsCubit>().state.groupedByMonth.entries;
    return Scaffold(
      appBar: CustomAppbar(),
      extendBody: true,
      body: SafeArea(
        top: false,
        child: FadingEdgeScrollView.fromSingleChildScrollView(
          child: SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.vertical,
            child: Column(
              spacing: 12,
              children: [
                ...entries.map(
                  (entry) => StyledButton.filled(
                    title: "${entry.key} (${entry.value.length})",
                    onPressed: () {
                      context.router.push(MonthSwiperRoute(month: entry.key));
                    },
                    fullWidth: true,
                  ).p(horizontal: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
