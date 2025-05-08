import 'dart:async';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_delete_demo/asset_loader_repository.dart';
import 'package:image_delete_demo/cubit/image_delete_cubit.dart';
import 'package:image_delete_demo/image_card/asset_entity_image.dart';
import 'package:image_delete_demo/text_swapper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pixelarticons/pixel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iOS Photo Deleter',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.pressStart2pTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) => ImageDeleteCubit(),
        child: const PhotoGalleryScreen(),
      ),
    );
  }
}

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  List<AssetEntity> _assets = [];
  final Set<String> _selectedAssetIds = {}; // Use Set for efficient lookup
  bool _isLoading = true;
  PermissionState _permissionStatus = PermissionState.denied; // Initial state
  final assetRepository = AssetLoaderRepository();
  final controller = AppinioSwiperController();

  int? currentIndex;

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermission();
    controller.addListener(() {
      print("Current index: ${controller.cardIndex}");
      setState(() {
        currentIndex = controller.cardIndex ?? 0;
      });
    });
  }

  // --- Permission Handling ---
  Future<void> _checkAndRequestPermission() async {
    // Request limited/full access on iOS. Read/Write needed for deletion.
    final PermissionStatus status = await Permission.photos.request();

    // Update status for UI feedback
    final PermissionState state = await PhotoManager.requestPermissionExtend();
    setState(() {
      _permissionStatus = state;
    });

    if (state.hasAccess) {
      _loadAssets();
    } else {
      setState(() {
        _isLoading = false; // Stop loading if no permission
      });
      // Optionally show a dialog guiding the user to settings
      if (status.isPermanentlyDenied || status.isRestricted) {
        _showPermissionDeniedDialog();
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Permission Required'),
            content: const Text(
              'Photo library access is needed to delete photos. Please grant permission in settings.',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Open Settings'),
                onPressed: () {
                  openAppSettings(); // From permission_handler
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  // --- Asset Loading ---
  Future<void> _loadAssets() async {
    setState(() {
      _isLoading = true;
      _assets = [];
      _selectedAssetIds.clear();
    });

    try {
      final FilterOptionGroup filterOptionGroup = FilterOptionGroup(
        imageOption: const FilterOption(
          sizeConstraint: SizeConstraint(minWidth: 0, minHeight: 0),
        ),
        orders: [
          const OrderOption(type: OrderOptionType.createDate, asc: false),
        ],
      );

      // Fetch assets only from the main library ("Recents" typically)
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        onlyAll: true, // Usually gets the main "Recents" or "All Photos" album
        type: RequestType.image,
        filterOption: filterOptionGroup,
      );

      if (paths.isNotEmpty) {
        // Load a reasonable number of assets initially for quicker display
        // You could implement pagination/infinite scrolling for larger galleries
        const int loadCount = 1000; // Adjust as needed
        final List<AssetEntity> loadedAssets = await paths[0].getAssetListPaged(
          page: 0, // Start from the first page
          size: loadCount,
        );

        setState(() {
          _assets = loadedAssets;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false; // No paths found
        });
      }
    } catch (e) {
      debugPrint("Error loading assets: $e");
      setState(() {
        _isLoading = false;
      });
      // Show error message to user maybe?
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading photos: ${e.toString()}')),
      );
    }
  }

  // --- Build UI ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TrashButton(
              onDelete: (ids) {
                setState(() {
                  _assets.removeWhere((asset) => ids.contains(asset.id));
                });
                controller.setCardIndex(controller.cardIndex! - ids.length);
              },
            ),
            Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white, width: 1),
                    boxShadow: [
                      BoxShadow(color: Colors.white, offset: Offset(2, 2)),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Pixel.arrowleft, color: Colors.white),
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      if (controller.cardIndex == null) return;
                      if (controller.cardIndex! == 0) return;
                      await controller.unswipe();
                      context.read<ImageDeleteCubit>().remove(
                        _assets[controller.cardIndex!],
                      );
                    },
                  ),
                )
                .animate(target: currentIndex == null ? 0 : 1)
                .fadeIn(curve: Curves.fastOutSlowIn, duration: 350.ms),
          ],
        ),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (!_permissionStatus.hasAccess && !_isLoading) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Photo library permission is required to view and delete photos.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed:
                            _checkAndRequestPermission, // Retry requesting
                        child: const Text('Grant Permission'),
                      ),
                      if (_permissionStatus ==
                          PermissionState.limited) // If limited access
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text(
                            'Limited access granted. You might only see photos you explicitly selected. Go to Settings to grant full access.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }

            if (_isLoading) {
              return const SizedBox.shrink();
            }

            if (_assets.isEmpty) {
              return const Center(child: Text('No photos found.'));
            }
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Stack(
                children: [
                  Column(
                    spacing: 8,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [Text("< delete"), Text("keep >")],
                      //   ),
                      // ),
                      Flexible(
                        child: AppinioSwiper(
                          key: ValueKey(_assets),
                          controller: controller,
                          loop: true,
                          swipeOptions: SwipeOptions.symmetric(
                            horizontal: true,
                            vertical: false,
                          ),
                          onSwipeEnd: (targetIndex, nextIndex, activity) {
                            if (activity.end != null && activity.end!.dx != 0) {
                              if (activity.direction == AxisDirection.left) {
                                HapticFeedback.selectionClick();
                                context.read<ImageDeleteCubit>().add(
                                  _assets[targetIndex],
                                );
                              }
                            }
                          },
                          backgroundCardCount: 4,
                          backgroundCardOffset: Offset(25, 25),
                          cardBuilder: (BuildContext context, int index) {
                            final asset = _assets[index % _assets.length];
                            return ImageItemWidget(
                              entity: asset,
                              index: index,
                              option: ThumbnailOption.ios(
                                size: ThumbnailSize(720, 1560),
                              ),
                              controller: controller,
                            );
                          },
                          cardCount: _assets.length,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class TrashButton extends StatelessWidget {
  const TrashButton({super.key, this.onDelete});

  final Function(List<String>)? onDelete;

  @override
  Widget build(BuildContext context) {
    final selectedAssets = context.watch<ImageDeleteCubit>().state.entities;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.white, width: 1),
            boxShadow: [BoxShadow(color: Colors.white, offset: Offset(2, 2))],
          ),
          child: IconButton(
            icon: const Icon(Pixel.trash, color: Colors.white),
            iconSize: 28,
            // onPressed: _deleteSelectedAssets,
            onPressed: () async {
              HapticFeedback.lightImpact();
              final List<String> result = await PhotoManager.editor
                  .deleteWithIds(selectedAssets.map((e) => e.id).toList());
              onDelete?.call(result);
              if (result.isNotEmpty && context.mounted) {
                context.read<ImageDeleteCubit>().reset();
              }
            },
          ),
        ),
        if (selectedAssets.isNotEmpty)
          Positioned(
                right: 6,
                top: 6,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: TextSwapper(
                    "${selectedAssets.length}",
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              )
              .animate(target: selectedAssets.isNotEmpty ? 1 : 0)
              .moveY(curve: Curves.fastOutSlowIn, begin: -20, end: 0),
      ],
    );
  }
}
