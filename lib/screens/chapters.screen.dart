import 'package:flutter/material.dart';
import 'package:gita_app/models/Chapter.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:provider/provider.dart';

class ChaptersScreen extends StatelessWidget {
  static final String routeName = "/chapters";

  @override
  Widget build(BuildContext context) {
    final gitaData = Provider.of<GitaData>(context);
    final List<Chapter> chapterList =
        gitaData == null ? [] : gitaData.getChapters();

    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(color: Colors.amber[600]),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100, bottom: 50),
              width: double.infinity,
              child: Text(
                "अध्यायों की सूची",
                style: TextStyle(fontSize: 50, color: Colors.amber[600]),
                textAlign: TextAlign.center,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: chapterList.length,
              itemBuilder: (context, index) => Container(
                decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 20,
                      spreadRadius: -10,
                      offset: Offset(0, 20),
                    )
                  ],
                ),
                // width: 300,
                // height: 300,
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 40),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Image.asset(
                            "assets/images/chapters/${index + 1}.jpg",
                            // height: 150,
                            fit: BoxFit.fitWidth,
                            // width: 100,
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              "अध्याय ${chapterList[index].chapter_number}",
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.amber[600],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              chapterList[index].name,
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.amber[600],
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ClipRRect(
              //
              // child:
              // FittedBox(
              //   child:
              //   // fit: BoxFit.fitWidth,
              // ),
              // ),

              // padding: EdgeInsets.all(20),
              // margin: EdgeInsets.all(30),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(50),
              //     boxShadow: [BoxShadow()],
              //     color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
