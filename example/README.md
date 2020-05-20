# window_utils_example

Demonstrates how to use the window_utils plugin.

## Example

```dart
import 'package:flutter/material.dart';

import 'package:window_utils/window_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => WindowUtils.hideTitleBar(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: GestureDetector(
                  onTapDown: (_) {
                    WindowUtils.startDrag();
                  },
                  child: Material(
                    elevation: 4.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Center(
                    child: Text(
                      'Window Utils Example',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                top: 0,
                right: 0,
                child: Center(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          WindowUtils.getWindowSize().then(print);
                          WindowUtils.getWindowOffset().then(print);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(),
      ),
    );
  }
}

```