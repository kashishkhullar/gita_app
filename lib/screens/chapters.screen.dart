import 'package:flutter/material.dart';
import 'package:gita_app/models/Chapter.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:provider/provider.dart';

class ChaptersScreen extends StatelessWidget {
  static final String routeName = "/chapters";

  @override
  Widget build(BuildContext context) {
    final gitaData = Provider.of<GitaData>(context);
    final List<Chapter> chapterList = gitaData.chapters;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              // height: 400,
              margin: EdgeInsets.all(30),
              width: double.infinity,
              child: Text(
                "अध्यायों की सूची",
                style: TextStyle(fontSize: 50, color: Colors.amber[600]),
                textAlign: TextAlign.center,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 18,
              itemBuilder: (context, index) =>
                  Container(child: Text(chapterList[index].name)),
            )
          ],
        ),
      ),
    );
  }
}
