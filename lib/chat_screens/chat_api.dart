import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../app_shared_preferences.dart';
import '../constant.dart';
import 'chat_model.dart';

class ChatApi {
  static const Map<String, String> apiHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json, text/plain, */*",
    "X-Requested-With": "XMLHttpRequest",
  };

  Future<List<Chat_model>> getUserChats(String myId,String locale) async {
    // Retrieving User Token
    String userToken = await AppSharedPreferences.gettSrverToken();

    // Http Request
    http.Response response = await http.get(
      "${APIConstants.API_GET_CHAT_URL(locale)}$myId",
      headers: {
        HttpHeaders.authorizationHeader: "$userToken",
        ...apiHeaders,
      },
    );

    // Decoding Response.
    var decoded = json.decode(response.body);

    // Debugging API response
    debugPrint(
      "methodName : getUserNotifications\n"
      "statusCode ${response.statusCode}\n"
      "decodedResponse $decoded",
      wrapWidth: 1024,
    );

    // Response Handling
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // OK
      List<Chat_model> _notifications = List<Chat_model>();
      decoded?.forEach((n) => _notifications.add(Chat_model.fromApi(n)));
      return _notifications;
    } else {
      // No Success
      throw throw "${response.statusCode} $decoded";
    }
  }
}
