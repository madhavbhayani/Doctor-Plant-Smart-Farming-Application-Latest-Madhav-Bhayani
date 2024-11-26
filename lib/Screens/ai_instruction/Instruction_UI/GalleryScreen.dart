// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../MODEL_UI/DP_1_Gallery.dart';

class AIInstructionScrnGallery extends StatefulWidget {
  const AIInstructionScrnGallery({super.key});

  @override
  State<AIInstructionScrnGallery> createState() =>
      _AIInstructionScrnGalleryState();
}

class _AIInstructionScrnGalleryState extends State<AIInstructionScrnGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: const Text(
          "Instructions",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Lottie.asset('assets/instruction_lootie.json',
                height: 50.h, width: 60.w),
            SizedBox(
              height: 40.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      textScaler: TextScaler.linear(1),
                      "1 . Please take a clear picture of the plant leaf. \n\n2 . Make sure the leaf is in focus and well lit. \n\n3 . For better performance, the leaf should be placed on a plain background. \n\n4 . If you don't get the result, report the image.",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(90.w, 5.h),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        elevation: 0,
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const AIResult_gallery(),
                          ),
                        );
                      },
                      child: const Text(
                        "Choose Image From Gallery",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}