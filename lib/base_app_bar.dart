import 'package:flutter/material.dart';
import 'package:untitled/theme/app_theme.dart';

class BaseAppbar  {


  Widget build({BuildContext context,String title,Function goScreen,bool isShowLeading,Widget widgetTitle}) {

    IconData _backIcon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_back;
        case TargetPlatform.iOS:
          return Icons.arrow_back_ios;
      //  case TargetPlatform.macOS:
        // TODO: Handle this case.
      //    break;
      }
      assert(false);
      return null;
    }
    return AppBar(
      elevation: 12,

      leading:isShowLeading? IconButton(
        icon: Icon(_backIcon()),
        color: Colors.white,
        alignment: Alignment.centerRight,
        tooltip: title,
        onPressed: () {
          goScreen();
        },
      ):Container(),
      title:widgetTitle==null? Text(title,
          style: AppTheme.titleLight):widgetTitle,
      backgroundColor: AppTheme.primary,
    );
  }
}
