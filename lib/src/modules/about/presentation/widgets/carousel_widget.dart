import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/src/core/core.dart';
import 'package:robsic/src/modules/core/core.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key, required this.images});

  final List<ImageEntity> images;

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late final PageController _pageController;
  late final List<ImageEntity> images;
  late final int numberOfImages;
  late int currentImage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 1.0);
    images = widget.images;
    numberOfImages = widget.images.length;
    currentImage = _pageController.initialPage;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _goToPreviousPage() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  bool get isFirstImage => currentImage == 0;
  bool get isLastImage => currentImage == numberOfImages - 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Row(
            children: [
              Visibility(
                visible: !ResponsiveUtils.isMobile(context),
                child: Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: !isFirstImage ? _goToPreviousPage : null,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: !isFirstImage
                          ? TokenColors.gray900
                          : TokenColors.gray100,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: numberOfImages,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(TokenSpaces.md),
                      child: CachedNetworkImage(
                        imageUrl: EndPoints.baseUrl + images[index].url,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  onPageChanged: (currentImage) {
                    setState(() {
                      this.currentImage = currentImage;
                    });
                  },
                ),
              ),
              Visibility(
                visible: !ResponsiveUtils.isMobile(context),
                child: Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: !isLastImage ? _goToNextPage : null,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: !isLastImage
                          ? TokenColors.gray900
                          : TokenColors.gray100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _indicators(),
        ),
      ],
    );
  }

  List<Widget> _indicators() {
    return List<Widget>.generate(numberOfImages, (page) {
      return InkWell(
        onTap: () => _pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
        ),
        child: Container(
          margin: const EdgeInsets.all(TokenSpaces.xxs),
          width: TokenSpaces.xs,
          height: 10,
          decoration: BoxDecoration(
            color: currentImage == page ? Colors.black : Colors.black26,
            shape: BoxShape.circle,
          ),
        ),
      );
    });
  }
}
