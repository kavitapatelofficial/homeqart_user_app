import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homeqartapp/helper/get_storage_helper.dart';
import 'package:homeqartapp/models/response/error_model.dart';
import 'package:http/http.dart' as http;
import '../theme.dart';
import 'app_exceptions.dart';

class BaseClient {
  static const int timeOutDuration = 20;
  Future<dynamic> get(bool isSecure, String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = isSecure
          ? await http.get(
              uri,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer ${box.read('access_token')}'
              },
            ).timeout(const Duration(seconds: timeOutDuration))
          : await http.get(
              uri,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ).timeout(const Duration(seconds: timeOutDuration));

      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(
      bool isSecure, String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      final response = isSecure
          ? await http
              .post(uri,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization': 'Bearer ${box.read('access_token')}'
                  },
                  body: payload)
              .timeout(const Duration(seconds: timeOutDuration))
          : await http
              .post(uri,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: payload)
              .timeout(const Duration(seconds: timeOutDuration));
      print(response.statusCode);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;

      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;

      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        ErrorModel errorModel =
            errorModelFromJson(utf8.decode(response.bodyBytes));
        Fluttertoast.showToast(
          msg: errorModel.errors![0].message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColor.primaryColor,
          textColor: Colors.white,
        );
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
