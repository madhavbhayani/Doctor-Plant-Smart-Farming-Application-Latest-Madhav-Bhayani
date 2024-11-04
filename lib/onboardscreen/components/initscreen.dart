import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({super.key, required this.animationController});

  @override
  // ignore: library_private_types_in_public_api
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              // width: 100.w,
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "Doctor Plant",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 64, right: 64),
              child: Text(
                "An innovative way to take care of your plants ! Smart and easy to use. Enjoy for free.",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              // child: InkWell(
              //   onTap: () {
              //     widget.animationController.animateTo(0.2);
              //   },
              //   child: Container(
              //     height: 58,
              //     padding: const EdgeInsets.only(
              //       left: 56.0,
              //       right: 56.0,
              //       top: 16,
              //       bottom: 16,
              //     ),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(38.0),
              //       color: const Color(0xff132137),
              //     ),
              //     child: const Text(
              //       "Let's begin",
              //       style: TextStyle(
              //         fontSize: 18,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff00B251),
                  minimumSize: Size(50.w, 58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38.0),
                  ),
                ),
                onPressed: () {
                  widget.animationController.animateTo(0.2);
                },
                child: const Text("Let's begin",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
