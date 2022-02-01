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
      //getUseメソッドで作ったリストのuserIdsをadduserメッソド内のuserIdsに入れている。
      //おそらくこのuseIds変数は別物(代入しているから値は一緒)
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

    ///ここfirestoreから値をとってくる処理。スナップショットにとってきた値を入れる
    List<String> userIds = [];

    ///※1
    snapshot.docs.forEach((user) {
      //エピソード１２　docにuserの情報が入っているのでスナップショットのdocにforEach((user) で処理を行っている。
      // 　useはコレクションでforEach((user)はuserが複数ある場合はその個数分行われる。
      userIds.add(user.id);

      ///※1　この書き方でリスト型で定義しているuserIdsに(user.id)がどんどん入る
      print('ドキュメントID:${user.id} ---名前: ${user.data()['name']}');
      //user.idはドキュメントのidを取得する。user.dataはコレクションの'name']}を取得させる。
    });

    return userIds;

    ///処理を書き終わった、値の入ったuserIdsを返すことが出来る。
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
    ///キャプチャー16
    final snapshot = await roomRef.get();
    List<TalkRoom> roomList = []; //※1リストを作る文
    await Future.forEach(snapshot.docs, (doc) async {
      if (doc.data()['joined_user_ids'].contains(myUid)) {
        //contains（）で～を含む
        String? yourUid;
        doc.data()['joined_user_ids'].forEach((id) {
          if (id != myUid) {
            yourUid = id;
            return; //※１if文でつくった結果をリターンで上の※1に送る
            //foreachの処理を終わらせるreturn
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
    print(roomList.length);
    return roomList;
  }
}
