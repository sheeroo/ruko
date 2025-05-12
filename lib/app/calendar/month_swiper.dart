import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/calendar/calendar_appbar.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/app/swiper/swiper.dart';

@RoutePage()
class MonthSwiperPage extends StatefulWidget {
  const MonthSwiperPage({super.key, required this.month});

  final String month;

  @override
  State<MonthSwiperPage> createState() => _MonthSwiperPageState();
}

class _MonthSwiperPageState extends State<MonthSwiperPage> {
  final controller = AppinioSwiperController();

  @override
  Widget build(BuildContext context) {
    final assets =
        context.watch<GalleryAssetsCubit>().state.groupedByMonth[widget
            .month] ??
        [];
    return Scaffold(
      appBar: CalendarAppbar(
        title: widget.month,
        onDelete: (ids) {
          controller.setCardIndex(controller.cardIndex! - ids.length);
        },
      ),
      body: AssetSwiper(
        key: ValueKey(assets),
        assets: assets,
        controller: controller,
      ),
    );
  }
}
