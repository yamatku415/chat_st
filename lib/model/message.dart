class Message {
  String? message;
  bool? isMe; //相手からおくられてきたメッセージならfalse
  DateTime? sendTime; //メッセージを送られた時間

  Message({this.message, this.isMe, this.sendTime});
}
