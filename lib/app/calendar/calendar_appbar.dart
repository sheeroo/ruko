import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:pixelarticons/pixel.dart';

class CalendarAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CalendarAppbar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    final widget = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.black.withValues(alpha: 0.3),
        flexibleSpace: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (title != null)
                  Expanded(
                    child: AutoSizeText(title!, maxLines: 1, minFontSize: 4),
                  ),
                IconButton(
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    context.router.maybePop();
                  },
                  icon: Icon(Pixel.close),
                ),
              ],
            ).p(horizontal: 12),
          ),
        ),
      ),
    );

    return widget;
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}
