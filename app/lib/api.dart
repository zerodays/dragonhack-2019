import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter/services.dart';

import 'teams.dart';
import 'globals.dart';

const apiUrl = 'http://134.209.251.146/api/';

final Dio _dio = new Dio(BaseOptions(
    baseUrl: apiUrl,
    responseType: ResponseType.json,
    contentType: ContentType.parse('application/json')));

Future getRequest(String name, Map<String, dynamic> params,
    {bool addTeam = false}) async {

  Response response = await _dio.get(name, queryParameters: params);

  if (response.statusCode != 200) {
    throw FormatException(
        'Internal server error. Response status code ${response.statusCode}');
  }

  if (response.data.runtimeType == String) {
    return json.decode(response.data);
  }
  return response.data;
}

Future postRequest(String name, Map data) async {
  http.Client client = http.Client();
  Uri uri = Uri.parse('$apiUrl$name');

  http.Request request = http.Request('POST', uri);

  request.body = json.encode(data);
  request.headers['Content-Type'] = 'application/json';

  http.StreamedResponse response = await client.send(request);
  if (response.statusCode != 200) {
    throw FormatException(
        'Internal server error. Response status code ${response.statusCode}');
  }

  String responseStr = await response.stream.bytesToString();

  return json.decode(responseStr);
}


Future<Map<String, dynamic>> sendImage(String imageName) async {
  LocationData location;

  try {
    location = await Location().getLocation();
  } on PlatformException {
    location = LocationData.fromMap({'latitude': 46.0503344, 'longtitude': 14.4672468});
  }

  String imageBase64 = base64.encode(await File(imageName).readAsBytes());

  Map<String, dynamic> params = {
    'team': teamToInt(currentTeam),
    'image': imageBase64,
    'lat': location.latitude,
    'lon': location.longitude
  };

  Map<String, dynamic> data = await postRequest('scan', params);

  print(data);

  if (!data['success'] || data['probability'] < 0.1) {
    print('Plant not recognized');
    return null;
  }

  print('Plant recognized');
  print('Probability: ${data["probability"]}');

  return data['plant'];
}

Future<List<Map<String, dynamic>>> getHistoryScans() async {
  Map<String, dynamic> data = await getRequest('history', {});
  return data['plants'].cast<Map<String, dynamic>>();
}