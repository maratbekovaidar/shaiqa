

import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MusicDetectService {

  Future<Response> detectSound({required String base64string}) async {
    try {
      var response = await Dio().post(
        'https://shazam.p.rapidapi.com/songs/detect',
        data: base64string,
        options: Options(
          headers: {
            'x-rapidapi-host':'shazam.p.rapidapi.com',
            'x-rapidapi-key':'626d13b8damsh0b88914ea74a744p140510jsnfe115cdf8e95'
          },
          contentType: Headers.textPlainContentType
        ),
      );

      debugPrint("Http Status: " + response.statusCode.toString());
      print(response.data['track'] == null ? "null" : response.data['track']['hub']['actions'][1]['uri']);

      // return response.statusCode == 200 ? true : false;
      return response;

    } catch (e) {
      throw Exception(e);
    }
  }

}