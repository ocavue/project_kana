import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback callback;

  SettingTile(this.title, this.subtitle, this.callback) : super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
      ),
      onTap: callback,
    );
  }
}

launchUrl(
  String url,
  String backupDialogTitle,
  String backupDialogContent,
  BuildContext context,
) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(backupDialogTitle),
          children: [Text(backupDialogContent)],
          contentPadding: EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 16.0),
        );
      },
    );
    print('Could not launch $url');
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<PackageInfo> packageInfoFuture = PackageInfo.fromPlatform();

    final List<Widget> items = [
      FutureBuilder<PackageInfo>(
        future: packageInfoFuture,
        builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
          String version = '';
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            PackageInfo packageInfo = snapshot.data;
            version = '${packageInfo.version} +${packageInfo.buildNumber}';
          }
          return SettingTile(
            'Check for update',
            version,
            () => launchUrl('url', 'Language', 'Work in process', context),
          );
        },
      ),
      SettingTile(
        'Language',
        'English',
        () => launchUrl('url', 'Language', 'Work in process', context),
      ),
      SettingTile('Author', '@Ocavue', () async {
        const url = 'https://github.com/ocavue/';
        await launchUrl(url, 'Author', 'Please visit $url', context);
      }),
      SettingTile('License', 'GNU General Public License v3.0', () async {
        const url =
            'https://github.com/ocavue/project_kana/blob/master/LICENSE';
        await launchUrl(url, 'License', 'Please visit $url', context);
      }),
      SettingTile('Suggestion', null, () async {
        const email = 'ocavue@gmail.com';
        const url = 'mailto:smith@$email?subject=ProjectKanaSuggestion&body=';
        await launchUrl(url, 'Suggestion', 'Please contact $email', context);
      }),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView.builder(
        itemCount: items.length * 2 - 1,
        itemBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? items[index ~/ 2] : Divider(height: 0);
        },
      ),
    );
  }
}
