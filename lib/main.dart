import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled/theme/app_theme.dart';

import 'app_shared_preferences.dart';
import 'chat_screens/chat_screen.dart';
import 'localization/locale_helper.dart';
import 'localization/localizations.dart';
import 'localization/translations.dart';

/// Start launch flutter code on this [main]

void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  //-----------------------------------------------------------------//
  // before open app get important data from SharedPreferences
  //-----------------------------------------------------------------//

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: AppTheme.primaryDark, // navigation bar color
    statusBarColor: AppTheme.primaryDark, // status bar color
  ));
  var locale = await AppSharedPreferences
      .getLocale(); //get last value of selected language in app
  int appointmentsCount = await AppSharedPreferences.getCountAllAppointments();
  int msgsCount = await AppSharedPreferences.getCountMsgs();

  print(
      "==============================_appointmentsCount 1 is ==============================>\n$appointmentsCount");
  String lifeCycle; //registered lifecycle of the last opening app
  //await allTranslations.init();
  try {
    lifeCycle = await AppSharedPreferences.grtMainLifeSycle();
  } catch (NoSuchMethodError) {}

  runApp(
    MyApp(
      locale: locale,
      lifeCycle: lifeCycle,
      appointmentsCount: appointmentsCount,
      msgsCount: msgsCount,
    ),
  );
}

/// inter app [MyApp]----------------------------------------------------------
/// [RouteObserver] that Observing the changes of routes to go other screen
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
typedef ExceptionCallback = void Function(dynamic exception);

class MyApp extends StatefulWidget {
  final String locale;
  final String lifeCycle;
  final int appointmentsCount;
  final int msgsCount;

  MyApp({
    this.locale,
    this.lifeCycle,
    this.appointmentsCount,
    this.msgsCount,
  });

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //----------------------------------------------------------------------------
  /// Functions to set local languages with [SpecificLocalizationDelegate]
  //----------------------------------------------------------------------------
  SpecificLocalizationDelegate _specificLocalizationDelegate;

  /// initializes Socket Controller and Connects to Server.
  onLocaleChange(Locale locale) {
    setState(() {
      _specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  _onLocaleChanged() async {
    // do anything you need to do if the language changes
    print('Language has been changed to: ${allTranslations.currentLanguage}');
  }

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();


    //--------------------------------------------------------------------------
    // set local language of app as it saved in sharedPreferences from settings
    //--------------------------------------------------------------------------
    helper.onLocaleChanged = onLocaleChange;
    allTranslations.onLocaleChangedCallback = _onLocaleChanged;
    if (widget.locale != null) {
      print("MY language is ===================>0 ${widget.locale}");
      _specificLocalizationDelegate =
          SpecificLocalizationDelegate(new Locale(widget.locale));
    } else {
      _specificLocalizationDelegate =
          SpecificLocalizationDelegate(new Locale("en"));
    }

    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        new FallbackCupertinoLocalisationsDelegate(),
        //app-specific localization
        _specificLocalizationDelegate
      ],
      supportedLocales: allTranslations.supportedLocales(),
      locale: _specificLocalizationDelegate.overriddenLocale,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      theme: ThemeData(
        canvasColor: AppTheme.backgroundColor,
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: ChatScreen("ar",myId:"623",recipient_id:"598",myName:"demo",recipient_img:"5e31ae94d6a8a.png",otherName:"demo2")
      );
      }

}
