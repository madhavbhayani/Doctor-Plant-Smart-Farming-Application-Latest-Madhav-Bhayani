import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../userAuthcontrollers/userauthcontroller.dart';
import '../HomeScreen/HomeScreen.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final PageController _pageController = PageController();
  int _currentPage = 0;

  _storeOnboardinfo() async {
    int isviewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("splashscrn", isviewed);
  }

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 5), // Duration of one full up/down cycle
    );

    // Tween for vertical translation from -200 to +200
    _animation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);

    // Initialize animation controller
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    _pageController.dispose();

    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
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
        await prefs.setString("photoUrl", user.photoURL!);
        await _storeOnboardinfo();

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Homescreen(user.displayName, user.photoURL)));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset:
                    Offset(0, _animation.value), // Move the widget vertically,
                child: MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  itemCount: 11,
                  itemBuilder: (context, index) {
                    return [
                      () => ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(16),
                            ),
                            child: Image.asset(
                              'assets/image1.jpg',
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                      () => ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/image5.jpg',
                              width: 120,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                      () => ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(16),
                            ),
                            child: Image.network(
                              'https://picsum.photos/seed/32/600',
                              width: 100,
                              height: 0,
                              fit: BoxFit.cover,
                            ),
                          ),
                      () => ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(0),
                            ),
                            child: Image.asset(
                              'assets/image3.jpg',
                              width: 80,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                      () => ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/image4.jpg',
                              width: 120,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                      () => ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/image1.jpg',
                              width: 120,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                      () => ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(0),
                            ),
                            child: Image.asset(
                              'assets/image2.jpg',
                              width: 120,
                              height: 190,
                              fit: BoxFit.cover,
                            ),
                          ),
                      () => ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/image2.jpg',
                              width: 120,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                      () => ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/image3.jpg',
                              width: 120,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                      () => ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(0),
                            ),
                            child: Image.asset(
                              'assets/image5.jpg',
                              width: 120,
                              height: 190,
                              fit: BoxFit.cover,
                            ),
                          ),
                      () => ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/image5.jpg',
                              width: 120,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                    ][index]();
                  },
                ),
              );
            },
          ),
          //
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 400,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                _getTitle(index),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  _getDescription(index),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: index == _currentPage
                              ? 25
                              : 10, // Expand the active dot
                          height: 10,
                          decoration: BoxDecoration(
                            color: index == _currentPage
                                ? Colors.green
                                : Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage < 2) {
                            _nextPage();
                          } else {
                            // Handle sign-in action
                            _signUpClick();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          _currentPage < 2 ? "Next" : "Sign In",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

String _getTitle(int index) {
  switch (index) {
    case 0:
      return 'Welcome to Doctor Plant';
    case 1:
      return 'Image Processing !';
    case 2:
      return 'Daily Market Prices';
    default:
      return '';
  }
}

String _getDescription(int index) {
  switch (index) {
    case 0:
      return 'An innovative way to take care of your plants! Smart and easy to use. Enjoy for free!';
    case 1:
      return 'We use the latest image processing technology to help you take care of your plants!';
    case 2:
      return 'Get to know the daily market prices of vegetables and fruits in your city!';
    default:
      return '';
  }
}
