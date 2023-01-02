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

  @override
  void initState() {
    super.initState();
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
                                  print("getOpenWindowTitle--$value");
                                });
                });
                 },
              child: const Text("Window Title", style: TextStyle(color: Colors.white),),),

          ],
        ),
      ),
    );
  }
}

