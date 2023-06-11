import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/model.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(
      builder: (context,mode,child) => ListView(
        children: [
        // ignore: prefer_const_constructors
        ListTile(
          leading: const Icon(Icons.lightbulb),
          title: const Text('Dark/light mode'),
          onTap: () async {
            final ret = await Navigator.of(context).push<ThemeMode>(
                MaterialPageRoute(
                  builder: (context) => ThemeModeSelectionPage(init: mode.mode),
                ),
              );
              if( ret !=null) {
                mode.update(ret);
              }
            }
          )
        ],
      ),
    );
  }
}

class ThemeModeSelectionPage extends StatefulWidget {
  const ThemeModeSelectionPage({
    Key? key,
    required this.init,
  }) : super(key: key);
  final ThemeMode init;
  @override
  // ignore: library_private_types_in_public_api
  _ThemeModeSelectionPage createState() => _ThemeModeSelectionPage();
}

class _ThemeModeSelectionPage extends State<ThemeModeSelectionPage> {
  late ThemeMode _current;
  @override
  void initState() {
    super.initState();
    _current = widget.init;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop<ThemeMode>(context, _current), // 暫定でlight,
              ),
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: ThemeMode.system,
              title: const Text('System'),
              onChanged: (val) => {setState(() => _current = val!)},
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: ThemeMode.system,
              title: const Text('Dark'),
              onChanged: (val) => {},
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: ThemeMode.system,
              title: const Text('Light'),
              onChanged: (val) => {},
            ),
          ],
        ),
      ),
    );
  }
}