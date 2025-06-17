import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _textScaleFactor = clampDouble(
  MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single,
      ).size.width /
      375,
  1,
  1.5,
);

extension TextExtension on Text {
  Text copyWith({
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) {
    return Text(
      data ?? '',
      style: style ?? this.style,
      strutStyle: strutStyle ?? this.strutStyle,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      textScaler: textScaler ?? TextScaler.linear(_textScaleFactor),
      maxLines: maxLines ?? this.maxLines,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
      selectionColor: selectionColor ?? this.selectionColor,
    );
  }

  Text bodySmall({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  Text bodyMedium({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  Text bodyLarge({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  Text titleSmall({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  Text titleMedium({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  Text titleLarge({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  Text headingSmall({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w900,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  Text headingMedium({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w900,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  Text headingLarge({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w900,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }
}

extension AutoSizeTextExtension on AutoSizeText {
  AutoSizeText overflowReplacementBuilder(
    Widget Function(AutoSizeText text) builder,
  ) {
    return copyWith(
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      style: style,
      overflowReplacement: builder(this),
    );
  }

  AutoSizeText overflowFade({
    Alignment alignment = Alignment.bottomCenter,
    Alignment begin = Alignment.center,
    Alignment end = Alignment.bottomCenter,
    double? minFontSize,
    double? maxFontSize,
  }) {
    return copyWith(
      overflowReplacement: Stack(
        children: [
          copyWith(
            overflowReplacement: null,
            minFontSize: minFontSize ?? 12,
            maxFontSize: maxFontSize ?? double.infinity,
          ),
          Align(
            alignment: alignment,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: begin,
                  end: end,
                  stops: const [0.5, 1],
                  colors: const [Colors.transparent, Colors.black],
                ),
              ),
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  AutoSizeText copyWith({
    Key? textKey,
    TextStyle? style,
    StrutStyle? strutStyle,
    double minFontSize = 12,
    double maxFontSize = double.infinity,
    double stepGranularity = 1,
    List<double>? presetFontSizes,
    AutoSizeGroup? group,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    bool wrapWords = true,
    TextOverflow? overflow,
    Widget? overflowReplacement,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
  }) {
    return AutoSizeText(
      data ?? "",
      key: textKey,
      style: style ?? this.style,
      strutStyle: strutStyle ?? this.strutStyle,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      stepGranularity: stepGranularity,
      presetFontSizes: presetFontSizes ?? this.presetFontSizes,
      group: group ?? this.group,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      wrapWords: wrapWords,
      overflow: overflow ?? this.overflow,
      overflowReplacement: overflowReplacement ?? this.overflowReplacement,
      textScaleFactor: textScaleFactor ?? _textScaleFactor,
      maxLines: maxLines ?? this.maxLines,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
    );
  }

  AutoSizeText bodySmall({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  AutoSizeText bodyMedium({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  AutoSizeText bodyLarge({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  AutoSizeText titleSmall({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  AutoSizeText titleMedium({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  AutoSizeText titleLarge({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  AutoSizeText headingSmall({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w900,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  AutoSizeText headingMedium({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w900,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  AutoSizeText headingLarge({
    double? opacity,
    Color color = Colors.white,
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w900,
  }) {
    return copyWith(
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.pressStart2p(
        fontSize: fontSize,
        color: opacity == null ? color : color.withValues(alpha: opacity),
        fontWeight: fontWeight,
      ),
    );
  }
}
