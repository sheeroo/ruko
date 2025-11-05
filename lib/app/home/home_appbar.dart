import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ruko/app/categories/categories_page.dart';
import 'package:ruko/app/categories/category_page.dart';
import 'package:ruko/core/extensions/core_extensions.dart';
import 'package:ruko/core/router/router.gr.dart';
import 'package:ruko/core/theme/button.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key, this.onDelete});

  final Function(List<String>)? onDelete;

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
        centerTitle: true,
        backgroundColor: Colors.black.withValues(alpha: 0.3),
        flexibleSpace: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 12,
                children: [
                  ...AssetCategory.values.map(((category) {
                    return StyledButton.icon(
                      icon: category.icon,
                      onPressed: () {
                        context.router.push(CategoryRoute(category: category));
                      },
                    );
                  })),
                ],
              ).p(left: 12),
            ),
          ),
        ),
      ),
    );

    return widget;
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}
