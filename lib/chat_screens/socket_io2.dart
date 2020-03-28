import 'package:better_socket/better_socket.dart';
import 'dart:convert';

import 'package:flutter/material.dart';


class ChatSocketIO2 {
  final String _socketServer = "hijozaty.com/chat";
  //final String _socketServer = "http://95.216.223.177:3001";

  final bool debugging = false;
  final String userId;
  final String otherId;
  final Function onMsgReceived;
  final Function onFetchMessages;
  final Function onConnect;
  final Function onTyping;
  final Function onLastSeen;
  final Function onOnline;
//  SocketIOManager _manager = SocketIOManager();
  var _mySocket;
  final Function onError;
  final Function onMsgDeleted;
  BetterSocket _socket;
  bool _initialized = false;
  String get _roomId => int.parse(userId) > int.parse(otherId)
      ? "${otherId}_$userId"
      : "${userId}_$otherId";

  ChatSocketIO2({
    @required this.userId,
    @required this.otherId,
    @required this.onMsgReceived,
    @required this.onFetchMessages,
    @required this.onConnect,
    @required this.onTyping,
    @required this.onLastSeen,
    @required this.onOnline,
    @required this.onError,
    @required this.onMsgDeleted,
  });


  initialize() async{


    try {
      BetterSocket.connentSocket("ws://$_socketServer", trustAllHost: true);
      BetterSocket.addListener(onOpen: (httpStatus, httpStatusMessage) {

        print(
            "onOpen---httpStatus:$httpStatus  httpStatusMessage:$httpStatusMessage");
      }
      , onMessage: (message) {

        print("onMessage---message:$message");
      }, onClose: (code, reason, remote) {
        print("onClose---code:$code  reason:$reason  remote:$remote");
      }, onError: (message) {
        print("onError---message:$message");
      });
      _initialized = true;
    }catch (e){
      print("Socket On Initialization error\n ${e.toString()}...");

    }
  }

  void _getConnections(dynamic data){
    print("Socket status: " + data);
    Map<String,dynamic> map = new Map<String, dynamic>();
    map = json.decode(data);

  }

  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }

  _subscribe(String data) {
  }
  _getAllMessages(dynamic data) {
    print("getAllMessages from UFO: " + data);
  }
  _checkLastSeen(dynamic data) {
    print("Socket_fetchMessages ${data['oldMessages']}");

    print("getAllMessages from UFO: " + data);
  }
  _fetchMessages(dynamic data) {
    print("Socket_fetchMessages ${data['oldMessages']}");

    onFetchMessages(data['oldMessages']);
  }
  _userLastSeen(dynamic data) {
    print("Socket_userLastSeen ${data['last_seen']}");

    onLastSeen(data['last_seen']);
  }
  _messageReceived(dynamic data) {
    print("Socket_messageReceived ${data}");

    onMsgReceived(data);
  }
  _typing(dynamic data) {
    print("Socket_typing id  ${data['senderId']}");

    onTyping(data['senderId']);
  }
  _whoIsOnline(dynamic data) {
    print("Socket_whoIsOnline ${data['onlineUsers']}");

    onOnline(data['onlineUsers']);
  }
  _messageDeleted(dynamic data) {
    print("Socket_messageDeleted ${data['message_id']}");

    onMsgDeleted(data['message_id']);
  }
  _error(dynamic data) {
    print("Socket_onError ${data}");
    onError(data);
  }
}
