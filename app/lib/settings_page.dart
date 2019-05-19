import 'package:dragonhack_2019/main.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final List<String> overlayOptions;
  final Function callback;
  final int selected;

  SettingsPage(this.overlayOptions, this.callback, this.selected);

  @override
  State<StatefulWidget> createState() => SettingsPageState(selected);
}

class SettingsPageState extends State<SettingsPage> {
  int selected;

  SettingsPageState(this.selected);

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [];

    for (int i = 0; i < widget.overlayOptions.length; ++i) {
      options.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: ChoiceChip(
          onSelected: (selected) {
            if (selected) {
              setState(() {
                this.selected = i;
              });
              widget.callback(i);
              Navigator.of(context).pop();
            }
          },
          label: Text(widget.overlayOptions[i]),
          selected: i == this.selected,
        ),
      ));
    }

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
            child: Card(
              elevation:
                  Theme.of(context).brightness == Brightness.dark ? 7 : 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                    child: Text(
                      'Select Map Layer',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Wrap(
                    children: options,
                  )
                ]),
              ),
            )),
        Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
            child: Card(
                elevation:
                    Theme.of(context).brightness == Brightness.dark ? 7 : 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Toggle Dark Theme',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600),
                        ),
                        Switch(
                          value: myAppState.dark,
                          onChanged: (value) {
                            myAppState.setState(() {
                              myAppState.dark = value;
                            });
                          },
                        ),
                      ],
                    ))))
      ],
    ));
  }
}
