import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ud_flutterlab/model/talk_room.dart';
import 'package:ud_flutterlab/model/user.dart';
import 'package:ud_flutterlab/utils/shared_prefs.dart';

class Firestore {
  static FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  static final userRef = _firestoreInstance.collection('user');
  static final roomRef = _firestoreInstance.collection('room');

  static Future<void> addUser() async {
    try {
      final newDoc = await userRef.add({
        'name': '名無し',
        'image_path':
            'https://iconbu.com/wp-content/uploads/2020/01/%E3%83%9A%E3%83%B3%E3%82%AE%E3%83%B3%E3%81%AE%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3.jpg',
      });
      print('アカウント作成');

      await SharedPrefs.setUid(newDoc.id);

      List<String> userIds = await getUser();
      userIds.forEach((user) async {
        if (user != newDoc.id) {
          await roomRef.add({
            'joined_user_ids': [user, newDoc.id],
            'update_time': Timestamp.now() //firebaseだとdatetimeが適応出来ないからこの書き方
          });
        }
      });
      print('ルーム作成');
    } catch (e) {
      print('アカウント作成に失敗$e');
    }
  }

  static Future<List<String>> getUser() async {
    final snapshot = await userRef.get();
    List<String> userIds = [];
    snapshot.docs.forEach((user) {
      userIds.add(user.id);
      print('ドキュメントID:${user.id} ---名前: ${user.data()['name']}');
    });

    return userIds;
  }

  static Future<User> getProfile(String uid) async {
    final profile =
        await userRef.doc(uid).get(); //doc（）の中にとってきたいモノを書くと持ってくるものを指定できる。
    User myProfile = User(
      name: profile.data()?['name'],
      imagePath: profile.data()?['image_path'],
      uid: uid,
    );
    return myProfile;
  }

  static Future<List<TalkRoom>> getRooms(String myUid) async {
    final snapshot = await roomRef.get();
    List<TalkRoom> roomList = []; //※1リストを作る文
    snapshot.docs.forEach((doc) async {
      if (doc.data()['joined_user_ids'].contains(myUid)) {
        //contains（）で～を含む
        String? yourUid;
        doc.data()['joined_user_ids'].forEach((id) {
          if (id != myUid) {
            yourUid = id;
            return; //※１if文でつくった結果をリターンで上の※1に送る
          }
        });
        User yourProfile = await getProfile(yourUid!);
        TalkRoom room = TalkRoom(
            roomId: doc.id,
            talkUser: yourProfile,
            lastMessage: doc.data()['last_message'] ?? '');
        roomList.add(room);
      }
    });
    return roomList;
  }
}
