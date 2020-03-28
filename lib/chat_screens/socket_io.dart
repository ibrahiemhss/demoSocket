import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/options.dart';
import 'package:adhara_socket_io/socket.dart';
import 'package:flutter/material.dart';

class ChatSocketIO {
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
  final Function onError;
  final Function onMsgDeleted;
  SocketIOManager _manager = SocketIOManager();
  SocketIO _socket;
  bool _initialized = false;
  String get _roomId => int.parse(userId) > int.parse(otherId)
      ? "${otherId}_$userId"
      : "${userId}_$otherId";

  ChatSocketIO({
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
      _socket = await _manager.createInstance(
        SocketOptions(
          "$_socketServer",
          enableLogging: debugging,
          transports: [Transports.WEB_SOCKET],
         // nameSpace: "/chat",
        ),
      );

        _socket.onConnect((data) {
          onConnect();
          _socket.emit("subscribe", [_roomId, userId]);
          _socket.emit('getAllMessages', [_roomId, 100, 1]);
          checkLastSeen();
        });

      _socket.connect();
      _initialized = true;

    }catch (e){
      print("Socket On Initialization error\n ${e.toString()}...");

    }
  }

  void _activeListeners() {


    try {
      _socket.on("userLastSeen", (data) {
        if (debugging) debugPrint("onLastSeen $data", wrapWidth: 1024);
        onLastSeen(data['last_seen']);
      });
    }catch (e){
      print("Socket on userLastSeen error\n ${e.toString()}...");

    }

    try {
      _socket.on("fetchMessages", (data) {
        if (debugging) debugPrint("onFetchMessages $data", wrapWidth: 1024);
        onFetchMessages(data['oldMessages']);
      });
    }catch (e){
      print("Socket on fetchMessages error\n ${e.toString()}...");

    }


    try {
      _socket.on("messageReceived", (data) {
        if (debugging) debugPrint("onMsgReceived $data", wrapWidth: 1024);
        onMsgReceived(data);
      });

    }catch (e){
      print("Socket on messageReceived error\n ${e.toString()}...");

    }


    try {
      _socket.on("typing", (data) {
        if (debugging) debugPrint("onTyping $data", wrapWidth: 1024);
        onTyping(data['senderId']);
      });

    }catch (e){
      print("Socket on typing error\n ${e.toString()}...");

    }


    try {
      _socket.on("whoIsOnline", (data) {
        if (debugging) debugPrint("onOnline $data", wrapWidth: 1024);
        onOnline(data['onlineUsers']);
        checkLastSeen();
      });
    }catch (e){
      print("Socket on whoIsOnline error\n ${e.toString()}...");

    }


    try {
      _socket.on("messageDeleted", (data) {
        if (debugging) debugPrint("onMsgDeleted $data", wrapWidth: 1024);
        onMsgDeleted(data['message_id']);
      });

    }catch (e){
      print("Socket on messageDeleted error\n ${e.toString()}...");

    }


    try {

      _socket.on("error", (data) {
        print("onError ${data}");
        onError(data);
      });
    }catch (e){
      print("Socket on error error\n ${e.toString()}...");

    }

    try {
      _socket.on("disconnect", (data) {
        if (debugging) debugPrint("disconnect $data", wrapWidth: 1024);
        leaveChat();
      });
    }catch (e){
      print("Socket on disconnect error\n ${e.toString()}...");

    }
    
  }

  Future<void> sendMsg(
    msg,
    senderId,
    isImage,
    pendingMsgId,
    date,
  ) async {
    await _socket.emit('sendMessage', [
      msg,
      senderId,
      _roomId,
      isImage,
      pendingMsgId,
      date,
    ]);
  }

  Future<void> sendImg(
    image,
    fileName,
    extension,
    senderId,
    pendingMsgId,
    date,
  ) async {
    await _socket.emit('sendImage', [
      image, //imageFile
      pendingMsgId, //messageId
      extension, //extension
      senderId, //senderId
      _roomId, //roomId
      'base64', //type
      pendingMsgId, //messageId
      '', //customData
      date, //createdAt
    ]);
  }

//  Future<void> getAllMessages(data) async {
//    _socket.emit('getAllMessages', [_roomId, 100, 1]);
//    onFetchMessages(data['oldMessages']);
//  }

  Future<void> startChat() async {
    try {
      await _socket.emit('subscribe', [_roomId, userId]);
      print("Socket emit subscribe");

    }catch (e){
      print("Socket emit subscribe error\n ${e.toString()}...");

    }
  }

  Future<void> deleteMsg(msgId) async {

    try {
      await _socket.emit('deleteMessage', [_roomId, msgId]);
      print("Socket emit deleteMessage");

    }catch (e){
      print("Socket emit deleteMessage error\n ${e.toString()}...");

    }
  }

  Future<void> sendTyping(senderName) async {

    try {
      await _socket.emit('typing', [_roomId, userId, senderName]);
      print("Socket emit typing");

    }catch (e){
      print("Socket emit typing error\n ${e.toString()}...");

    }
  }

  Future<void> sendSeen(msgId) async {
    try {
      await _socket.emit('messageSeen', [msgId]);
      print("Socket emit messageSeen");

    }catch (e){
      print("Socket emit messageSeen error\n ${e.toString()}...");

    }
  }

  Future<void> sendAllSeen() async {

    await _socket.emit('allMyMessagesSeen', [_roomId, userId]);
  }

  Future<void> leaveChat() async {
    await _socket.emit('unsubscribe', [_roomId, userId]);
  }

  Future<void> checkLastSeen() async {
    _socket.emit('checkLastSeen', [_roomId, otherId]);
  }

  void dispose() {
    if (debugging) debugPrint("clearing ${_socket.id}");
    _manager.clearInstance(_socket);
    _initialized = false;
  }
}
