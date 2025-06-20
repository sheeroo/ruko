import 'package:auto_route/auto_route.dart';
import 'package:ruko/core/modals/scrollable_sheet_page.dart';
import 'package:ruko/core/widgets/alert_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ErrorModalPage extends StatelessWidget {
  const ErrorModalPage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return ScrollableSheetPage(
      child: SingleChildScrollView(child: Center(child: Alert.error(message))),
    );
  }
}
