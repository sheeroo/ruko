import 'dart:io';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.file, required this.index});

  final File file;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(32),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          fit: StackFit.expand,
          children: [Image(image: FileImage(file), fit: BoxFit.cover)],
        ),
      ),
    );
  }
}
