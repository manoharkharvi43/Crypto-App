import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:simple_flutter_app/data/providers/theme_providers.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _initalValue = false;

  toggleSwitch(bool val) {
    setState(() => _initalValue = !_initalValue);
    Provider.of<ThemeProviders>(context, listen: false).toogleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(sections: [
      SettingsSection(
        // title: Text('Currency'),
        tiles: <SettingsTile>[
          SettingsTile.navigation(
            leading: Icon(Icons.currency_bitcoin),
            title: Text('Currency'),
            value: Text('Inr'),
          ),
          SettingsTile.switchTile(
            onToggle: (value) => toggleSwitch(value),
            initialValue: _initalValue,
            leading: Icon(Icons.format_paint),
            title: Text('Enable custom theme'),
          ),
        ],
      ),
    ]);
  }
}
