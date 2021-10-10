import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fountain_challenge/models/show.dart';

void main() {
  runApp(
    MaterialApp(
      home: FountainChallenge(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class FountainChallenge extends StatefulWidget {
  const FountainChallenge({Key? key}) : super(key: key);

  @override
  _FountainChallengeState createState() => _FountainChallengeState();
}

class _FountainChallengeState extends State<FountainChallenge> {
  late Show show;

  @override
  void initState() {
    loadJsonAsset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Row(
          children: [
            Flexible(flex: 2, child: Image.network(show.image)),
            Flexible(
              flex: 8,
              child: Column(
                children: [
                  showText(show.title),
                  showText(show.description),
                  showText(show.publisher),
                  showText(show.link),
                  showText(show.following ? "" : "not " + "followed by you"),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Fountain Challenge'),
      ),
    );
  }

  Widget showText(String text) {
    return Flexible(
      child: Text(
        text,
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
      ),
    );
  }

  void loadJsonAsset() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("mocks/appbar_mock.json");

    print(data);

    setState(() {
      show = Show.fromJson(jsonDecode(data));
    });
  }
}
