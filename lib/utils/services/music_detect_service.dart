
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MusicDetectService {

  void detectSound({required String base64string}) async {
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
      debugPrint("Body: " + response.data.toString());

    } catch (e) {
      throw Exception(e);
    }
  }

}