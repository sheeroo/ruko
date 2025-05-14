import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/gallery_assets_cubit.dart';
import 'package:image_delete_demo/app/gallery_assets/cubit/image_delete_cubit.dart';
import 'package:image_delete_demo/core/theme/button.dart';
import 'package:image_delete_demo/core/widgets/common/widgets/text_swapper.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pixelarticons/pixel.dart';

class TrashButton extends StatelessWidget {
  const TrashButton({super.key, this.onDelete});

  final Function(List<String>)? onDelete;

  @override
  Widget build(BuildContext context) {
    final selectedAssets = context.watch<ImageDeleteCubit>().state.entities;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        StyledButton.icon(
          icon: Pixel.trash,
          onPressed: () async {
            HapticFeedback.lightImpact();
            final List<String> result = await PhotoManager.editor.deleteWithIds(
              selectedAssets.map((e) => e.id).toList(),
            );
            if (!context.mounted) return;
            context.read<GalleryAssetsCubit>().removeAssets(
              selectedAssets.map((e) => e.id).toList(),
            );
            onDelete?.call(result);
            if (result.isNotEmpty && context.mounted) {
              context.read<ImageDeleteCubit>().reset();
            }
          },
        ),

        Positioned(
              right: -6,
              top: -6,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Row(
                  children: [
                    ..."${selectedAssets.length}".padLeft(2, '0').split('').map(
                      (char) {
                        return TextSwapper(char, style: TextStyle(fontSize: 8));
                      },
                    ),
                  ],
                ),
              ),
            )
            .animate(target: selectedAssets.isNotEmpty ? 1 : 0)
            .moveY(curve: Curves.fastOutSlowIn, begin: -20, end: 0)
            .fadeIn(curve: Curves.fastOutSlowIn),
      ],
    );
  }
}
