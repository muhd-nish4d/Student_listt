import 'dart:io';

import 'package:flutter/material.dart';

class WidgetStudentCart extends StatelessWidget {
  final String name;
  final String imagePath;
  const WidgetStudentCart(
      {super.key, required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Card(
        elevation: 10,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // CircleAvatar(backgroundImage: FileImage(File(imagePath)),),
            Container(
              height: MediaQuery.of(context).size.height * .19,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: FileImage(File(imagePath)))),
            ),
            Expanded(
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
