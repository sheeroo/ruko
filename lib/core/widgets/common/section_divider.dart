import 'package:image_delete_demo/core/theme/text_extension.dart';
import 'package:image_delete_demo/core/widgets/common/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key, required this.label, this.icon});

  final IconData? icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Flexible(child: const DriftDivider()),
        Icon(
          icon ?? FeatherIcons.hash,
          size: 14,
          color: Colors.white.withValues(alpha: 0.5),
        ),
        Text(label).bodySmall(opacity: 0.5),
        Flexible(child: const DriftDivider()),
      ],
    );
  }
}
