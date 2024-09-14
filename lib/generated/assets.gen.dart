/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Almarai-Bold.ttf
  String get almaraiBold => 'assets/fonts/Almarai-Bold.ttf';

  /// File path: assets/fonts/Almarai-ExtraBold.ttf
  String get almaraiExtraBold => 'assets/fonts/Almarai-ExtraBold.ttf';

  /// File path: assets/fonts/Almarai-Light.ttf
  String get almaraiLight => 'assets/fonts/Almarai-Light.ttf';

  /// File path: assets/fonts/Almarai-Regular.ttf
  String get almaraiRegular => 'assets/fonts/Almarai-Regular.ttf';

  /// List of all assets
  List<String> get values =>
      [almaraiBold, almaraiExtraBold, almaraiLight, almaraiRegular];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/igentech.jpg
  AssetGenImage get igentech =>
      const AssetGenImage('assets/icons/igentech.jpg');

  /// File path: assets/icons/igentech_logo.jpg
  AssetGenImage get igentechLogo =>
      const AssetGenImage('assets/icons/igentech_logo.jpg');

  /// File path: assets/icons/language.svg
  String get language => 'assets/icons/language.svg';

  /// List of all assets
  List<dynamic> get values => [igentech, igentechLogo, language];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/mission.png
  AssetGenImage get mission => const AssetGenImage('assets/images/mission.png');

  /// File path: assets/images/who we are.png
  AssetGenImage get whoWeAre =>
      const AssetGenImage('assets/images/who we are.png');

  /// List of all assets
  List<AssetGenImage> get values => [mission, whoWeAre];
}

class $AssetsLanguagesGen {
  const $AssetsLanguagesGen();

  /// File path: assets/languages/ar.json
  String get ar => 'assets/languages/ar.json';

  /// File path: assets/languages/en.json
  String get en => 'assets/languages/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLanguagesGen languages = $AssetsLanguagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
