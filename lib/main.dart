import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fountain_challenge/models/show.dart';

void main() {
  runApp(
    MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaleFactor: 1.0),
            child: FountainChallenge(),
          );
        },
      ),
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
  @override
  void initState() {
    loadJsonAsset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: FutureBuilder<Show>(
            future: loadJsonAsset(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Image.network(
                            snapshot.data!.image,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  value: loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!,
                                ),
                              );
                            },
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: Column(
                            children: [
                              showText(snapshot.data!.title),
                              showText(snapshot.data!.description),
                              showText(snapshot.data!.publisher),
                              showText(snapshot.data!.link),
                              showText(snapshot.data!.following
                                  ? ""
                                  : "not " + "following"),
                            ],
                          ),
                        ),
                      ],
                    );
            }),
      ),
      body: Center(
        child: Text('Fountain Challenge'),
      ),
    );
  }

  Widget showText(String text) {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
        ),
      ),
    );
  }

  Future<Show> loadJsonAsset() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("mocks/appbar_mock.json");

    return Show.fromJson(jsonDecode(data));
  }
}
