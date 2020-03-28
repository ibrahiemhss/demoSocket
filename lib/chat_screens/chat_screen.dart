import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:quiver/strings.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as imageLib;
import 'package:untitled/chat_screens/socket_io.dart';
import 'package:untitled/localization/localizations.dart';
import 'package:untitled/theme/app_theme.dart';
import 'dart:math' as Math;

import '../base_app_bar.dart';
import '../check_input_language.dart';
import '../constant.dart';
import 'chat_message_widgets.dart';
import 'message_model.dart';

class ChatScreen extends StatefulWidget {
  final String myId;
  final String recipient_id;
  final String myName;
  final String recipient_img;
  final String otherName;
  final String locale;

  const ChatScreen(
    this.locale, {
    @required this.myId,
    @required this.recipient_id,
    @required this.recipient_img,
    @required this.myName,
    @required this.otherName,
  });

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  /// Chat TextField Controller.
  TextEditingController _msgController = TextEditingController();

  /// Focus Node for Chat TextField.
  final FocusNode _focusNode = FocusNode();

  /// Messages Stored AS [Messages_model].
  List<Message_model> _messagesWidgets = <Message_model>[];
  int _lastIndexOfMessages = 0;

  /// Chat SocketIO Controller.
  ChatSocketIO _chatSocket;

  /// Image File => Used to Store Image before sending it to Socket.
  File _imageFile;

  /// Initial Loading => Shown Until Socket Connects.
  bool _isLoading = true;

  /// Initial Loading => Shown Until Socket Connects.
  bool _isSockitError = false;
  String _sockitError = '';

  /// isSending => Prevents User from sending next message before (Client-Side)
  /// finishes processing previous message.
  bool _isSending = false;

  /// isTyping Flag for other client [widget.senderId].
  bool _isTyping = false;

  /// isOnline Flag for other client [widget.senderId].
  bool _isOnline = false;

  /// Locale [AR/EN] for positioning messages and shown language.
  String locale = "ar";

  /// Current User Image Link (From SharedPreferences).
  String _myIFile;

  /// Last Seen Time for other client [widget.senderId].
  DateTime _lastSeen;

  int imageQuality = 50;
  //get my imag from sharedPreferences
  TextDirection textDirection = TextDirection.ltr;

  bool _isSlectImage = false;

  Timer timer;
  Future<void> _loadSharedPref() async {
    try {

      if (locale == 'en') {
        textDirection = TextDirection.ltr;
      } else {
        textDirection = TextDirection.rtl;
      }

    _initSocket();

    } catch (e) {
      _initSocket();
    }
  }

  bool _isThereInternet = true;

  @override
  void deactivate() {
    timer?.cancel();
    super.deactivate();
    if (!_isSlectImage) {
      if (_chatSocket != null) {
        // _chatSocket.leaveChat();

      }
    }

    print('deactivate');
  }

  int i = 1;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
    _screenDispose();
  }

  @override
  void initState() {
    _initSocket();
    super.initState();
  }
  /// initializes Socket Controller and Connects to Server.
  String _error_connection = '';
  Future<void> _initSocket() async {
    try {
      _chatSocket = ChatSocketIO(
        userId: widget.myId,
        otherId: widget.recipient_id,

        // On Connecting to Socket.
        onConnect: () {
          setState(() {
            _isLoading = false;
          });
          if (mounted)
            setState(() {
              _isLoading = false;
            });
        },
        // Fetching Old Messages.
        onFetchMessages: (val) {
          _messagesWidgets = [];
          for (var m in val) _insertChatMessage(m);
          _lastIndexOfMessages++;
          _sendAllSeenAndRebuild();
        },

        // Getting New Message.
        onMsgReceived: (val) {
          if (_msgWasPending(val)) {
            _updateSentStatus(val);
          } else {
            _insertChatMessage(val);
            _sendSeen("${val['message_id'] ?? ['id']}");
            if (mounted) setState(() {});
          }
        },

        // On Typing to Socket.
        onTyping: (val) {
          if (!_isTyping && "$val" == widget.recipient_id) {
            _isTyping = true;
            if (mounted) setState(() {});

            // disable timer after awhile;
            Timer(Duration(seconds: 2), () {
              if (mounted)
                setState(() {
                  _isTyping = false;
                });
            });
          }
        },

        // Last Seen Status.
        onLastSeen: (val) {
          try {
            _lastSeen = DateTime.parse(val[0]['last_online']);
          } catch (e) {
            debugPrint("\n\nonLastSeen : ${e.toString()}\n\n");
            _lastSeen = null;
          } finally {
            if (mounted) setState(() {});
          }
        },

        // Online Status.
        onOnline: (val) {
          if ((val as List).contains(widget.recipient_id) && mounted) {
            _setSeenStatusAll();
            setState(() {
              _isOnline = true;
            });
          } else if (_isOnline && mounted) {
             _chatSocket.checkLastSeen();
            setState(() {
              _isOnline = false;
            });
          } else {
            setState(() {
              _isOnline = false;
            });
          }
        },

        // Deleting Msg.
        onMsgDeleted: (val) {
          _deleteMsg(val);
        },

        onError: (val) {
          debugPrint(
            "\n----------------\n"
            "onError: $val\n"
            "----------------\n",
            wrapWidth: 1024,
          );
        },
      );

      // Starting Socket.
      try {
        await _chatSocket.initialize();
      } catch (e) {
        print("Sockit Error on screen ${e.toString()}");
      }
    } catch (e) {
      setState(() {
        _isSockitError = true;
        _sockitError = '${_error_connection} \n ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  /// Inserting Chat Message in first Index (0).
  void _insertChatMessage(val, {bool isPending = false}) {
    _messagesWidgets.insert(
      0,
      Message_model.fromJson(
        val,
        isPending: isPending,
        myId: widget.myId,
        myImg: _myIFile,
        myName: widget.myName,
        otherName: widget.otherName,
        forceSeen: _isOnline,
      ),
    );
  }

  /// Sending Seen flag to Socket only if [mounted].
  void _sendSeen(val) {
    if (mounted) {
      //_chatSocket.sendSeen(val);
    }
  }

  /// Sending All Seen flag to Socket
  /// This Should BeCalled Only Once on [initChat] of this page
  void _sendAllSeenAndRebuild() {
    // _chatSocket.sendAllSeen();
    if (mounted) setState(() {});
  }

  /// Looping on all messages and sets Seen flag to the ALL messages that
  /// have [isSeen] equal to false.
  void _setSeenStatusAll() {
    try {
      _messagesWidgets
          .where((msg) => msg.isSeen == false && msg.senderId == widget.myId)
          .toList()
          .map((m) => m.isSeen = true);
    } catch (e) {
      print("Couldn't set messages to seen .. ignoring .....");
    }
    if (mounted) setState(() {});
  }

  /// Looping on all messages and sets [isPending] to false flag to the first
  /// given message id, if fails basically inserts it as new message.
  void _updateSentStatus(val) {
    try {
      _messagesWidgets
          .firstWhere((msg) => msg.msgId == '${val['message_id'] ?? val['id']}')
            ..msgContent = "${val['message_body']}"
            ..isPending = false;
    } catch (e) {
      _insertChatMessage(val);
    }
    if (mounted) setState(() {});
  }

  /// Looping on all messages and sets [isDeleted] flag to the first given
  /// message id, if fails basically inserts it as new message.
  void _deleteMsg(val) {
    try {
      _messagesWidgets.firstWhere((msg) => msg.msgId == '$val').isDeleted =
          true;
    } catch (e) {
      print("Couldn't Find Msg with ID $val to Delete.. ignoring .....");
    }
    if (mounted) setState(() {});
  }

  /// Sending [leaveChat] to [_chatSocket],
  /// Disposing Our Services. [_chatSocket] and [_msgController].
  /// Clearing our values [_imageFile] [_messagesWidgets].
  Future _screenDispose() {
    // _chatSocket.leaveChat();
    // _chatSocket.dispose();
    _msgController.dispose();
    _messagesWidgets = [];
    _imageFile = null;
  }

////////////////////////////////////////////////////////////////////////////////
//------------------------------CALL-BACKS--------------------------------------
////////////////////////////////////////////////////////////////////////////////
  /// sends isTyping flag to SocketServer.
  //----------------------------------------------------------------------------
  //to specify text direction values
  //----------------------------------------------------------------------------
  bool isLastEng = false;

  void _onTypingCallBack(val) {
    //solve problem not going cursor to end of line at rtl languages when type  space
    //specifying the input type and  change textDirection depending on type of input
    setState(() {
      textDirection =
          CheckInputKeyBoard.textDirection(_msgController.text, locale, false);
    });
    // _chatSocket.sendTyping(widget.myName);
  }

////////////////////////////////////////////////////////////////////////////////
//----------------------------SEND-MSG-METHOD-----------------------------------
////////////////////////////////////////////////////////////////////////////////
  /// sends msg/image to SocketServer.
  Future<void> _sendMsg(BuildContext context,
      {String msgContent, @required bool isImage}) async {

    if (!isBlank(msgContent) || isImage) {
      setState(() => _isSending = true);
      String _randMsgId = _makeRandomIdentifier(50);
      String _date = DateTime.now().toString();

      // Sending MSG To Socket
      if (isImage) {
        // File myImg=await jpgTOpng();
        // print('MyImage_path =${myImg.path}');

        final List<int> imageBytes = await _imageFile.readAsBytes();
        msgContent = base64Encode(imageBytes);
      /*  _chatSocket.sendImg(
          msgContent,
          _makeRandomIdentifier(50),
          extension(_imageFile.path),
          widget.myId,
          _randMsgId,
          _date,
        );*/
      } else {
       /* _chatSocket.sendMsg(
          msgContent,
          widget.myId,
          _isImageToString(isImage),
          _randMsgId,
          _date,
        );*/
      }

      _insertChatMessage({
        "message_id": _randMsgId,
        "is_image": _isImageToString(isImage),
        "message_body": msgContent,
        "sender_id": widget.myId,
        "date": _date,
      }, isPending: true);

      // Clearing Chat MSG & File
      _imageFile = null;
      _msgController.text = "";
      // Restore Focus
      FocusScope.of(context).requestFocus(_focusNode);
      if (mounted) {
        setState(() {
          _isSending = false;
        });
        if (!_isOnline) {
         // _pushNotfication();
        }
      }
    }
  }


  /// Generating Random Ids for messages/files sent.
  String _makeRandomIdentifier(length) {
    final result = [];
    final characters = ''
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        'abcdefghijklmnopqrstuvwxyz'
        '0123456789';
    final charactersLength = characters.length;
    for (int i = 0; i < length; i++) {
      result.add(
        characters[((Random().nextDouble() * charactersLength).floor())],
      );
    }
    return result.join('');
  }

  // sender Image widget
  Widget get _senderProfilePic {
    return widget.recipient_img == null
        ? Container()
        : SizedBox(
            width: 50,
            height: 50,
            child: Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 4.0),
              child: ClipOval(
                child: Image.network(
                  "${APIConstants.API_PROFILE_IMAGE_URL}${widget.recipient_img}",
                  width: 38,
                  height: 38,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }
////////////////////////////////////////////////////////////////////////////////
//-----------------------------UTILS-METHODS------------------------------------
////////////////////////////////////////////////////////////////////////////////
  /// Image Picker.

  /// Converts bool to int
  String _isImageToString(bool isImage) => isImage ? '1' : '0';

  /// checks if message was pending or not, by simply checks the sender_id of it
  bool _msgWasPending(val) => widget.myId == "${val['sender_id']}";

////////////////////////////////////////////////////////////////////////////////
//-----------------------------BUILD-METHOD-------------------------------------
////////////////////////////////////////////////////////////////////////////////
  int _messageIndex = 0;

  @override
  Widget build(BuildContext context) {
    print('_messageIndex in build =${_messageIndex} ');
    _error_connection = AppLocalizations.of(context).connection_error_txt;
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        imageQuality = 50;

        break;
      case TargetPlatform.iOS:
        imageQuality = 50;

        break;
      case TargetPlatform.fuchsia:
        imageQuality = 50;

        break;
      // case TargetPlatform.macOS:
      // TODO: Handle this case.
      //   break;
    }
    return Scaffold(
      appBar: myAppBar(context),
      body: _isLoading
              ? Center(child:  Text("Loading .....",style: TextStyle(color: Colors.black)))
              : _isSockitError
                  ? Center(
                      child: Text(
                      _sockitError,
                      style: AppTheme.title,
                    ))
                  : Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 1, bottom: 1),
                              reverse: true,
                              itemBuilder: (context, int index) =>
                                  _buildChatMsg(
                                      context, index, _messagesWidgets.length),
                              itemCount: _messagesWidgets.length,
                            ),
                          ),
                          Divider(
                            height: 4.0,
                          ),
                          if (_isTyping) ...[
                            Text(
                              AppLocalizations.of(context).writing_now_txt,
                              style: AppTheme.subtitle,
                            ),
                          ],
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                            ),
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                              left: 4.0,
                              right: 4.0,
                            ),
                            child: chatInputWidget(context),
                          ),
                        ],
                      ),
                    ),
    );
  }

  String _timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    // if (locale == 'ar') {
    timeAgo.setLocaleMessages('ar', timeAgo.ArMessages());
    return timeAgo.format(date, locale: 'ar');
  }

////////////////////////////////////////////////////////////////////////////////
//----------------------------MESSAGE-WIDGET------------------------------------
////////////////////////////////////////////////////////////////////////////////
  Widget _buildChatMsg(BuildContext context, int index, int itemCount) {
    //setState(() {
    _messageIndex = index;

    // });

    return InkWell(
      child: ChatMessage(
        recipient_img: widget.recipient_img,
        chatmy_model: _messagesWidgets[index],
        isLastIndex: index == 0,
        selectorOnTap: () => _buildDeleteWidget(
            context,
            _messagesWidgets[index].msgId,
            _messagesWidgets[index].date,
            _messagesWidgets[index].senderId.toString() ==
                _messagesWidgets[index].myId),
        locale: widget.locale,
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////
//----------------------------LAST-SEEN-WIDGET----------------------------------
////////////////////////////////////////////////////////////////////////////////
  Widget get _lastSeenWidget {
    if (_lastSeen == null) {
      return Builder(builder: (context) {
        return Text(
          AppLocalizations.of(context).last_seen_txt,
          style: TextStyle(fontSize: 12, color: AppTheme.white),
        );
      });
    }

    return StreamBuilder(
      stream: Observable.periodic(Duration(minutes: 1)),
      builder: (context, __) {
        timeAgo.setLocaleMessages('ar', timeAgo.ArMessages());
        var _seen = timeAgo.format(_lastSeen, locale: /*_locale ??*/ 'ar');
        return Text(
          " (${AppLocalizations.of(context).active_since_txt} ${_seen})",
          style: TextStyle(fontSize: 12, color: AppTheme.white),
        );
      },
    );
  }

////////////////////////////////////////////////////////////////////////////////
//----------------------------APP-BAR-WIDGET------------------------------------
////////////////////////////////////////////////////////////////////////////////
  AppBar myAppBar(BuildContext context) {
    return BaseAppbar().build(
        context: context,
        title: widget.otherName,
        goScreen: () {


        },
        widgetTitle: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _senderProfilePic,
                Column(
                  children: <Widget>[
                    Text(
                      widget.otherName,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    if (_isOnline) ...[
                      Icon(
                        Icons.check_circle,
                        color: AppTheme.green,
                        size: 12,
                      ),
                    ] else ...[
                      _lastSeenWidget,
                    ],
                  ],
                ),
              ],
            )
          ],
        ),
        isShowLeading: true);
  }

////////////////////////////////////////////////////////////////////////////////
//----------------------------CHAT-DELETE-WIDGET--------------------------------
////////////////////////////////////////////////////////////////////////////////
  _buildDeleteWidget(
      BuildContext context, index, String messageTime, bool isMe) async {
    var x = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {

        });

    if (x.runtimeType == bool && x) {
      //_chatSocket.deleteMsg(index);
    }
  }

////////////////////////////////////////////////////////////////////////////////
//----------------------------CHAT-INPUT-WIDGET---------------------------------
////////////////////////////////////////////////////////////////////////////////

  Widget chatInputWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child:Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    splashColor: Colors.white,
                    icon: Icon(
                      Icons.image,
                      color: AppTheme.primaryDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _isSlectImage = true;
                      });
                    },
                  ),
                ),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        textDirection: textDirection,
                        focusNode: _focusNode,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onChanged: _onTypingCallBack,
                        controller: _msgController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)
                              .enter_the_message_txt,
                          labelText: AppLocalizations.of(context).messages_txt,
                          fillColor: AppTheme.primaryDark,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _isSending
                    ? Center(child: Text("Loading .....",style: TextStyle(color: Colors.black),))
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: IconButton(
                          splashColor: Colors.white,
                          icon: Icon(
                            Icons.send,
                            color: AppTheme.primaryDark,
                          ),
                          onPressed: () {
                            /* sendMessage(
                              context: context,
                              isImage: false,
                              msgContent: _msgController.text
                            );*/
                            _sendMsg(
                              context,
                              isImage: false,
                              msgContent: _msgController.text,
                            );
                          },
                        ),
                      ),
              ],
            ),
    );
  }

////////////////////////////////////////////////////////////////////////////////
//----------------------------PUSH NOTFICATION ---------------------------------
////////////////////////////////////////////////////////////////////////////////

}
