// ignore_for_file: avoid_print, use_build_context_synchronously


import 'package:doctorplant_v2/Screens/onboardscreen/components/dailymarketprices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homescreen/homescreen.dart';
import '../../userAuthcontrollers/userauthcontroller.dart';
import 'components/common_button/centerNextSignIn';
import 'components/common_button/skipbutton.dart';
import 'components/cropcalendar.dart';
import 'components/imageprocessing.dart';
import 'components/initscreen.dart';
import 'components/welcome.dart';

class Onboardscreen extends StatefulWidget {
  static String routeName = "/splash";

  const Onboardscreen({super.key});

  @override
  State<Onboardscreen> createState() => _OnboardscreenState();
}

class _OnboardscreenState extends State<Onboardscreen>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  int currentPage = 0;

  _storeOnboardinfo() async {
    int isviewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("splashscrn", isviewed);
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ClipRect(
        child: Stack(
          children: [
            SplashView(
              animationController: _animationController!,
            ),
            RelaxView(
              animationController: _animationController!,
            ),
            CareView(
              animationController: _animationController!,
            ),
            MoodDiaryVew(
              animationController: _animationController!,
            ),
            WelcomeView(
              animationController: _animationController!,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
            CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: const Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() async {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => Homescreen()));

    try {
      final user = await UserAuthController.loginWithGoogle();
      if (user != null && mounted) {
        //store the display name to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("displayName", user.displayName!);
        await _storeOnboardinfo();

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Homescreen(user.displayName)));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "We received an error from firebase side ! Sorry for inconvenience"),
      ));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something went wrong ! Coundn't login with google"),
      ));
    }
  }
}
