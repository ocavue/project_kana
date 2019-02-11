import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String text;

  SettingTile(this.text) : super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(text),
      ),
      onTap: () {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('WIP')),
        );
      },
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      SettingTile('Language'),
      SettingTile('Suggestion'),
      SettingTile('About'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      // body: ListView(
      //   children: items,
      // ),
      body: ListView.builder(
        itemCount: items.length * 2 - 1,
        itemBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? items[index ~/ 2] : Divider(height: 0);
        },
      ),
    );
  }
}
