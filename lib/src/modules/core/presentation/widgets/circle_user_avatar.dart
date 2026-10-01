import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/src/resources/resources.dart';

class CircleUserAvatar extends StatelessWidget {
  const CircleUserAvatar({
    super.key,
    required this.url,
    required this.size,
  });

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          strokeAlign: BorderSide.strokeAlignOutside,
          color: TokenColors.primary,
          width: 2.0,
        ),
        shape: BoxShape.circle,
      ),
      width: size,
      height: size,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: size - 3,
          height: size - 3,
          errorWidget: (context, _, __) =>
              const Image(image: ImagesAsset.defaultUser),
        ),
      ),
    );
  }
}
