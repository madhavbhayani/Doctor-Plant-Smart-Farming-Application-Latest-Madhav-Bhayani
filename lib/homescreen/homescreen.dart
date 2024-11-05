// ignore_for_file: avoid_print, file_names

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:emojis/emojis.dart';

import '../Screens/dailymarketprices/displayscreen/displayscreen.dart';


class Homescreen extends StatefulWidget {
  final String? displayName;
  const Homescreen(this.displayName, {super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int currentPageIndex = 0;
  get displayName => widget.displayName;
  Future<MarketPrices>? _getMarketPricesData;
  String? _stateSelectValue;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndFetchMarketPrices();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Doctor Plant Requires Location Permission to fetch the Market Prices'),
                Text('Would you like to approve permission for location?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                openAppSettings();
                _checkPermissionsAndFetchMarketPrices();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _checkPermissionsAndFetchMarketPrices() async {
    final status = await Permission.location.status;
    if (status.isGranted) {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      //Fetch the state name using the latitude and longitude using geocoding api
      final geoUrl =
          'https://geocode.maps.co/reverse?lat=${position.latitude}&lon=${position.longitude}&api_key=YOUR_API_KEY';

      //TODO : Implement error handling concept here when the api fails to fetch the state name
      final geoResponse = await http.get(Uri.parse(geoUrl));
      final geoJson = jsonDecode(geoResponse.body);
      var state = geoJson['address']['state'];
      // print(state);
      if (state != null) {
        _stateSelectValue = state;
        if (_stateSelectValue == 'Delhi') {
          _stateSelectValue = 'NCT%20of%20Delhi';
        } else if (_stateSelectValue!.contains(' ')) {
          _stateSelectValue = _stateSelectValue!.replaceAll(' ', '%20');
        }
      }

      //Fetch the market prices using the state nam
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      // TODO : Implement location deny and other error handling concept here when user denies location permission
    } else {
      await Permission.location.request();
      _checkPermissionsAndFetchMarketPrices();
    }
  }

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        showDragHandle: true,
        useSafeArea: true,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        barrierColor: Colors.black.withOpacity(0.5),
        context: context,
        builder: (context) => SizedBox(
              height: 70.h,
              child: SingleChildScrollView(
                // physics:BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      // child: Image.network(
                      //   'https://www.doctorplant.in/assets/logo.png',  
                      //   scale: 15,
                      // ),
                      child: Image.asset(
                        'assets/logo.png',
                        scale: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Center(
                      child: Text(
                        'Doctor Plant\nSmart Farming Application',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        'Introducing Doctor Plant, the AI-powered application revolutionizing plant care. Swiftly diagnose and cure plant diseases with cutting-edge AI algorithms. Receive tailored cultivation tips, smart techniques, and real-time weather information. Join a vibrant community of plant pathologists for shared expertise. Access a comprehensive database on pests and diseases. Doctor Plant is your intelligent, user-friendly companion for cultivating thriving green spaces. Download now and embark on a journey.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        'Problem V/S Solution',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        'Problem : To identify and diagnose diseases in plants and crops, aiming to provide an efficient and accurate solution for disease management in agriculture.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        'Solution : "We propose the development of a native application with AI-based image recognition for plant and crop disease diagnosis." This app provides instant disease identification, treatment recommendations, and prevention tips. If the AI can\'t diagnose, users can submit images to a community of experts for assistance.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      // HomeScreen(),
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 20.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.250),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40.w,
                          child: Image.asset(
                            'assets/logo.png',
                            scale: 7,
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                          height: 20.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Welcome to \nDoctor Plant !",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(35.w, 5.h),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                  elevation: 0,
                                  backgroundColor: const Color(0xff00B251),
                                ),
                                onPressed: () {
                                  _displayBottomSheet(context);
                                },
                                child: const Text(
                                  "About App",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Heal Your Crop With Doctor Plant !",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        height: 30.h,
                        width: 100.w,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.250),
                                offset: const Offset(0, 4),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 12.h,
                                          width: 20.w,
                                          child: Image.asset(
                                            'assets/scan.png',
                                            scale: 2,
                                          ),
                                        ),
                                        const Text("Scan Your Crop")
                                      ],
                                    ),
                                    Image.asset(
                                      'assets/arrow.png',
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 12.h,
                                          width: 20.w,
                                          child: Image.asset(
                                            'assets/medicine2.png',
                                            scale: 1,
                                          ),
                                        ),
                                        const Text("Process With AI")
                                      ],
                                    ),
                                    Image.asset(
                                      'assets/arrow.png',
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 12.h,
                                          width: 20.w,
                                          child: Image.asset(
                                            'assets/diagnosis2.png',
                                            scale: 2,
                                          ),
                                        ),
                                        const Text("Get Diagnosis"),
                                      ],
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(90.w, 5.h),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                    elevation: 0,
                                    backgroundColor: const Color(0xff00B251),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const AIInstructionScrn(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Scan Your Image",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(90.w, 5.h),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                      side: const BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const AIInstructionScrnGallery(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Choose From Gallery",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),

              //GridView.builder using API call for DMP
              // SizedBox(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       // const Text(
              //       //   "Daily Maket Prices",
              //       //   style: TextStyle(
              //       //       color: Colors.black,
              //       //       fontSize: 14,
              //       //       fontWeight: FontWeight.bold),
              //       // ),
              //       SizedBox(
              //         height: 1.h,
              //       ),
              //       SizedBox(
              //         height: 40.h,
              //         width: 100.w,
              // child: FutureBuilder<MarketPrices>(
              //     future: _getMarketPricesData,
              //     builder: (context, snapshot) {
              // if (snapshot.connectionState ==
              //     ConnectionState.waiting) {
              //   return const Center(
              //     child: CircularProgressIndicator(),
              //   );
              // } else if (snapshot.hasData) {
              //   return Text("Snap shot has data !");
              // }
              // else if(snapshot.hasError){
              //   return Text("Error in fetching data !");
              // }
              // else {
              //   return const Center(
              //     child: Text("No Data Available"),
              //   );
              // }
              //     }),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // DMP Screen(),
      const DailyMarketPrices(),
      // WeatherScreen(),
      const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Weather Screen"),
          ],
        ),
      ),
      //Crop Calender Screen
      CropCalenderScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.green[200],
        height: 8.h,
        backgroundColor: Colors.green[50],
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        elevation: 0,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Iconsax.home_hashtag4),
            label: 'Home',
            selectedIcon: Icon(Iconsax.home_hashtag5),
          ),
          NavigationDestination(
            icon: Icon(Iconsax.shop4),
            label: 'Market Prices',
            selectedIcon: Icon(Iconsax.shop5),
          ),
          NavigationDestination(
            icon: Icon(Iconsax.sun_14),
            label: 'Weather',
            selectedIcon: Icon(Iconsax.sun_15),
          ),
          NavigationDestination(
            icon: Icon(Iconsax.calendar_2),
            label: 'Crop Calender',
            selectedIcon: Icon(Iconsax.calendar_25),
          ),
        ],
      ),
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
              height: 5.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hii ${displayName} ! ${Emojis.smilingFaceWithHalo}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Enjoy Your Services",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 10,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: SafeArea(
          child: Builder(
            builder: (context) {
              return SizedBox(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: SizedBox(
                        width: 10.w,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: IconButton(
                            iconSize: 25,
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      drawer: Drawer(
        semanticLabel: 'Menu',
        elevation: 3,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: SizedBox(
          height: 100.h,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                ),
                child: const Text('Doctor Plant'),
              ),
              Column(
                children: [
                  ListTile(
                    title: const Text('Settings'),
                    onTap: () {
                      // Update the state of the app

                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              ListTile(
                title: const Text('About Team'),
                onTap: () {
                  // Update the state of the app

                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Refrences & Credits'),
                onTap: () {
                  // Update the state of the app

                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: screens[currentPageIndex],
    );
  }
}
