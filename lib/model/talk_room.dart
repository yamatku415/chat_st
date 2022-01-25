import 'package:ud_flutterlab/model/user.dart';

class TalkRoom {
  String? roomId;
  User? talkUser;
  String? lastMessage;

  TalkRoom({this.roomId, this.talkUser, this.lastMessage});
}
