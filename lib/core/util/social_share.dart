import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:ruko/core/dotenv/dotenv.dart';

extension SocialShare on AppinioSocialShare {
  void shareToInstagramStory({
    String? backgroundVideo,
    String? backgroundImage,
  }) {
    assert(
      backgroundVideo != null || backgroundImage != null,
      'Either backgroundVideo or backgroundImage must be provided.',
    );
    if (Platform.isIOS) {
      iOS.shareToInstagramStory(
        DotEnv.instance.fbAppId,
        backgroundVideo: backgroundVideo,
        backgroundImage: backgroundImage,
      );
    } else {
      android.shareToInstagramStory(
        DotEnv.instance.fbAppId,
        backgroundVideo: backgroundVideo,
        backgroundImage: backgroundImage,
      );
    }
  }

  void shareToSystem(String filePath) {
    if (Platform.isIOS) {
      iOS.shareToSystem("", filePaths: [filePath]);
    } else {
      android.shareToSystem("", "", filePath);
    }
  }
}
