import 'package:flutter/material.dart';

class DocsImagesWithCross extends StatelessWidget {
  final String docsName;
  final double? fontSize;
  final void Function() onCrossTap;
  const DocsImagesWithCross(
      {super.key,
      required this.docsName,
      this.fontSize,
      required this.onCrossTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/docs.png',
                height: 25,
                width: 25,
              ),
              Expanded(
                child: Text(
                  docsName,
                  style: TextStyle(
                      fontSize: fontSize ?? 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: GestureDetector(
                    onTap: onCrossTap, child: Image.asset('assets/cross.png')),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
