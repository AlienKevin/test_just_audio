import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late AudioPlayer _player;
  final _playlist = ConcatenatingAudioSource(
      children: [
    "zou2",
    "san4",
    "ngo5",
    "dei6",
    "gam1",
    "jat6",
    "heoi3",
    "coeng3",
    "go1",
    "tiu3",
    "mou2",
  ]
          .map((word) => AudioSource.uri(
                Uri.parse("asset:///assets/jyutping_wong/${word}.wav"),
              ))
          .toList());

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    () async {
      try {
        await _player.setAudioSource(_playlist);
      } catch (e) {
        print("Error loading audio source: $e");
      }
    }();
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    log("play sound");
    _player.seek(Duration.zero, index: 0);
    _player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          //
          //
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
