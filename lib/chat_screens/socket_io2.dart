import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tazz_socket/tazz_socket.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tazz_socket/tazz_socket.dart';

class ChatSocketIO2 {
  final String _socketServer = "https://www.hijozaty.com";
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
  TazzSocket myIO = new TazzSocket();

//  SocketIOManager _manager = SocketIOManager();
  var _mySocket;
  final Function onError;
  final Function onMsgDeleted;
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
      myIO.socket(_socketServer, '/chat', 'websocket', true, true, true);
      myIO.connect();
      myIO.emit("subscribe", _roomId);
      myIO.emit('getAllMessages', _roomId);
      myIO.on("fetchMessages", (data) {
        if (debugging) debugPrint("onFetchMessages ${data['oldMessages']}", wrapWidth: 1024);
       onFetchMessages(data['oldMessages']);
      });

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
