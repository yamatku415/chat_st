import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsProfilePage extends StatefulWidget {
  @override
  _SettingsProfilePageState createState() => _SettingsProfilePageState();
}

class _SettingsProfilePageState extends State<SettingsProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール編集'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(width: 100, child: Text('名前')),
                Expanded(child: TextField())
              ],
            ),
            SizedBox(height: 50), //空間を作りたかったのでつくっただけ、
            Row(
              children: [
                Container(width: 100, child: Text('サムネイル')),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('画像を選択'),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
