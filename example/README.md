# window_utils_example

Demonstrates how to use the window_utils plugin.

## Example

```dart
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:window_utils/window_utils.dart';

void main() {
  if (!kIsWeb && debugDefaultTargetPlatformOverride == null) {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  }
  runApp(MyApp());
}

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
      home: WindowsFrame(
        active: Platform.isWindows,
        border: Border.all(color: Colors.grey),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: GestureDetector(
                    onTapDown: (_) {
                      WindowUtils.startDrag();
                    },
                    onDoubleTap: () {
                      WindowUtils.windowTitleDoubleTap().then((_) {
                        if (mounted) setState(() {});
                      });
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
                            WindowUtils.getWindowSize()
                                .then((val) => print('Window: $val'));
                            WindowUtils.getScreenSize()
                                .then((val) => print('Screen: $val'));
                            WindowUtils.getWindowOffset()
                                .then((val) => print('Offset: $val'));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: InkWell(
            child: Icon(Icons.drag_handle),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Max Window Size"),
                trailing: IconButton(
                  icon: Icon(Icons.desktop_windows),
                  onPressed: () {
                    WindowUtils.getScreenSize().then((val) async {
                      await WindowUtils.setSize(Size(val.width, val.height));
                      await WindowUtils.setPosition(Offset(0, 0));
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("Increase Window Size"),
                trailing: IconButton(
                  icon: Icon(Icons.desktop_windows),
                  onPressed: () {
                    WindowUtils.getWindowSize().then((val) {
                      WindowUtils.setSize(
                        Size(val.width + 20, val.height + 20),
                      );
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("Move Window Position"),
                trailing: IconButton(
                  icon: Icon(Icons.drag_handle),
                  onPressed: () {
                    WindowUtils.getWindowOffset().then((val) {
                      WindowUtils.setPosition(
                        Offset(val.dx + 20, val.dy + 20),
                      );
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("Center Window"),
                trailing: IconButton(
                  icon: Icon(Icons.vertical_align_center),
                  onPressed: () {
                    WindowUtils.centerWindow();
                  },
                ),
              ),
              ListTile(
                title: Text("Close Window"),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    WindowUtils.closeWindow();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WindowsFrame extends StatelessWidget {
  final Widget child;
  final bool active;
  final BoxBorder border;

  const WindowsFrame({
    Key key,
    @required this.child,
    @required this.active,
    this.border,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (!active) return child;
    final width = 4.0;
    final height = 4.0;
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          border != null
              ? Container(
                  decoration: BoxDecoration(border: border),
                  child: child,
                )
              : child,
          Positioned(
            top: 0,
            left: width,
            right: width,
            height: height,
            child: GestureDetector(
              onTapDown: (_) => WindowUtils.startResize(DragPosition.top),
            ),
          ),
          Positioned(
            bottom: 0,
            left: width,
            right: width,
            height: height,
            child: GestureDetector(
              onTapDown: (_) => WindowUtils.startResize(DragPosition.bottom),
            ),
          ),
          Positioned(
            bottom: height,
            top: height,
            right: 0,
            width: width,
            child: GestureDetector(
              onTapDown: (_) => WindowUtils.startResize(DragPosition.right),
            ),
          ),
          Positioned(
            bottom: height,
            top: height,
            left: 0,
            width: width,
            child: GestureDetector(
              onTapDown: (_) => WindowUtils.startResize(DragPosition.left),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            height: height,
            width: width,
            child: GestureDetector(
              onTapDown: (_) => WindowUtils.startResize(DragPosition.topLeft),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            height: height,
            width: width,
            child: GestureDetector(
              onTapDown: (_) => WindowUtils.startResize(DragPosition.topRight),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            height: height,
            width: width,
            child: GestureDetector(
              onTapDown: (_) =>
                  WindowUtils.startResize(DragPosition.bottomLeft),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            height: height,
            width: width,
            child: GestureDetector(
              onTapDown: (_) =>
                  WindowUtils.startResize(DragPosition.bottomRight),
            ),
          ),
        ],
      ),
    );
  }
}


```