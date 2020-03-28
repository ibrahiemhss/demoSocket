import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:untitled/localization/localizations.dart';
import 'package:untitled/theme/app_theme.dart';

import '../constant.dart';
import 'chat_model.dart';

class ChatCard extends StatelessWidget {
  final Chat_model chatmy_model;
  final VoidCallback onTap;

  const ChatCard({Key key,@required this.chatmy_model,@required  this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.grey,
                    blurRadius: 5,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: CircleAvatar(
                  backgroundImage: new NetworkImage('${APIConstants.API_PROFILE_IMAGE_URL}${chatmy_model.toImage}')),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.5),
                  ),
                  child: Text(
                    "${isBlank(chatmy_model?.toName) ? AppLocalizations.of(context).other_user_txt :chatmy_model?.toName}",
                    maxLines: 1,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.5),
                  ),
                  child: Text(
                    "${chatmy_model?.date ??AppLocalizations.of(context).a_long_time_txt}",
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: AppTheme.fontName,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.5),
                ),
                child: Text(
                  "${isBlank(chatmy_model?.lastMessage) ? AppLocalizations.of(context).click_to_see_more_details_txt :chatmy_model?.lastMessage=="Image file"?'صوره':chatmy_model?.lastMessage}",
                  maxLines: 2,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontFamily:AppTheme.fontName,
                  ),
                ),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class DummyChat extends StatefulWidget {
  DummyChatState createState() => DummyChatState();
}

class DummyChatState extends State<DummyChat>
    with SingleTickerProviderStateMixin {
  AnimationController _loadingOpacity;
  Animation _opacity;

  @override
  void initState() {
    _loadingOpacity = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _opacity = Tween(begin: 0.4, end: 1.0).animate(_loadingOpacity)
      ..addListener(() {
        if (mounted) setState(() {});
      });
    _animateForward();
    super.initState();
  }

  @override
  void dispose() {
    _loadingOpacity.dispose();
    super.dispose();
  }

  void _animateForward() async {
    await _loadingOpacity.forward().then((_) {
      _animateReverse();
    });
  }
  void _animateReverse() async {
    await _loadingOpacity.reverse().then((_) {
      _animateForward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.width * 0.15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.greyLighter.withOpacity(_opacity.value),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.greyLighter,
                  blurRadius: 5,
                  spreadRadius: 2,
                )
              ],
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 13.0,
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                  color: AppTheme.greyLighter.withOpacity(_opacity.value),
                  borderRadius: BorderRadius.circular(6.5),
                ),
              ),
              Container(
                height: 13.0,
                width: 40,
                decoration: BoxDecoration(
                  color: AppTheme.greyLighter.withOpacity(_opacity.value),
                  borderRadius: BorderRadius.circular(6.5),
                ),
              ),
            ],
          ),
          subtitle: Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Container(
              height: 13.0,
              width: 40,
              decoration: BoxDecoration(
                color: AppTheme.greyLighter.withOpacity(_opacity.value),
                borderRadius: BorderRadius.circular(6.5),
              ),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
