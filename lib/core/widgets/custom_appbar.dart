import 'package:auto_route/auto_route.dart';
import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:image_delete_demo/core/widgets/common/widgets/text_swapper.dart';
import 'package:image_delete_demo/core/widgets/crt_shader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.dissmissable,
    this.actions = const [],
    this.automaticallyImplyLeading = false,
    this.title,
    this.leading,
    this.leadingWidth,
    this.onTitleDoubleTap,
    this.onTitleLongPress,
    this.titleStyle,
    this.glitched = false,
  });

  final String? title;
  final bool dissmissable;
  final List<Widget> actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final double? leadingWidth;
  final void Function()? onTitleDoubleTap;
  final void Function()? onTitleLongPress;
  final TextStyle? titleStyle;
  final bool glitched;

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
        backgroundColor: Colors.black.withValues(alpha: 0.3),
        leading: leading,
        leadingWidth: leadingWidth,
        title:
            title != null
                ? GestureDetector(
                  onDoubleTap: onTitleDoubleTap,
                  onLongPress: onTitleLongPress,
                  child: Container(
                    color: Colors.transparent,
                    constraints: const BoxConstraints(minWidth: 125),
                    padding: const EdgeInsets.all(4),
                    child: TextSwapper(title!, style: titleStyle),
                  ),
                )
                : null,
        actions: [
          ...actions,
          if (dissmissable)
            IconButton(
              icon: const Icon(FeatherIcons.x),
              onPressed: () {
                HapticFeedback.selectionClick();
                context.router.maybePop();
              },
            ),
        ],
      ).blur(15, borderRadius: 0),
    );
    if (glitched) {
      return CrtShader(child: widget);
    }
    return widget;
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
