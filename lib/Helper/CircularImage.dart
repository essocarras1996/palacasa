import 'package:flutter/material.dart';

class MyCircularImage extends StatelessWidget {
  final String imageUrl;
  final String text;

  MyCircularImage({required this.imageUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 2.5,
                  spreadRadius: 2.5,
                  offset: Offset(0, 1),
                )
              ]
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
