import 'package:auto_route/auto_route.dart';
import 'package:image_delete_demo/core/modals/scrollable_sheet_page.dart';
import 'package:image_delete_demo/core/permissions/permission_handler.dart';
import 'package:image_delete_demo/core/theme/button.dart';
import 'package:image_delete_demo/core/theme/text_extension.dart';
import 'package:image_delete_demo/core/widgets/alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

@RoutePage()
class PermissionRequestPage extends StatelessWidget {
  const PermissionRequestPage({super.key, required this.type});

  final PermissionType type;

  String get infoText {
    switch (type) {
      case PermissionType.notification:
        return 'drift requires access to your notifications to remind you about upcoming drifts.';
      case PermissionType.mic:
        return 'drifts requires access to your microphone to record audio.';
      case PermissionType.gallery:
        return 'drift requires access to your gallery to save your drifts.';
    }
  }

  String get requestPermissiontext {
    switch (type) {
      case PermissionType.notification:
        return 'tap to allow notifications';
      case PermissionType.mic:
        return 'tap to give microphone access';
      case PermissionType.gallery:
        return 'tap to give gallery access';
    }
  }

  IconData get icon {
    switch (type) {
      case PermissionType.notification:
        return FeatherIcons.bell;
      case PermissionType.mic:
        return FeatherIcons.mic;
      case PermissionType.gallery:
        return FeatherIcons.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableSheetPage(
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Alert.info("${type.name} permission is required"),
            Text(infoText).bodySmall(fontSize: 12, opacity: 0.4),
            Center(
              child: StyledButton.text(
                title: requestPermissiontext,
                onPressed: () async {
                  final isGranted = await PermissionHandler.of(type).request();

                  if (context.mounted) {
                    context.router.maybePop(isGranted);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
