// ignore_for_file: prefer_const_declarations, prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<Map<String, dynamic>> fetchRoboflowResult(File imageFile) async {

  final apiKey = 'API_KEY'; // Replace with your Roboflow API key
  final dataset = 'doctorplant/2';
  final url = 'https://detect.roboflow.com/' + dataset + '?api_key=' + apiKey;

  final request = http.MultipartRequest('POST', Uri.parse(url))
    ..fields['api_key'] = apiKey
    ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

  final response = await request.send();
  final responseBody = await response.stream.bytesToString();
  return json.decode(responseBody);
}

Future<File?> pickImageFromCamera() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

class AIResultScrn extends StatefulWidget {
  const AIResultScrn({super.key});

  @override
  State<AIResultScrn> createState() => _AIResultScrnState();
}

class _AIResultScrnState extends State<AIResultScrn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Roboflow Object Detection')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            File? imageFile = await pickImageFromCamera();
            if (imageFile != null) {
              Map<String, dynamic> result =
                  await fetchRoboflowResult(imageFile);
              showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(result.toString()),
                ),
              );
            }
          },
          child: const Text('Capture Image'),
        ),
      ),
    );
  }
}
