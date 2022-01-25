import 'package:flutter/material.dart';
import 'package:ud_flutterlab/model/user.dart';
import 'package:ud_flutterlab/pages/settings_profile.dart';
import 'package:ud_flutterlab/pages/talk_room.dart';

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<User> userList = [
    User(
      name: '田中',
      uid: 'sdf',
      imagePath:
          'https://iconbu.com/wp-content/uploads/2020/01/%E3%83%9A%E3%83%B3%E3%82%AE%E3%83%B3%E3%81%AE%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3.jpg',
    ),
    User(
      name: '加賀',
      uid: 'rui',
      imagePath:
          'https://iconbu.com/wp-content/uploads/2019/11/%E6%81%90%E7%AB%9C%E3%81%AE%E3%83%95%E3%83%AA%E3%83%BC%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('チャット履歴'),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsProfilePage()));
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: userList.length, //これはインスタンス化された要素の数文（Userの数）
            //リストビュービルダーを使うと、itemCountを設定しないと無限ループでエラーが出る
            itemBuilder: (context, index) {
              //index
              return InkWell(
                //これは下のchildのウイジェットを押せるようにする。
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TalkRoom(userList[index].name ??
                              ''))); //ここでTalkRoomへ値を値ている※１
                },
                child: Container(
                  height: 70,
                  width: 70,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0), //左右に対してのパディング
                        child: CircleAvatar(
                          //CircleAvatarこれはまるい画像を出現させる
                          backgroundImage: NetworkImage(userList[index]
                                  .imagePath ??
                              ''), //userList[index]は上から何番目をえらばれたかで動く値を変えることができる。
                          radius: 30,
                        ),
                      ),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, //文字をどこに合わせていくか（横に対して）
                        mainAxisAlignment:
                            MainAxisAlignment.center, //文字をどこに合わせていくか（縦に対して）
                        children: [
                          Text(
                            userList[index].name ?? "",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'userList[index].lastMessage ?? ""',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
