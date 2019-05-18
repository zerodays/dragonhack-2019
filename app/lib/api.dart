import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'teams.dart';

const apiUrl = 'http://134.209.251.146/api';

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
  String imageBase64 = base64.encode(await File(imageName).readAsBytes());

  Map<String, dynamic> params = {
    'team': teamToString(currentTeam),
    'image': imageBase64
  };

  Map<String, dynamic> data = await getRequest('scan', params);

  return data;
}