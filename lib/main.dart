import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homescreen/homescreen.dart';
import 'onboardscreen/onboardscreen.dart';
import 'theme.dart';

// Variables to store the data of the user
// isViewed is used to check if the user has viewed the application before or not
// displayName is used to store the name of the user
int? isViewed;
String? displayName;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  const SystemUiOverlayStyle(statusBarColor: Colors.white);
  // Device orientation is set to portrait up
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.green[50],
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  // Shared preferences are used to store the data of the user

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt("splashscrn");
  displayName = prefs.getString("displayName");

  runApp(const DoctorPlant());
}

// Root widget of the application
// DoctorPlant is a stateful widget that creates the state of the application using material design
class DoctorPlant extends StatefulWidget {
  const DoctorPlant({super.key});

  @override
  State<DoctorPlant> createState() => _DoctorPlantState();
}
// Write the state of the application in the _DoctorPlantState class and build the application using the MaterialApp widget

class _DoctorPlantState extends State<DoctorPlant> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Title of the application
          title: 'Doctor Plant',
          // Theme of the application
          theme: AppTheme.lightTheme(context),
          // Home screen of the application
          // If the user is viewing the application for the first time, the OnboardScreen will be displayed
          // If the user has already viewed the application, the HomeScreen will be displayed
          home: isViewed == 0 ? Homescreen(displayName) : Onboardscreen(),
        );
      },
    );
  }
}
