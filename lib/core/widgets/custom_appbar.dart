import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/theme/text_extension.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, this.title});

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
        backgroundColor: Colors.black.withValues(alpha: 0.85),
        flexibleSpace: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Row(
              spacing: 12,
              children: [
                if (title != null) Center(child: Text(title!).bodySmall()),
                Spacer(),
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
    ).blur(32);

    return widget;
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
