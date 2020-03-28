import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:untitled/localization/localizations.dart';
import 'package:untitled/theme/app_theme.dart';

import '../constant.dart';
import 'message_model.dart';

class ChatMessage extends StatelessWidget {
  final Message_model chatmy_model;
  final String locale;
  final selectorOnTap;
  final bool isLastIndex;
  final String recipient_img;
  const ChatMessage({
    @required this.chatmy_model,
    @required this.locale,
    @required this.recipient_img,

    @required this.isLastIndex,
    this.selectorOnTap,
  });

  bool get _isMe => chatmy_model.senderId.toString() == chatmy_model.myId;


  BorderRadius get _myBorder {
    return locale == 'ar'
        ? BorderRadius.only(
      topLeft: const Radius.circular(2.0),
      topRight: const Radius.circular(12.0),
      bottomRight: const Radius.circular(12.0),
      bottomLeft: const Radius.circular(12.0),
    )
        : BorderRadius.only(
      topRight: const Radius.circular(2.0),
      topLeft: const Radius.circular(12.0),
      bottomRight: const Radius.circular(12.0),
      bottomLeft: const Radius.circular(12.0),
    );
  }
  BorderRadius get _otherBorder {
    return locale == 'ar'
        ? BorderRadius.only(
      topRight: const Radius.circular(2.0),
      topLeft: const Radius.circular(12.0),
      bottomRight: const Radius.circular(12.0),
      bottomLeft: const Radius.circular(12.0),
    )
        : BorderRadius.only(
      topLeft: const Radius.circular(2.0),
      topRight: const Radius.circular(12.0),
      bottomRight: const Radius.circular(12.0),
      bottomLeft: const Radius.circular(12.0),
    );
  }

  Widget get _profilePic {
    return SizedBox(
      width: 50,
      height: 50,
      child: Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.only(left: 4.0),
        child: ClipOval(
          child: Image.network(
            isBlank(recipient_img)
                ? "${APIConstants.API_PROFILE_IMAGE_URL}${GeneralValues.NO_PROFILE_IMAGE}"
                : "${APIConstants.API_PROFILE_IMAGE_URL}${recipient_img}",
            width: 38,
            height: 38,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget get _senderName {
    return Text(
      "${chatmy_model.name}",
      textAlign: TextAlign.left,
      style: AppTheme.title,
    );
  }

  Widget  _sentTimeWidget (BuildContext context){
      return

        chatmy_model.isPending? Text(
          AppLocalizations.of(context).sending_txt,
          style: AppTheme.subtitle,
        ):
        chatmy_model.isSeen==null?Text(
          "",
            style: AppTheme.subtitle,

        ):

        !isLastIndex?Container():Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            chatmy_model.isSeen&&_isMe?
            SizedBox(
              width: 20,
              height: 20,
              child: Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 4.0),
                child: ClipOval(
                  child: Image.network(
                    isBlank(recipient_img)
                        ? "${APIConstants.API_PROFILE_IMAGE_URL}${GeneralValues.NO_PROFILE_IMAGE}"
                        : "${APIConstants.API_PROFILE_IMAGE_URL}${recipient_img}",
                    width: 15,
                    height:15,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ):Container(),
            StreamBuilder(
              stream: Observable.periodic(Duration(minutes: 1)),
              builder: (_, __) {
                return
                  Text(
                    "${AppLocalizations.of(context).send_txt} ${_timeAgoSinceDate(chatmy_model.date)}",
                    style: AppTheme.subtitle,

                  );
              },
            )

          ],
        );




  }

  Widget  _imageWidget (BuildContext context) {
    Widget _image;
    double _container_img_height;
    double _container_img_width;
    final mediaQueryData = MediaQuery.of(context);

    if (mediaQueryData.orientation == Orientation.landscape) {
      _container_img_height = MediaQuery.of(context).size.width /5;
      _container_img_width = MediaQuery.of(context).size.height / 3;

    }else{
      _container_img_height = MediaQuery.of(context).size.height /5;
      _container_img_width = MediaQuery.of(context).size.width /3;

    }
    if (chatmy_model.isPending) {
      _image = Container(
        width: _container_img_width,
        height: _container_img_height,
        child: Image.memory(
          base64Decode(chatmy_model.msgContent),
          width: _container_img_width,
          height: _container_img_height,
          fit: BoxFit.fill,
        ),
      );
    } else {

      _image=Container(
        width: _container_img_width,
        height: _container_img_height,
        child:
        Text("Image")
      );


        /*MeetNetworkImage(
          fit: BoxFit.fill,
          imageUrl:
          "${APIConstants.API_CHAT_IMAGE_URL}${chatmy_model.msgContent}",
          loadingBuilder: (context) => Center(
            child: LoadingAnimation.stillLoading()(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppTheme.greyLight,
              ),
            ),
          ),
          errorBuilder: (context, e) => Center(
            child: Image.network(
              "${APIConstants.API_CHAT_IMAGE_URL}${chatmy_model.msgContent}",
              width: _container_img_width,
              height: _container_img_height,
              fit: BoxFit.fill,
            ),
          ),
        ),
      );*/

    }

    return Builder(
      builder: (context) {
        return InkWell(
          onTap: () {

          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              clipBehavior: Clip.hardEdge,
              child: _image,
            ),
          ),
        );
      },
    );
  }

  Widget get _textWidget {
    return Builder(
      builder: (context) {
        return
          InkWell(
              onTap: selectorOnTap,

              child:
          Container(
          padding: const EdgeInsets.only(
           // bottom: 2.0,
           // top: 2.0,
            right: 8.0,
            left: 8.0,
          ),
          decoration: BoxDecoration(
            color: _isMe ? AppTheme.greyLighter:AppTheme.primary,
            borderRadius: _isMe ? _myBorder : _otherBorder,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.5,
          ),
          child: Text(
            chatmy_model.msgContent,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: _isMe ?Colors.black:AppTheme.white,
            ),
          ),
          )
          );
      },
    );
  }

  Widget  _msgBox(BuildContext context) {
    // Deleted Msg
    if (chatmy_model.isDeleted) {
      chatmy_model.msgContent = AppLocalizations.of(context).deleted_message_txt;
      return Opacity(opacity: 0.3, child: _textWidget);
    }
    // Image
    if (chatmy_model.isImage) {
      return _imageWidget(context);
    }
    // Return Text
    return _textWidget;
  }

  @override
  Widget build(BuildContext context) {


    double _container_img_height;
    double _container_img_width;
    final mediaQueryData = MediaQuery.of(context);

    if (mediaQueryData.orientation == Orientation.landscape) {
      _container_img_height = MediaQuery.of(context).size.height /0.4;
      _container_img_width = MediaQuery.of(context).size.width / 0.4;

    }else{
      _container_img_height = MediaQuery.of(context).size.width /0.4;
      _container_img_width = MediaQuery.of(context).size.height /0.4;

    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        mainAxisAlignment:
            _isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         // if (_isMe) ...[_profilePic],
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment:
                  _isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: <Widget>[
               // _senderName,
//-----------------------------if is Image not text-----------------------------
            _isMe? Row(
                  children: <Widget>[
                    _msgBox(context),
                    if ( !chatmy_model.isDeleted && chatmy_model.isImage) ...[
                      InkWell(
                        onTap: selectorOnTap,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.more_vert),
//                          child: Icon(Icons.more_horiz),
                        ),
                      ),
                    ],
                  ],
                ):
            Row(
              children: <Widget>[

                if ( !chatmy_model.isDeleted && chatmy_model.isImage) ...[
                  InkWell(
                    onTap: selectorOnTap,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.more_vert),
//                          child: Icon(Icons.more_horiz),
                    ),
                  ),
                ],
                _msgBox(context),
              ],
            ),
                _sentTimeWidget(context),
              ],
            ),
          ),
          if (!_isMe) ...[_profilePic],
        ],
      ),
    );
  }

  String _timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString.replaceAll('/', '-'));
    // if (locale == 'ar') {
    timeAgo.setLocaleMessages('ar', timeAgo.ArMessages());
    return timeAgo.format(date, locale: 'ar');
  }

}
