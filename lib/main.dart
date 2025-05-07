import 'dart:async';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_delete_demo/asset_loader_repository.dart';
import 'package:image_delete_demo/image_card/asset_entity_image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

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
        textTheme: GoogleFonts.ibmPlexMonoTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
      ),
      home: const PhotoGalleryScreen(),
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
  bool _isDeleting = false;
  PermissionState _permissionStatus = PermissionState.denied; // Initial state
  final assetRepository = AssetLoaderRepository();
  final controller = AppinioSwiperController();

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermission();
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

  // --- Deletion ---
  // ignore: unused_element
  Future<void> _deleteSelectedAssets() async {
    if (_selectedAssetIds.isEmpty || _isDeleting) {
      return; // Nothing to delete or already deleting
    }

    // --- Confirmation Dialog ---
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: Text(
            'Are you sure you want to permanently delete ${_selectedAssetIds.length} selected photo(s)? This cannot be undone.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false), // Return false
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
              onPressed: () => Navigator.of(context).pop(true), // Return true
            ),
          ],
        );
      },
    );

    // --- Proceed if confirmed ---
    if (confirm == true) {
      setState(() {
        _isDeleting = true; // Show deleting indicator
      });

      try {
        final List<String> result = await PhotoManager.editor.deleteWithIds(
          _selectedAssetIds.toList(), // Convert Set to List for the API
        );

        // Check if deletion was successful (result often contains the IDs successfully deleted)
        // A more robust check might be needed depending on package behavior updates
        if (result.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${result.length} photo(s) deleted successfully.'),
            ),
          );
          // Refresh the asset list after deletion
          _loadAssets(); // This implicitly clears selection and reloads
        } else if (_selectedAssetIds.isNotEmpty && result.isEmpty) {
          // This case might indicate a failure or that the API returns empty on success
          // Let's assume for now if no error is thrown, it worked, and reload
          debugPrint(
            "Deletion API returned empty list, assuming success/partial success and reloading.",
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Deletion request sent. Refreshing list...'),
            ),
          );
          _loadAssets(); // Reload anyway
        }
      } catch (e, st) {
        debugPrint("Error deleting assets: $e\n$st");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting photos: ${e.toString()}')),
        );
      } finally {
        // Ensure the deleting state is reset even if there's an error
        // Selection is cleared by _loadAssets() if successful
        setState(() {
          _isDeleting = false;
          // Keep selection if deletion failed? Maybe clear it anyway.
          // _selectedAssetIds.clear(); // Decide if you want to clear selection on failure
        });
      }
    }
  }

  // --- Build UI ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
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
              return const Center(child: CircularProgressIndicator());
            }

            if (_assets.isEmpty) {
              return const Center(child: Text('No photos found.'));
            }
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Stack(
                  children: [
                    AppinioSwiper(
                      controller: controller,
                      loop: true,
                      swipeOptions: SwipeOptions.symmetric(
                        horizontal: true,
                        vertical: false,
                      ),
                      backgroundCardCount: 2,
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
                  ],
                ),
              ),
            );
            // return PageView.builder(
            //   scrollDirection: Axis.vertical,
            //   itemBuilder: (context, index) {
            //     final file = _files[index % _files.length];
            //     return ImageCard(file: file, index: index);
            //   },
            // );
            // return CardSwiper(
            //   key: const ValueKey('card_swiper'),
            //   padding: const EdgeInsets.all(12),
            //   cardBuilder: (
            //     BuildContext context,
            //     int index,
            //     int horizontalOffsetPercentage,
            //     int verticalOffsetPercentage,
            //   ) {
            //     final file = _files[index % _files.length];
            //     // scheduleMicrotask(() {
            //     //   assetRepository.addAndLoadAsset(asset);
            //     //   assetRepository.addAndLoadAsset(_assets[index + 1]);
            //     // });
            //     return ImageCard(file: file, index: index);
            //   },
            //   cardsCount: _assets.length,
            // );
          },
        ),
      ),
    );
  }
}
