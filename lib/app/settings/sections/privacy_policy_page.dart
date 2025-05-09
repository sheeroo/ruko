import 'package:auto_route/auto_route.dart';
import 'package:image_delete_demo/core/legal/prirvacy_policy.dart';
import 'package:image_delete_demo/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

@RoutePage()
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(title: 'privacy policy', dissmissable: true),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(child: Markdown(data: privacyPolicySource)),
    );
  }
}
