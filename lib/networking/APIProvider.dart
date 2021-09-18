import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'CustomException.dart';

class APIProvider {
  Future<dynamic> post(String url, body) async {
    var responseJson;


    try {
      final response = await http.post(Uri.parse(url), body: body, headers: {
        'Content-type': 'application/json',
      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> preLoginPost(String url) async {
    var responseJson;

    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Content-type': 'application/json',

      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> loginPost(String url) async {
    var responseJson;

    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Content-type': 'application/json',

      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    var responseJson;

    try {
      final response = await http.get(Uri.parse(url),
          headers: {'Content-type': 'application/json'});
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    print("response ${response.statusCode} ${response.body}");
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
