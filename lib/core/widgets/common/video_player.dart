import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.entity,
    this.autoPlay = true,
  });

  final bool autoPlay;
  final AssetEntity entity;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _loadVideo();
    });
  }

  void _loadVideo() async {
    final file = await widget.entity.file;
    _controller = VideoPlayerController.file(file!);
    await _controller!.initialize();
    if (widget.autoPlay) {
      await _controller!.setLooping(true);
      await _controller!.play();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Center(child: CupertinoActivityIndicator());
    }
    return GestureDetector(
      onTap: () {
        if (_controller!.value.isPlaying) {
          _controller!.pause();
        } else {
          _controller!.play();
        }
      },
      child: Center(
        child: AspectRatio(
          aspectRatio: 1 / 2,
          child: VideoPlayer(_controller!),
        ),
      ),
    );
  }
}
