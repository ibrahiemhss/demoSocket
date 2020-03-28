import  'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

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
  SocketIOManager _manager = SocketIOManager();

  final Function onError;
  final Function onMsgDeleted;
  SocketIO _socket;
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


  initialize() {
    try {
      //update your domain before using
      _socket = SocketIOManager().createSocketIO(
          _socketServer, "/chat",
           query: "userId=$userId",
          socketStatusCallback: _socketStatus);


      //call init socket before doing anything
      _socket.init();
      _socket.subscribe("subscribe", _subscribe([_roomId, userId]));
      _socket.subscribe('getAllMessages', _getAllMessages([_roomId, 100, 1]));
      _socket.subscribe('checkLastSeen', _checkLastSeen([_roomId, otherId]));
      _socket.subscribe('fetchMessages', _fetchMessages);
      _socket.subscribe('userLastSeen', _userLastSeen);
      _socket.subscribe('messageReceived', _messageReceived);
      _socket.subscribe('typing', _typing);
      _socket.subscribe('whoIsOnline', _whoIsOnline);
      _socket.subscribe('messageDeleted', _messageDeleted);
      _socket.subscribe('error', _error);




      //connct socket
      _socket.connect();
      _initialized = true;
    }catch (e){
      print("Socket On Initialization error\n ${e.toString()}...");

    }
  }


  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }

  _subscribe(dynamic data) {
    print("subscribe from UFO: " + data);
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
