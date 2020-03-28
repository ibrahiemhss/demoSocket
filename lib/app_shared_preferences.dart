import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class AppSharedPreferences {
///////////////////////////////////////////////////////////////////////////////
  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

///////////////////////////////////////////////////////////////////////////////
  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

///////////////////////////////////////////////////////////////////////////////
  static Future<bool> isFirstInter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferenceKeys.IS_FIRST_INTER);
  }

///////////////////////////////////////////////////////////////////////////////

  static Future<void> setFirstInter(bool isFirstInter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(SharedPreferenceKeys.IS_FIRST_INTER, isFirstInter);
  }

///////////////////////////////////////////////////////////////////////////////
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferenceKeys.IS_USER_LOGGED_IN);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<void> setUserLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(SharedPreferenceKeys.IS_USER_LOGGED_IN, isLoggedIn);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<void> setLocal(String local) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(SharedPreferenceKeys.LOCAL_LANGUAGE, local);
  }
///////////////////////////////////////////////////////////////////////////////

  static  getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferenceKeys.LOCAL_LANGUAGE);
  }

///////////////////////////////////////////////////////////////////////////////

  static Future<void> setSrverToken(String server_tokrn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(SharedPreferenceKeys.SERVER_TOKEN_ID, server_tokrn);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<String> gettSrverToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferenceKeys.SERVER_TOKEN_ID);
  }

///////////////////////////////////////////////////////////////////////////////
  static Future<bool> isChatOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferenceKeys.IS_CHAT_OPENED);
  }

///////////////////////////////////////////////////////////////////////////////

  static Future<void> setChatOpen(bool isOpened) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(SharedPreferenceKeys.IS_CHAT_OPENED, isOpened);
  }

///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////

  static Future<void> setUSERID(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(SharedPreferenceKeys.USER_ID, id);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<int> getUSERID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedPreferenceKeys.USER_ID);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<void> setWhenFcmRecieve(String result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(SharedPreferenceKeys.FCM_RECIEVE, result);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<String> getWhenFcmRecieve() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferenceKeys.FCM_RECIEVE);
  }

///////////////////////////////////////////////////////////////////////////////

  static Future<void> setLogInStatus(int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(SharedPreferenceKeys.LOG_IN_STATUS, status);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<int> getLogInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedPreferenceKeys.LOG_IN_STATUS);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<void> setSwitchChatFCM(int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(SharedPreferenceKeys.SWITCH_CHAT_FCM, status);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<int> getSwitchChatFCM() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedPreferenceKeys.SWITCH_CHAT_FCM);
  }
///////////////////////////////////////////////////////////////////////////////
 /* static Future<void> setDiscussionFCM(int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(SharedPreferenceKeys.SWITCH_DISCUSSION_FCM, status);
  }*/
///////////////////////////////////////////////////////////////////////////////

 /* static Future<int> getDiscussionFCM() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedPreferenceKeys.SWITCH_DISCUSSION_FCM);
  }*/
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
 static Future<void> setCountMsgs(int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(SharedPreferenceKeys.COUNT_MSG, status);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<int> getCountMsgs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedPreferenceKeys.COUNT_MSG);
  }


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
 static Future<void> setCountAllAppointments(int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(SharedPreferenceKeys.COUNT_ALL_APPOINTMENTS, status);
  }
///////////////////////////////////////////////////////////////////////////////
 static Future<int> getCountAllAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedPreferenceKeys.COUNT_ALL_APPOINTMENTS);
  }


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
  static Future<void> setCountAcceptedDrAppointments(int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(SharedPreferenceKeys.COUNT_ACCEPTED_DR_APPOINTMENTS, status);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<int> getCountAcceptedDrAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedPreferenceKeys.COUNT_ACCEPTED_DR_APPOINTMENTS);
  }
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
  static Future<void> setCountReveiwDrAppointments(int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(SharedPreferenceKeys.COUNT_REVIEW_DR_APPOINTMENTS, status);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<int> getCountReveiwDrAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedPreferenceKeys.COUNT_REVIEW_DR_APPOINTMENTS);
  }
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
  static Future<void> setCountDoneDrAppointments(int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(SharedPreferenceKeys.COUNT_DONE_DR_APPOINTMENTS, status);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<int> getCountDoneDrAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedPreferenceKeys.COUNT_DONE_DR_APPOINTMENTS);
  }
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
  static Future<void> setMainLifeSycle(String state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(SharedPreferenceKeys.MAIN_LIFE_CYCLE, state);
  }
///////////////////////////////////////////////////////////////////////////////

  static Future<String> grtMainLifeSycle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferenceKeys.MAIN_LIFE_CYCLE);
  }
///////////////////////////////////////////////////////////////////////////////

}
