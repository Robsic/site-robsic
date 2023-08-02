class ImageEntity {
  final String? name;
  final String? alternativeText;
  final String? caption;
  final String? thumbUrl;
  final String? smallFormatUrl;
  final String? mediumFormatUrl;
  final String? largeFormatUrl;
  final String url;

  ImageEntity({
    this.name,
    this.alternativeText,
    this.caption,
    this.thumbUrl,
    this.smallFormatUrl,
    this.mediumFormatUrl,
    this.largeFormatUrl,
    required this.url,
  });
}
