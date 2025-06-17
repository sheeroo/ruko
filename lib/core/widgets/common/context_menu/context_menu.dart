import 'package:auto_route/auto_route.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/theme/button.dart';
import 'package:ruko/core/theme/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContextMenuPage extends StatelessWidget {
  const ContextMenuPage({super.key, required this.items});

  final List<MenuItem> items;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        context.router.maybePop();
      },
      child: Scaffold(
        backgroundColor: Colors.black.withValues(alpha: 0.6),
        body: ContextMenuList(items: items),
      ).blur(64),
    );
  }
}

class ContextMenuList extends StatelessWidget {
  const ContextMenuList({
    super.key,
    required this.items,
    this.automaticallyImplyClose = true,
  });

  final List<MenuItem> items;
  final bool automaticallyImplyClose;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...items
                    .map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text(item.title).bodySmall(),
                          leading: Icon(item.icon, size: 16),
                          onTap: () {
                            HapticFeedback.selectionClick();
                            item.onTap();
                          },
                        ),
                      );
                    })
                    .toList()
                    .animate(
                      delay: Durations.medium1,
                      interval: Durations.short1,
                    )
                    .fadeIn(
                      duration: Durations.medium3,
                      curve: Curves.fastOutSlowIn,
                    )
                    .moveY(
                      duration: Durations.medium3,
                      begin: 40,
                      end: 0,
                      curve: Curves.fastOutSlowIn,
                    ),
              ],
            ),
          ),
          if (automaticallyImplyClose)
            Align(
                  alignment: Alignment.bottomCenter,
                  child: StyledButton.text(
                    title: "close",
                    onPressed: () {
                      context.router.maybePop();
                    },
                  ),
                )
                .animate(delay: Durations.short3)
                .fadeIn(duration: 350.ms, curve: Curves.fastOutSlowIn)
                .moveY(
                  duration: 350.ms,
                  begin: 40,
                  end: 0,
                  curve: Curves.fastOutSlowIn,
                ),
        ],
      ),
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  final bool destructive;
  final void Function() onTap;

  MenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.destructive = false,
  });
}
