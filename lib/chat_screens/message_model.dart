
import 'package:meta/meta.dart';

class Message_model {
  String myId;
  String senderId;
  String msgId;
  String senderImg;
  String msgContent;
  String name;
  bool isImage;
  bool isSeen;
  bool isDeleted;
  bool isPending;
  String date;
  int lastIndex=0;

  Message_model.fromJson(
    Map val, {
    @required this.isPending,
    @required this.myId,
    @required myImg,
    @required myName,
    @required otherName,
        forceSeen = false,
  }) {
    this.senderId = "${val['sender_id']}";
    this.lastIndex=lastIndex++;
    this.msgId = val['message_id'] ?? ['id'];
    this.senderImg = myId == "${val['sender_id']}" ? myImg : val['sender_img'];
    this.name = (myId == "${val['sender_id']}") ? myName : otherName;
    this.date = val['created_at'] ?? DateTime.now().toString();
    this.isImage = _isToBool("${val['is_image']}");
    this.isSeen = forceSeen || _isToBool("${val['is_seen']}");
    this.isDeleted = _isToBool("${val['is_deleted']}");
    this.msgContent = val['message_body'] ?? val['message'];
  }

  bool _isToBool(String isIt) => isIt == '1' ? true : false;
}
