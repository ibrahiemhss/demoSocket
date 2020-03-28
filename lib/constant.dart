import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class APIConstants {

  static const String OCTET_STREAM_ENCODING = "application/octet-stream";
  static const URL= "https://www.hijozaty.com";
  static String paseUrl(String local){
    return "https://www.hijozaty.com/${local??"ar"}/api";
  }
  static String webUrl(String local){
    return "https://www.hijozaty.com/${local??"ar"}";
  }
  static  ABOUT_US_URL(locale) => "${webUrl(locale)}/about";
  static const  YOUTUBE_API_ANDROID_KEY='AIzaSyDZs0gKwWKbrXhlvRbM2ojCJlMYeWXi1Rg';
  static const  YOUTUBE_API_IOS_KEY='AIzaSyBcC5Q7-PMO9m1h7dkA1rUEE5xqht_EoFk';
  static const FOLLOW_FACEBOOK_URL = 'https://www.facebook.com/hijozaty/';
  static const FOLLOW_INSTAGRAME_URL = 'https://www.instagram.com/higozaty_app/';

  //static const API_BASE_URL = "http://95.216.223.177/ar/api";

//http://95.216.223.177/ar/api/
  //main page//
  static String API_UPDATE_DEVICE_ID(locale) => "${paseUrl(locale)}/update_device_reg_id";
  //home page//
  static String API_CURRENT_PAGE = "current_page=";
  static String API_ROWS_PER_PAGE = "&rows_per_page=";
  static String API_ROWS = "&rows=";//rows
  static String API_ORDER = "&order=";//&order=
  static String API_TYPE_ID = "&type_id=";//&type_id=
  static String API_SPECIALIZATION_ID = "&specialization_id=";//specialization_id
  static String API_COUNTRY_ID = "&country_id=";//specialization_id
  static String API_PROVINCE_ID = "&province_id=";//&province_id=

  static String API_CITY_ID = "&city_id=";
  static String API_WORKDAYS = "&work_day=";
  static String API_PRICE = "&price=";
  static String API_SEARCH = "&search=";
  //settings page//
  static String API_HELP_REQUEST(locale) =>  "${paseUrl(locale)}/send_help_request";
//others
  static String API_IRAQ_GET_CITIES (locale) => "${paseUrl(locale)}/get_all_cities";
  static String API_GET_ALL_COUNTRIES (locale) => "${paseUrl(locale)}/get_countries";
  static String API_GET_COUNTRY_SERVICES (locale) => "${paseUrl(locale)}/get_country_services/";

  static String API_GET_ADS (locale) => "${paseUrl(locale)}/get_all_ads";

  static String API_GET_PRE_REGISTER (locale) => "${paseUrl(locale)}/pre_register/";
  static String API_GET_REGISTER_CONFIRM (locale) => "${paseUrl(locale)}/registerConfirm/";
  static String API_GET_PRIVACY_POLICY (locale) => "${paseUrl(locale)}/get_privacy_policy";
  static String API_GET_REVIEWS_AVERAGE (locale) => "${paseUrl(locale)}/get_doctor_reviews_average/";
  static String API_ADD_REVIEWS_AVERAGE (locale) => "${paseUrl(locale)}/add_doctor_review";

  static String API_LOGIN_URL (locale) => "${paseUrl(locale)}/login";
  static String API_REGISTER_URL (locale) => "${paseUrl(locale)}/register";
  static String API_GET_USER_INFO (locale) => "${paseUrl(locale)}/user_profile/";
  static String API_GET_IMAGE_INFO (locale) => "${paseUrl(locale)}/update_profile_image";
  static String API_GET_DR_INFO (locale) => "${paseUrl(locale)}/doctor_info/";
  static String API_GET_PH_INFO (locale) => "${paseUrl(locale)}/pharmacist_profile/";
  static String API_GET_MEDICAL_ASSISTANT_INFO (locale) => "${paseUrl(locale)}/medical_assistant_profile/";

  ///api/doctor_info/
  static String API_UPDATE_USER_INFO (locale) => "${paseUrl(locale)}/update_my_profile";
  static String API_UPDATE_DR_STEP_1 (locale) => "${paseUrl(locale)}/update_doctor_step_one";
  static String API_UPDATE_DR_STEP_2 (locale) => "${paseUrl(locale)}/update_doctor_step_two";

  ///api/ph_info/
  static String API_UPDATE_PH_STEP_1 (locale) => "${paseUrl(locale)}/update_pharamcist_step_one";
  static String API_UPDATE_PH_STEP_2 (locale) => "${paseUrl(locale)}/update_pharamcist_step_two";

  ///api/pr_info/
  static String API_UPDATE_MEDICAL_STEP_1 (locale) => "${paseUrl(locale)}/update_medical_assistant_step_one";
  static String API_UPDATE_MEDICAL_STEP_2 (locale) => "${paseUrl(locale)}/update_medical_assistant_step_two";

  static String API_SEND_MESSAGE_URL (locale) => "${paseUrl(locale)}/send_chat_message";
  static String API_GET_CHAT_URL (locale) => "${paseUrl(locale)}/get_chat/";
  static String API_MAIN_LIST = "/main_list?";
  static String API_CHAT_PUSH_NOTFICATION_URL (locale) => "${paseUrl(locale)}/send_chat_push_notification";

  static String API_GET_MAIN_LIST_URL (locale) => "${paseUrl(locale)}$API_MAIN_LIST";
  static String API_GET_SPECIALIZATIONS_URL (locale) => "${paseUrl(locale)}/specializations_list?";

  static String API_PROFILE_IMAGE_URL = "https://www.hijozaty.com/profile_images/";
  static String API_SPECIALITIES_ICONS_URL =
      "https://www.hijozaty.com/specialization_icons/";
  static String API_CHAT_IMAGE_URL = "https://www.hijozaty.com/chat_images/";
  static String API_USER_CANCEL_APPOINTMENT (locale) => "${paseUrl(locale)}/appointment/user_cancel";

  //Appointments Urls
  static String DOCTOR_DETAILS (locale) => "${paseUrl(locale)}/doctor_details";
  static String API_GET_DOCTOR_APPOINTMENTS (locale) => "${paseUrl(locale)}/get_doctor_appointments";//get_doctor_appointment
  static String API_GET_DOCTOR_APPOINTMENT (locale) => "${paseUrl(locale)}/get_doctor_appointment";//get_doctor_appointment

  static String API_GET_DOCTOR_UP_COMMING_APPOINTMENT (locale) => "${paseUrl(locale)}/get_doctor_up_coming_appointments";
  static String API_APPOINTMENT_ACCEPT (locale) => "${paseUrl(locale)}/appointment/accept";
  static String API_APPOINTMENT_UPDATE (locale) => "${paseUrl(locale)}/appointment/update";
  static String API_APPOINTMENT_POSSIBLE_STATUS (locale) => "${paseUrl(locale)}/appointment/possible_statuses";
  static String API_APPOINTMENT_RESCHEDULE (locale) => "${paseUrl(locale)}/appointment/reschedule";
  static String API_APPOINTMENT_ADD (locale) =>"${paseUrl(locale)}/appointment/add";
  static String API_APPOINTMENT_DELETE (locale) => "${paseUrl(locale)}/appointment/do_delete";

  //http://doctor_booking.com/en/api/count_user_appointments/350
//    String URL = "http://95.216.223.177/ar/api/appointment/accept";
  static String API_GET_ONE_USER_APPOINTMENT (locale) => "${paseUrl(locale)}/get_user_appointment/";

  static String API_GET_USER_APPOINTMENT (locale) => "${paseUrl(locale)}/get_user_appointments/";
  static String API_GET_COUNT_APPOINTMENTS (locale) => "${paseUrl(locale)}/count_user_appointments/";
  static String API_GET_DOCTOR_APPOINTMENTS_BY_PERIOD (locale) => "${paseUrl(locale)}/get_doctor_appointments_by_period/";

  static String API_BOOK_APPOINTMENT (locale) => "${paseUrl(locale)}/appointment/request";
  static String API_UPDATE_APPOINTMENT (locale) => "${paseUrl(locale)}/appointment/update";
  static String API_DR_ADD_APPOINTMENT (locale) => "${paseUrl(locale)}/appointment/add";
  static String API_DELETE_USER_ACOUNT (locale) => "${paseUrl(locale)}/delete_user_account";


  //****************//Descussions//*********************************************
  static String API_DESCUSSION (locale) => "${paseUrl(locale)}/discussion/";
  static String API_SPECIALIZATION_DESCUSSIONS (locale) => "${paseUrl(locale)}/specialization/discussions/";
  static String API_ADD_DESCUSSION (locale) => "${paseUrl(locale)}/add_discussion";
  static String API_ADD_DESCUSSION_REPLY (locale) => "${paseUrl(locale)}/add_discussion_reply";
  static String API_UPDATE_DESCUSSION (locale) => "${paseUrl(locale)}/update_discussion";
  static String API_DELETE_DESCUSSION (locale) => "${paseUrl(locale)}/delete_discussion";
  static String API_REPORT_DESCUSSION (locale) => "${paseUrl(locale)}/report_discussion";
  static String API_LIKE_DESCUSSION (locale) => "${paseUrl(locale)}/like_discussion";
  static String API_UNDO_LIKE_DESCUSSION (locale) => "${paseUrl(locale)}/undo_like_discussion";

  //****************//Phonebook//*********************************************
  static String API_MDICAL_PHONEBOOK_LIST = "/medical_phone_book?";
  static String API_GET_MDICAL_PHONEBOOK_LIST_URL (locale) => "${paseUrl(locale)}$API_MDICAL_PHONEBOOK_LIST";
  static String API_GET_MDICAL_PHONEBOOK_DETAILS_URL (locale) => "${paseUrl(locale)}/medical_phone_book_details/";

//https://www.doctor_booking.com/the_promo/5deb635b4d652.jpeg
//medical_phone_book_details
}

class TypeOfHttpRequest {
  static const int LOG_IN = 10;
  static const int REGISTER = 11;
  static const int GET_USER_INFO = 12;
  static const int GET_DOCTOR_INFO = 13;
  static const int GET_PHARMACIST_INFO = 14;
  static const int GET_MEDICAL_ASSISTANT_INFO = 15;
  static const int EDIT_USER_INFO = 16;
  static const int GET_SEARCH_MAIN_LIST = 49;
  static const int GET_IRAQ_PROVINCES = 50;
  static const int GET_SPECIALIZATIONS = 51;
  static const int GET_ADDS = 52;
  static const int GET_PRICES = 53;
  static const int GET_ALL_COUNTRIES = 54;
  static const int GET_COUNTRY_SERVICE = 55;
  static const int GET_DOCTOR_UP_COMMING_APPOINTMENT = 60;
  static const int GET_DOCTOR_APPOINTMENT = 61;
  static const int GET_COUNT_APPOINTMENTS = 62;
  static const int GET_SEARCH_PHONEBOOK_LIST = 63;


}

///////////////////////////////////////////////////////////////////////////////
class LocationWidgetCases {
  static const int ONE_MARKER_DETAILS = 49;
  static const int SHOW_DIALOG = 50;
  static const int REGISTER_LOCATIN = 51;
  static const int SHOW_LIST = 52;
  static const int FULL_SCREEN = 53;
}

///////////////////////////////////////////////////////////////////////////////
class SqliteConstant {
//==============================================================================
//----------------------  Specialties table ------------------------------------
//==============================================================================
  static const String TABLE_SPECIALIZATIONS = 'Specializations';
  static const String _ID = 'id';
  static const String CULMN_SPECIALIZATIONS_NAME = 'name';
  static const String CULMN_SPECIALIZATIONS_DESCRIPTION = 'description';
  static const String CULMN_SPECIALIZATIONS_ICON = 'icon';
  static const String CULMN_SPECIALIZATIONS_COLOR = 'color';

//==============================================================================
//----------------------  Cities table -----------------------------------------
//==============================================================================

  static const String TABLE_CITIES = 'Cities';
  static const String CULMN_CITY_ID = 'city_id';
  static const String COLUMN_CITY_NAME = 'city_name';
  static const String COLUMN_LAT = 'lat';
  static const String COLUMN_LONG = 'Long';

}
///////////////////////////////////////////////////////////////////////////////
class APIOperations {
  static const String PLATFORM_ID = "platform_id";
  static const String IOS = "ios";
  static const String ANDROID = "android";

  static const String LOGIN = "login";
  static const String REGISTER = "register";
  static const String CHANGE_PASSWORD = "chgPass";
  static const String SEND_MESSAGE = "send_message";

//------query parameters And Response JSON Messages----------------------------

  static const String STATUS = "status";
  static const String ERROR_DETAILS_MESSAGE = "details";
  static const String MESSAGE_STATUS = "message_status";
  static const String FCM_FAILURE = "failure";
  static const String TRUE = "true";
  static const bool FALSE = false;
  static const String SERVER_TOKEN = "token";
  static const String SUCCESS_MESSAGE = "success_msg";
  static const String SUCCESS = "success";
  static const String ID = "id";
  static const String USER_ID = "user_id"; //user_id
  static const String USER_TYPE_ID = "user_type_id"; //user_id
  static const String DOCTOR_ID = "doctor_id"; //doctor_id
  static const String DATE = "date"; //date
  static const String TIME = "time"; //time
  static const String MAIN_COMPLAINT = "main_complaint"; //time
  static const String APPOINTMENT_ID = "appointment_id"; //appointment_id
  static const String SENDER_ID = "sender_id";
  static const String RECIPIENT_ID = "recipient_id";
  static const String STARS = "stars";
  static const String OBSERVATION = "observation";

  static const String STATUS_ID = "status_id";
  static const String WORK_ITMES = "dates";//dates
  static const String CHAT_AVAILABLE = "available_for_chat";//available_for_chat
  static const String QUALIFICATIONS = "qualifications";//qualifications
  static const String SPECIALITY = "speciality";//speciality
  static const String SPECIALIZATION = "specialization";//speciality
  static const String CIRCUMCISION_AVAILABLE = "available_for_circumcision";
  static const String CERTIFICATE_NUMBER = "certificate_number";
  static const String CERTIFICATE_ISSUED_BY = "certificate_issued_by";
  static const String CERTIFICATE_ISSUED_AT = "certificate_issued_at";
  static const String LATITUDE = 'lat';
  static const String LONGITUDE = 'long';

  static const String AVERAGE = "average";

  // VARIABLES FOR PHARMACY
  static const String PHARMACY_NAME = "pharmacy_name";
  static const String PHARMACY_ADDRESS = "pharmacy_address";
  static const String PHARMACY_PHONE = "pharmacy_phone";
// VARIABLES FOR MEDICAL ASSISTANT
  static const String NUM_EXPERIENCE = "num_experience";
  static const String OFFICE_NAME = "office_name";
  static const String OFFICE_ADDRESS = "office_address";
  static const String OFFICE_PHONE = "office_phone";
  static const String HASE_CIRCUMISION = "has_circumcision";
  static const String CLINIC_NAME = "clinic_name";//clinic_name
  static const String CLINIC_PHONE = "clinic_phone";//clinic_phone
  static const String CLINIC_ADDRESS = "clinic_address";//clinic_phone
  static const String WORK_DAYS = "work_days";//clinic_phone
  // General
  static const String SPECIALAZATION_ID = "specialization_id";//clinic_phone
  static const String PRICE = "price";//clinic_phone
  static const String MESSAGE_BODY = "message_body"; //message_body
  static const String IS_IMAGE = "is_image"; //message_body
  static const String DISCUSSION_ID = "discussion_id"; //discussion_id
  static const String NEW_TEXT = "new_text"; //new_text
  static const String BODY = "body"; //message_body//title
  static const String TITLE = "title"; //message_body//title
  static const String AVAILABLE_FOR_CHAT = "available_for_chat"; //message_body//title
  static const String REPORT_BODY = "report_body"; //report_body
  static const String SPECIALIZATION_ID = "specialization_id"; //doctor_id
  static const String USERNAME = "username";
  static const String FIRST_NAME = "first_name";
  static const String LAST_NAME = "last_name";
  static const String PHONE = "phone";
  static const String EMAIL = "email";
  static const String PASSWORD = "password";
  static const String IS_DOCTOR = "is_doctor";
  static const String IMAGE_URL = "image_url";
  static const String IMGE_URL = "img_url";
  static const String IMAGE_FILE = "image_file";
  static const String DEVICE_REG_TOKEN = "device_reg_id";
  static const String CITY_ID = "city_id";
  static const String CREATED_AT = "created_at";
  static const String LANG = "lang";
  static const String NAME = "name";
  static const String CITY = "city";
  static const String GENDER = "gender";
  static const String ADDRESS = "address";
  static const String BIRTHDAY = "birth_day";
  static const String CAREER = "career";
  static const String PERIOD_INDEX = "period_index";
  static const String MSG_RECIEVER_NAME = "reciver_name";
  static const String RECEVER_ID = "receiver_id";
  static const String MSG_SENDER_NAME = "sender_name";
  static const String MSG_CONTENT = "msg_content";
  static const String MSG_IS_IMAGE = "is_image";
  static const String MSG_PIC = "pic";
  static const String USER = "user";
  static const String APPOINTMENTS_COUNT = "appointments_count";

  static const String TYPE_IMAGE_ADS = "image";
  static const String TYPE_VEDIO_ADS = "video";
  static const String TYPE_URL_ADS = "url";

  static const String VIEWS = "views";//clinic_phone

  static const String MSG = "msg";
}


class GeneralValues {

  ////// Appointments////////
  static const String NO_PROFILE_IMAGE = 'no_image.png';



}

class FCMpayload {

  ////// Appointments////////
  static const int APPOINTMENT_REQUEST = 300;
  static const int APPOINTMENT_ACCEPT = 310;
  static const int APPOINTMENT_RESCHEDULED = 320;
  static const int APPOINTMENT_CANCEL = 330;
  static const int APPOINTMENT_DONE = 340;
  static const int APPOINTMENT_IN_PROGRESS = 350;
  static const int ALL_APPOINTMENTS = 370;

  ////// CHAT////////
  static const int CHAT_MSG = 400;
}

class DateAndTimeFormate{

  static String formatTime(DateTime date) =>
      new DateFormat("HH:mm:ss", 'en').format(date);

  static  String formatDate(DateTime date) =>
      new DateFormat("yyyy-MM-dd","en").format(date);

}
///////////////////////////////////////////////////////////////////////////////
class APIResponse {
  static const String REGISTER = "register";
  static const String CHANGE_PASSWORD = "chgPass";
  static const String SUCCESS = "success";
  static const String FAILURE = "failure";
  static const String DUPLICATED = "duplicated";
  static const String NO_INTERNET_ERROR_MESSAGE = "no_internet";
  static const String WEAK_INTERNET_ERROR_MESSAGE = "weak_intenet";
  static const String NO_DATA_INTERNET_ERROR_MESSAGE = "no_data_from_internet";

  static Object DONE = "Done";
}

////////////////////////////////////////////////////////////////////////////////
class EventTtransactionsConstants {
  static const int FROM_MAIN_SCREEN = 334;
  static const int FROM_LOGIN_SCREEN = 335;

  static const int EDIT_USER_PROFILE = 23;
  static const int EDIT_DR_PROFILE_SETP1 = 34;
  static const int EDIT_DR_PROFILE_SETP2 = 45;
  static const int EDIT_PH_PROFILE_SETP1 = 35;
  static const int EDIT_PH_PROFILE_SETP2 = 46;
  static const int EDIT_PR_PROFILE_SETP1 = 36;
  static const int EDIT_PR_PROFILE_SETP2 = 47;
  static const int FROM_FCM = 55;
  static const int FROM_PREVIOUS_SCREEN = 56;

  static const int ALL_APPOINTENTS = 56;
  static const int APPOINTENT_TYPE_REVIEW = 57;
  static const int APPOINTENT_TYPE_RESERVATION = 59;
  static const int FROM_SIGNUP_SCREEN = 676;
  static const int FROM_EDIT_SCREEN = 453;

  static const int PRIVACY = 12;
  static const int ABOUT_US = 23;



}

enum PageState {LoadingSharedState, InterScreenState,ChatScreenState,ReservationsAppointmentState, ReviewAppointmentState, AppoitmentRequstedState }

////////////////////////////////////////////////////////////////////////////////
class PageIds {

  static const int INTER_SCREEN = 1;
  static const int CHAT_SCREEN = 2;
  static const int RECEIVED_NEW_APPOINTMENT_SCREEN = 3;
  static const int REVIEW_APPOINTMENT_SCREEN = 4;
  static const int REQUEST_NEW_APPOINTMENT_SCREEN = 5;

}
////////////////////////////////////////////////////////////////////////////////
class PossibleStatuses {
  static const int DELETE = 0;
  static const int PLACED = 1;
  static const int SCHEDULED = 2;
  static const int IN_PROGRESS = 3;
  static const int DONE = 4;
  static const int CANCELD = 5;
}
////////////////////////////////////////////////////////////////////////////////
class Routes {

  static const String INTER_SCREEN = '/inter_screen';
  static const String CHAT_SCREEN = '/chat_screen';
  static const String RECEIVED_NEW_APPOINTMENT_SCREEN = '/receive_appointment_screen';
  static const String REVIEW_APPOINTMENT_SCREEN = '/reveiw_appointment_screen';
  static const String REQUEST_NEW_APPOINTMENT_SCREEN = "/request_appointment_screen";

}
////////////////////////////////////////////////////////////////////////////////
class TypeOfUsers {

  static const int USER_TYPE = 1;
  static const int DOCTOR_TYPE = 2;
  static const int PHARMACIST_TYPE = 3;
  static const int MEDICAL_ASSISTANT_TYPE = 4;
  static const int DOCTOR_SECRETARY_TYPE = 5;
  static const int SALES_RESPERESNTATIVE_TYPE = 6;
  static const int HOSPITAL = 7;
  static const int CLINIC = 8;
  static const int MEDICAL_TOURISM = 9;

}

////////////////////////////////////////////////////////////////////////////////
class LikeStatus {

  static const int LIKE = 1;
  static const int DISLIKE = 2;
  static const int REPLIES_LIKE = 4;
  static const int DICUSSIONS_LIKE = 5;

}
////////////////////////////////////////////////////////////////////////////////
class TypeOfData {
  static const int FROM_INTERNET = 187;
  static const int FROM_SQLITE = 261;

}

///////////////////////////////////////////////////////////////////////////////
class EventInternetConstants {
  static const int NO_INTERNET_CONNECTION = 100;
  static const int WEAK_INTERNET_CONNECTION = 200;
  static const int NO_DATA_FROM_INTERNET = 300;

}

///////////////////////////////////////////////////////////////////////////////
class EventConstants {
  static const int NO_INTERNET_CONNECTION = 0;
  static const int SUCCESSFULL_GETTING_DATA = 343;

///////////////////////////////////////////////////////////////////////////////
  static const int LOGIN_USER_SUCCESSFUL = 500;
  static const int LOGIN_USER_UN_SUCCESSFUL = 501;

///////////////////////////////////////////////////////////////////////////////
  static const int USER_REGISTRATION_SUCCESSFUL = 502;
  static const int USER_REGISTRATION_UN_SUCCESSFUL = 503;
  static const int USER_ALREADY_REGISTERED = 504;

///////////////////////////////////////////////////////////////////////////////
  static const int CHANGE_PASSWORD_SUCCESSFUL = 505;
  static const int CHANGE_PASSWORD_UN_SUCCESSFUL = 506;
  static const int INVALID_OLD_PASSWORD = 507;
///////////////////////////////////////////////////////////////////////////////



}

///////////////////////////////////////////////////////////////////////////////
class EventMessageConstants {
  static const int NO_INTERNET_CONNECTION = 3;

///////////////////////////////////////////////////////////////////////////////
  static const int SEND_SUCCESSFUL = 300;
  static const int SEND_UN_SUCCESSFUL = 301;
}

///////////////////////////////////////////////////////////////////////////////
class APIResponseCode {
  static const int SC_OK = 200;
}


///////////////////////////////////////////////////////////////////////////////

class SharedPreferenceKeys {
  static const String USER_ID = "user_id";

  static const String IS_FIRST_INTER = "IS_FIRST_INTER";
  static const String IS_USER_LOGGED_IN = "IS_USER_LOGGED_IN";
  static const String USER = "USER";
  static const String IS_CHAT_OPENED = "IS_OPENED";
  static const String SERVER_TOKEN_ID = "server_token_id";
  static const String FCM_RECIEVE = "fcm_recieve";
  static const String LOG_IN_STATUS = "LOG_IN_STATUS";
  static const String SWITCH_CHAT_FCM = "switch_chat_fcm";
  static const String SWITCH_DISCUSSION_FCM = "switch_discussion_fcm";
  static const String COUNT_REVIEW_DR_APPOINTMENTS = "Count_Reveiw_Dr_Appointments";
  static const String COUNT_DONE_DR_APPOINTMENTS = "Count_done_Dr_Appointments";
  static const String MAIN_LIFE_CYCLE = "main_life_cycle";

  static const String COUNT_ALL_APPOINTMENTS = "Count_All_Appointments";


  static const String COUNT_ACCEPTED_DR_APPOINTMENTS = "Count_Accepted_Dr_Appointments";


  static const String COUNT_MSG = "count_msgs";


  static const int ON_OPENED_CHAT = 564;
  static const int ON_CLOSED_CHAT = 675;
  static const int FROM_FCM = 55;
  static const int FROM_HOME = 66;


  static const String LOCAL_LANGUAGE = "local_language";
  static const String IMG_URL = "img_url";
}

///////////////////////////////////////////////////////////////////////////////

class EventFCM {
  static const String SEND_SUCCESSFUL = "SUCCESS NOTIFY";
  static const String SEND_FAILED = "FAILED TO SEND NOTIFY";
}

///////////////////////////////////////////////////////////////////////////////
class ProgressDialogTitles {
  static const String IN_PROGRESS = "جاري ...";
  static const String USER_LOG_IN = "جاري التسجيل...";
  static const String USER_CHANGE_PASSWORD = "جاري التغيير";

  static String LOADING_EDITING = "جاري تحديث البيانات";
}

///////////////////////////////////////////////////////////////////////////////
class SnackBarText {
  static const String NO_INTERNET_CONNECTION = "لا يوجد اتصال !!";
  static const String LOGIN_SUCCESSFUL = "نجحت عملية تسجيل الدخول";
  static const String LOGIN_UN_SUCCESSFUL = "فشل تسجيل الدخول";
  static const String CHANGE_PASSWORD_SUCCESSFUL = "تم تغيير كبمة المرور بنجاح";
  static const String CHANGE_PASSWORD_UN_SUCCESSFUL =
      "فشل عملية تغيير كلمة المرور";
  static const String REGISTER_SUCCESSFUL = "تم التسجيل بنجاح";
  static const String REGISTER_UN_SUCCESSFUL = "فشل عملية التسجيل";
  static const String USER_ALREADY_REGISTERED =
      "الحساب موجود من قبل مستخدم آخر";
  static const String ENTER_PASS = "يرجى ادخال كلمة المرور";
  static const String ENTER_NEW_PASS = "ادخل كلمة المرور الجديدة";
  static const String ENTER_OLD_PASS = "ادخل كلمة المرور القديمة";
  static const String ENTER_EMAIL = "ادخل بريدك الالكتروني";
  static const String ENTER_VALID_MAIL = "ادخل بريدك الالكتروني بشكل صحيح";
  static const String ENTER_NAME = "يرجى ادخال الاسم";
  static const String INVALID_OLD_PASSWORD = "كلمة المرور القديمة خاطئة";
}

///////////////////////////////////////////////////////////////////////////////
class Texts {
  static const String REGISTER_NOW = "حساب جديد ؟";
  static const String LOGIN_NOW = " سجل دخول!";
  static const String LOGIN = "تسجيل دخول";
  static const String REGISTER = "حساب جديد";
  static const String PHONE = " الهاتف";
  static const String INTER_DATA_LOGIN = "ادخل الهاتف او الايميل";
  static const String INTER_PASSWORD = "ادخل كلمة المرور";

  static const String PASSWORD = "كلمة المرور";
  static const String OLD_PASSWORD = "كلمة المرور القديمة";
  static const String NEW_PASSWORD = "كلمة المرور الجديدة";
  static const String CHANGE_PASSWORD = "نغيير كلمة المرور";
  static const String LOGOUT = "تسجيل خروج";
  static const String EMAIL = "البريد الالكتروني";
  static const String NAME = "الاسم";
  static const String RECENTLY = "عُرِض مؤخراٌ";
  static const String CLEAR = "مسح";
  static const String SEND = "send";
  static const String ForgotPasswordMsg =
      " قم بادخال عنوان البريد الالكتروني \n سيتم ارسال رابط اعادة ضبط كلمة المرور الى بريدك الالكتروني";
  static const String ForgotPassword = "نسيت كلمة المرور ؟";

  static const String SEARCH = "بحث";
  static const String ADVANCED_SEARCH = "بحث متقدم";

  static const String CHAT_DOCTOR = "مراسلة الطبيب";
  static const String CANCEL_BOOKING = "الغاء الحجز";

  static const String FROM_PRICE = "من";
  static const String TO_PRICE = "الى";
}



///////////////////////////////////////////////////
