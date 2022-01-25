import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:ud_flutterlab/model/message.dart';

class TalkRoom extends StatefulWidget {
  final String name;
  TalkRoom(this.name); //ここでtopPageから値が飛んできたときの受け皿を作っている

  @override
  _TalkRoomState createState() => _TalkRoomState();
}

class _TalkRoomState extends State<TalkRoom> {
  List<Message> messageList = [
    Message(
        message: 'あいうえお', isMe: true, sendTime: DateTime(2020, 1, 1, 10, 20)),
    Message(
        message: 'かきくけこれえはｋｊふぃｍｌｓっじｒｇｊｒｋｊｋｋじｒｊｋおこここおｋ',
        isMe: false,
        sendTime: DateTime(2020, 1, 1, 11, 15)),
    Message(
        message: 'あいうえお', isMe: true, sendTime: DateTime(2020, 1, 1, 10, 20)),
    Message(
        message: 'かきくけこれえはｋｊふぃｍｌｓっじｒｇｊｒｋｊｋｋじｒｊｋおこここおｋ',
        isMe: false,
        sendTime: DateTime(2020, 1, 1, 11, 15)),
    Message(
        message: 'あいうえお', isMe: true, sendTime: DateTime(2020, 1, 1, 10, 20)),
    Message(
        message: 'かきくけこれえはｋｊふぃｍｌｓっじｒｇｊｒｋｊｋｋじｒｊｋおこここおｋ',
        isMe: false,
        sendTime: DateTime(2020, 1, 1, 11, 15)),
    Message(
        message: 'あいうえお', isMe: true, sendTime: DateTime(2020, 1, 1, 10, 20)),
    Message(
        message: 'かきくけこれえはｋｊふぃｍｌｓっじｒｇｊｒｋｊｋｋじｒｊｋおこここおｋ',
        isMe: false,
        sendTime: DateTime(2020, 1, 1, 11, 15)),
    Message(
        message: 'fkkkkkkkkkkkkkkkkkkkkkkkkkkaaaaaaaaaaaaaaaajijijihhfuhvur',
        isMe: true,
        sendTime: DateTime(2020, 1, 1, 10, 20)),
    Message(
        message: 'かきくけこれえはｋｊふぃｍｌｓっじｒｇｊｒｋｊｋｋじｒｊｋおこここおｋ',
        isMe: false,
        sendTime: DateTime(2020, 1, 1, 11, 15)),
    Message(
        message: 'あいうえお', isMe: true, sendTime: DateTime(2020, 1, 1, 10, 20)),
    Message(
        message: 'かきくけこれえはｋｊふぃｍｌｓっじｒｇｊｒｋｊｋｋじｒｊｋおこここおｋ',
        isMe: false,
        sendTime: DateTime(2020, 1, 1, 11, 15)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Stack(
          children: [
            ListView.builder(
              physics:
                  RangeMaintainingScrollPhysics(), //画面に収まる数の要素の場合はスクロールしないように設定している
              reverse: true, //これは普通のリストビュービルダーだと上からしたのスクロールになるが、逆の動きになる
              shrinkWrap:
                  true, //これは今画面に表示されている要素の数だけの ListView.builderの高さに設定される（これがないと画面いっぱいが高さの設定になってしまう）
              itemCount: messageList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      left: 10,
                      right: 10,
                      bottom: index == 0
                          ? 60
                          : 0), //ボトムの参考演算子はindex（widgetの順番が）が０（最初）の時は１０、その他は０を入れるコードになっている

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .end, //カラムの場合は横に対してどのような配置にするかだが、Rowは縦に対して
                    //参考演算子
                    textDirection: messageList[index].isMe!
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.6),
                          //maxWidthはチャットの文章の横のサイズが文章の長さに対しても6割り、亜でしか表示させないようにする文章
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          decoration: BoxDecoration(
                              color: messageList[index].isMe!
                                  ? Colors.green
                                  : Colors.grey, //参考演算
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(messageList[index].message ?? "")),
                      Text(intl.DateFormat('HH:mm').format(messageList[index]
                          .sendTime!)) //DateFormatの書き方で時間の表示を合わせる事ができる。
                    ],
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    )), //expandedはこれで包まれtるwidgetは現在表示可能な大きさまで調整してくれる（この場合だと横にボタンがあるからボタンのスペースを差し引いたいい木佐のテキストフィールドを表示させる）
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
