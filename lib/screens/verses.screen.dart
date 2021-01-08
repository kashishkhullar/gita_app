import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/models/Verse.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VersesScreen extends StatefulWidget {
  static final String routeName = "/verses";

  // VersesScreen({Key key}) : super(key: key);

  @override
  _VersesScreenState createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {
  int _pageNumber = 0;

  PanelController _pc;

  @override
  void initState() {
    _pc = new PanelController();
    // TODO: implement initState
    super.initState();
  }

  // int _visible = 0;

  // showCards() {
  //   if (mounted && _visible == 0) {
  //     Future.delayed(Duration(milliseconds: 20), () {
  //       setState(() {
  //         _visible = 1;
  //       });
  //     });
  //   }
  // }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("VERSES BUILD");

    int currentChapterNumber = ModalRoute.of(context).settings.arguments;
    final gitaData = Provider.of<GitaData>(context, listen: false);
    final List<Verse> verseList =
        gitaData == null ? [] : gitaData.getVerses(currentChapterNumber);

    // showCards();
    return WillPopScope(
      onWillPop: () async {
        if (_pc.isPanelClosed)
          return true;
        else {
          _pc.close();
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   decoration: BoxDecoration(color: Colors.red),
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Hero(
                tag: 100,
                child: Image.asset(
                  "assets/images/chapters/$currentChapterNumber.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              // bottom: 100,
              // bottom: MediaQuery.of(context).size.height * 0.05,
              // child: AnimatedOpacity(
              //   curve: Curves.ease,
              //   opacity: _visible == 0 ? 0.0 : 1.0,
              //   duration: Duration(seconds: 1),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7, // card height
                // width: MediaQuery.of(context).size.width * 0.7,
                child: PageView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: verseList.length,
                  controller: PageController(viewportFraction: 0.7),
                  onPageChanged: (int changedPageNumber) {
                    setState(() => _pageNumber = changedPageNumber);
                  },
                  itemBuilder: (_, index) {
                    return Transform.scale(
                      scale: index == _pageNumber ? 0.9 : 0.8,
                      child: InkWell(
                        onTap: () => _pc.open(),
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 50),
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 30),
                                child: Text(
                                  "श्लोक ${verseList[index].verseNumber}",
                                  style: TextStyle(
                                      fontSize: 60,
                                      color:
                                          Theme.of(context).primaryColorDark),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  verseList[index].text,
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // RaisedButton(
                              //   onPressed: () {
                              //     // next screen
                              //   },
                              //   color: Colors.amber[600],
                              //   child: Container(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Text(
                              //       "श्लोक का अनुवाद",
                              //       style: TextStyle(
                              //           color: Colors.white, fontSize: 25),
                              //     ),
                              //   ),
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(90)),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // ),
            ),
            SlidingUpPanel(
              collapsed: Column(
                children: [
                  Icon(Icons.drag_handle),
                  Text("अनुवाद और अर्थ पढ़ने के लिए ऊपर खिचिये",
                      style: TextStyle(
                        fontSize: 15,
                      ))
                ],
              ),
              controller: _pc,
              padding: EdgeInsets.symmetric(horizontal: 10),
              panelSnapping: true,
              backdropEnabled: true,
              backdropColor: Theme.of(context).primaryColorDark,
              minHeight: MediaQuery.of(context).size.height * 0.05,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              panel: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      // height: MediaQuery.of(context).size.height * 0.01,
                      // width: double.infinity,

                      ),
                  Column(
                    children: [
                      AutoSizeText(
                        "श्लोक",
                        textAlign: TextAlign.center,
                        minFontSize: 30,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        verseList[_pageNumber].text,
                        textAlign: TextAlign.center,
                        minFontSize: 20,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AutoSizeText(
                        "शब्दार्थ",
                        textAlign: TextAlign.center,
                        minFontSize: 30,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        verseList[_pageNumber].wordMeanings,
                        textAlign: TextAlign.center,
                        minFontSize: 20,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AutoSizeText(
                        "अनुवाद",
                        textAlign: TextAlign.center,
                        minFontSize: 30,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        verseList[_pageNumber].meaning,
                        textAlign: TextAlign.center,
                        minFontSize: 20,
                      ),
                    ],
                  ),
                  // Text(verseList[_pageNumber + 1].text),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
