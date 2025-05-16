import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/categories/categories_page.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
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
      body: SafeArea(
        top: false,
        child: GridView.builder(
          controller: controller,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries.elementAt(index);
            final asset = entry.value.first;
            final second = entry.value.elementAtOrNull(1);

            final date = entry.value.first.createDateTime;
            final month = date.format('MMMM');
            final year = date.format('yyyy');

            return PhotosCard(
              title: month,
              subtitle: year,
              asset: asset,
              secondary: second,
              assets: entry.value,
            ).p(all: 12);
          },
        ),
      ),
    );
  }
}
