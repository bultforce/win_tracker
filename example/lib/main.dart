import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:win_tracker/win_tracker.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _winTrackerPlugin = WinTracker();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _winTrackerPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late WinTracker _winTracker;
  late StreamSubscription keyBoardStreamSubscription;
  late StreamSubscription mouseStreamSubscription;
  @override
  void initState() {
    super.initState();
    _winTracker = WinTracker();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              color: Colors.blue,
              onPressed: ()async{
                Timer.periodic(Duration(seconds: 5), (timer) {
                  _winTracker.getOpenWindowTitle().then((value){
                    print("getOpenWindowTitle---$value");
                    if(value=="Google Chrome"){
                      _winTracker.getOpenUrl(browserName: "Google Chrome").then((value) {
                        print("getOpenUrl--Chrome-$value");
                      });
                    }else if(value=="Safari"){
                      _winTracker.getOpenUrl(browserName: "Google Chrome").then((value) {
                        print("getOpenUrl--safari---$value");
                      });
                    }
                  });
                });
                 },
              child: const Text("Window Title", style: TextStyle(color: Colors.white),),),
            SizedBox(height: 10,),
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              color: Colors.blue,
              onPressed: ()async{
                _winTracker.getOpenUrl(browserName:"nk" ).then((value){
                  print("getOpenUrl---$value");
                });
              },
              child: const Text("Url", style: TextStyle(color: Colors.white),),),
          ],
        ),
      ),
    );
  }
}

