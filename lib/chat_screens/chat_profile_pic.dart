import 'package:flutter/material.dart';

import '../constant.dart';

class ChatProfilePicture extends StatelessWidget {
  final double size;
  final String senderImg;

  const ChatProfilePicture({
    Key key,
    this.size = 20,
    this.senderImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.size,
      height: this.size,
      child: Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.only(left: 4.0),
        child: ClipOval(
          child: senderImg == null || senderImg == ''
              ? Image.asset('assets/images/blankpicture.png')
              : Image.network(
                  "${APIConstants.API_PROFILE_IMAGE_URL}$senderImg", //API_CHAT_IMAGE_URL
                  width: this.size,
                  height: this.size,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
