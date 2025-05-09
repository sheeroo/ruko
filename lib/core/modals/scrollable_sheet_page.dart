import 'package:image_delete_demo/core/extensions/core_extensions.dart';
import 'package:image_delete_demo/core/theme/button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

const _padding = EdgeInsets.only(left: 12, right: 12, top: 0);

enum ButtonVariant { primary, secondary, secondaryContained }

class ScrollableSheetPage extends StatelessWidget {
  const ScrollableSheetPage({
    super.key,
    required this.child,
    this.isButtonDisabled = false,
    this.isButtonLoading = false,
    this.title,
    this.minExtent,
    this.initialExtent,
    this.maxExtent,
    this.buttonText,
    this.onButtonPressed,
    this.leading,
    this.trailling,
  });

  final String? title;
  final SheetAnchor? minExtent;
  final SheetAnchor? initialExtent;
  final SheetAnchor? maxExtent;
  final Widget child;
  final Widget? leading;
  final Widget? trailling;

  final String? buttonText;
  final void Function()? onButtonPressed;
  final bool isButtonDisabled;
  final bool isButtonLoading;

  @override
  Widget build(BuildContext context) {
    return SheetKeyboardDismissible(
      dismissBehavior: null,
      child: ScrollableSheet(
        minPosition: minExtent ?? const SheetAnchor.proportional(1),
        maxPosition: initialExtent ?? const SheetAnchor.proportional(1),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: SheetContentScaffold(
            appbarDraggable: true,
            backgroundColor: Colors.transparent,
            appBar: ScrollableSheetAppBar(
              title: title,
              leading: leading,
              trailling: trailling,
            ),
            resizeBehavior: const ResizeScaffoldBehavior.avoidBottomInset(
              maintainBottomBar: true,
            ),
            body: Padding(padding: _padding, child: child),
            bottomBar:
                onButtonPressed != null
                    ? StickyBottomBarVisibility(
                      child: SafeArea(
                        child: StyledButton.filled(
                          title: buttonText ?? "done",
                          onPressed: onButtonPressed,
                          isLoading: isButtonLoading,
                          isDisabled: isButtonDisabled,
                        ).p(all: 8),
                      ),
                    )
                    : null,
          ),
        ).blur(32),
      ),
    );
  }
}

class ScrollableSheetAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ScrollableSheetAppBar({
    super.key,
    required this.leading,
    this.trailling,
    this.title,
  });

  final Widget? leading;
  final Widget? trailling;
  final String? title;

  @override
  final Size preferredSize = const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: leading ?? const SizedBox.shrink(),
          ),
          Center(child: DragHandle()),
          Align(
            alignment: Alignment.centerRight,
            child: trailling ?? const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 4.5,
      decoration: ShapeDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        shape: const StadiumBorder(),
      ),
    );
  }
}
