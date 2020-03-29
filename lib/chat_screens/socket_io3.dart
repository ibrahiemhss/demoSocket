import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatSocketIO3 {
  //final String _socketServer = "https://www.hijozaty.com/chat";
  final String _socketServer = "http://95.216.223.177:3001";

  final bool debugging = false;
  final String userId;
  final String otherId;
  final Function onMsgReceived;
  final Function onFetchMessages;
  final Function onConnect;
  final Function onTyping;
  final Function onLastSeen;
  final Function onOnline;
  final Function onError;
  final Function onMsgDeleted;
  Socket _socket;
  bool _initialized = false;
  String get _roomId => int.parse(userId) > int.parse(otherId)
      ? "${otherId}_$userId"
      : "${userId}_$otherId";

  ChatSocketIO3({
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

  Future<void> initialize() async {
    print("Socket room id= $_roomId");
    try {
      _socket = await io(_socketServer, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,

       // "nameSpace": "/chat",
        //'extraHeaders': {'foo': 'bar'} // optional
      });


      _socket.on('connect', (data) {
        _socket.emit("subscribe", [_roomId, userId]);
        _socket.emit('getAllMessages', [_roomId, 100, 1]);

      });

      _socket.on('connect_error', (data) {
        print("Socket on connect_error \n ${data}...");

      });

      _socket.on('pong', (data) {
        print("Socket on pong \n ${data}...");

      });
    }catch (e){
      print("Socket On Initialization error\n ${e.toString()}...");

    }
  }

}
