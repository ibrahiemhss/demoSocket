class Chat_model {
  String roomId;
  String toId;
  String toName;
  String toImage;
  String lastMessage;
  String date;

  Chat_model.fromApi(Map data) {
    this.roomId = data['room_id'];
    this.toId = "${data['to_who_id']}";
    this.toName = data['to_who_name'];
    this.toImage = data['to_who_image'];
    this.lastMessage = data['last_message'];
    this.date = data['time_stamp'];
  }
}
