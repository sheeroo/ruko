import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ruko/core/legal/prirvacy_policy.dart';
import 'package:ruko/core/widgets/custom_appbar.dart';

@RoutePage()
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(title: 'privacy policy'),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(child: Markdown(data: privacyPolicySource)),
    );
  }
}
