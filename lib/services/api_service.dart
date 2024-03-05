
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gifs/constants/string_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Map<String,String>>> fetchGifs(int pageNumber) async {
    List<Map<String,String>>imageUrls = [];
    int a = pageNumber*10;
    var url = Uri.https(
        StringConstants.apiUrl, StringConstants.apiPath, {'api_key': StringConstants.apiKey,'offset':'$a','limit':'10'});
  try{
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)["data"];
      for(int i = 0;i<jsonResponse.length;i++)
      {
        String imgUrl = jsonResponse[i]["images"]["downsized"]["url"];
        debugPrint(imgUrl);
        Map <String,String> image = {'imgUrl':imgUrl,'keyword':i.toString()};
        imageUrls.add(image);
      }
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }
  }
  catch(e){
    debugPrint("Error is $e");
  }

    return imageUrls;
  }
}
