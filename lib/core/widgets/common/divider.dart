import 'package:flutter/material.dart';

class DriftDivider extends StatelessWidget {
  const DriftDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        width: double.infinity,
        height: 1,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
