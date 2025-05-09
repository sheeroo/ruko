import 'package:flutter/cupertino.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_delete_demo/core/theme/text_extension.dart';

class StyledButton extends StatefulWidget {
  const StyledButton._({
    required this.title,
    required this.filled,
    required this.fontColor,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = true,
    this.onPressed,
    this.leading,
    this.trailing,
    this.borderColor,
    this.borderRadius,
    this.backgroundColor,
    this.fontSize,
  });

  final void Function()? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final String title;
  final bool isLoading;
  final bool isDisabled;
  final bool fullWidth;
  final bool filled;
  final Color fontColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double? fontSize;

  factory StyledButton.filled({
    required String title,
    required void Function()? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    bool fullWidth = false,
    Widget? leading,
    Widget? trailing,
    Color backgroundColor = Colors.white,
    Color fontColor = Colors.black,
    BorderRadius? borderRadius,
  }) {
    return StyledButton._(
      title: title,
      filled: true,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      fullWidth: fullWidth,
      fontColor: fontColor,
      leading: leading,
      trailing: trailing,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
    );
  }

  factory StyledButton.text({
    required String title,
    required void Function()? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    bool fullWidth = false,
    Widget? leading,
    Widget? trailing,
    Color fontColor = Colors.white,
    Color borderColor = Colors.white,
    BorderRadius? borderRadius,
    double? fontSize,
  }) {
    return StyledButton._(
      title: title,
      filled: false,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      fullWidth: fullWidth,
      leading: leading,
      trailing: trailing,
      fontColor: fontColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      fontSize: fontSize,
    );
  }

  @override
  State<StyledButton> createState() => _StyledButtonState();
}

class _StyledButtonState extends State<StyledButton> {
  final padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  var disabledColor = CupertinoColors.white.withValues(alpha: 0.7);

  @override
  Widget build(BuildContext context) {
    final child = Builder(
      builder: (context) {
        if (widget.isLoading) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize:
                widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
            children: [CupertinoActivityIndicator()],
          );
        }
        return Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
          children: [
            widget.leading ?? const SizedBox.shrink(),
            Flexible(
              child: Opacity(
                opacity: widget.isDisabled ? 0.7 : 1.0,
                child:
                    Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                    ).bodySmall(),
              ),
            ),
            widget.trailing ?? const SizedBox.shrink(),
          ],
        );
      },
    );

    if (widget.filled) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              offset: const Offset(3, 3),
              blurRadius: 0,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed:
              widget.isDisabled
                  ? null
                  : () {
                    HapticFeedback.selectionClick();
                    widget.onPressed?.call();
                  },
          child: SizedBox(height: 55, width: double.infinity, child: child),
        ),
      );
    }
    return CupertinoButton(
      disabledColor: disabledColor,
      padding: padding,
      borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
      onPressed:
          widget.isDisabled
              ? null
              : () {
                HapticFeedback.selectionClick();
                widget.onPressed?.call();
              },
      child: child,
    );
  }
}
