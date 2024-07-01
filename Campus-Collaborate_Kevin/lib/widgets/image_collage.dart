import 'package:flutter/material.dart';
import 'package:image_collage/image_collage.dart';

import '../constants/themes.dart';

class CustomImageCollage extends StatelessWidget {
  final List<String> imagesLink;
  const CustomImageCollage({super.key, required this.imagesLink});

  @override
  Widget build(BuildContext context) {
    List<Img> images = [];
    for (int i = 0; i < imagesLink.length; i++) {
      images.add(Img(image: imagesLink[i]));
    }
    return Column(
      children: [
        const SizedBox(height: 20,),
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: 225,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
              borderRadius: const BorderRadius.all(Radius.circular(25)),
            ),
            child: ImageCollage(images: images),
          ),
        ),
      ],
    );
  }
}
