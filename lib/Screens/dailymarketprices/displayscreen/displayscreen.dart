import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../detailscreen/detailscreen.dart';

class DailyMarketPrices extends StatefulWidget {
  const DailyMarketPrices({super.key});

  @override
  State<DailyMarketPrices> createState() => _DailyMarketPricesState();
}

class _DailyMarketPricesState extends State<DailyMarketPrices> {
  Future<MarketPrices>? _getMarketPricesData;
  String? _stateSelectValue;
  @override
  void initState() {
    super.initState();
    _checkPermissionsAndFetchMarketPrices();
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
          'https://geocode.maps.co/reverse?lat=${position.latitude}&lon=${position.longitude}&api_key=YOUR_API';

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

      //Fetch the market prices using the state name
      final url =
          'https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=YOUR_API&format=json&limit=100&filters%5Bstate.keyword%5D=$_stateSelectValue';
      setState(() {
        _getMarketPricesData = _fetchMarketPrices(url);
      });
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      // TODO : Implement location deny and other error handling concept here when user denies location permission
    } else {
      await Permission.location.request();
      _checkPermissionsAndFetchMarketPrices();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarketPrices>(
      future: _getMarketPricesData,
      builder: (context, snapshot) {
        // If the connection state is waiting, display a circular progress indicator
        // If the snapshot has data, display the fetched data in a grid view builder widget with the commodity list
        // If the snapshot has error, display an error message in the center of the screen with a text widget and a button to retry fetching the data

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final List _commodity = snapshot.data!.commodity;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 4,
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                ),
                itemCount: snapshot.data!.commodity.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 13.h,
                            width: 50.w,
                            child: GestureDetector(
                              onTap: () {
                                //TODO : Implement the navigation to the details page here
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         DetailDMPScreen(
                                //             _commodity[index], index),
                                //   ),
                                // );
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: NewDailyMarketPricesDetailScreen(
                                      _commodity[index],
                                    ),
                                  ),
                                );
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 14.w,
                                      height: 8.2.h,
                                      child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.white, width: 3),
                                            top: BorderSide(
                                                color: Colors.white, width: 3),
                                            left: BorderSide(
                                                color: Colors.white, width: 3),
                                            right: BorderSide(
                                                color: Colors.white, width: 3),
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.5),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(
                                              _imagefetcher(_commodity[
                                                      index] // Function to fetch the image of the commodity
                                                  ['commodity']),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: SizedBox(
                                        width: 100.w,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: [
                                              Text(
                                                _commodity[index]['commodity'],
                                                textScaler:
                                                    const TextScaler.linear(1),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  _commodity[index]['district'],
                                                  textScaler:
                                                      const TextScaler.linear(
                                                          1),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching data'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

Future<MarketPrices> _fetchMarketPrices(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    print(json);
    return MarketPrices.fromJson(json);
  } else {
    // ignore: use_build_context_synchronously
    throw Exception('Failed to load market prices');
  }
}

class MarketPrices {
  // Initialize the commodity list
  final List commodity;

  MarketPrices({required this.commodity});

  factory MarketPrices.fromJson(Map<String, dynamic> json) {
    return MarketPrices(
      // Data is fetched from the api and stored in the commodity list
      commodity: json['records'] ?? '',
    );
  }
}

// Function to fetch the image of the commodity
// The image is fetched from the internet using the commodity name
// The image is stored in the assets folder
// The image is fetched using the url of the image
// The image is returned as a string value to be displayed in the grid view builder widget in the DailyMarketPrices class widget
