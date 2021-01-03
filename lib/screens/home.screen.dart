import 'package:flutter/material.dart';
import 'package:gita_app/helpers/home.clipper.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/screens/chapters.screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipPath(
            clipper: HomeClipper(),
            child: Container(
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                color: Colors.amber[600],
              ),
              child: Center(
                child: Text(
                  "श्रीमद्भगवद्गीता",
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            width: double.infinity,
            child: Text(
              "महाभारत के अनुसार कुरुक्षेत्र युद्ध में भगवान श्री कृष्ण ने गीता का सन्देश अर्जुन को सुनाया था।\nयह महाभारत के भीष्मपर्व के अन्तर्गत दिया गया एक उपनिषद् है।\nभगवत गीता में एकेश्वरवाद, कर्म योग, ज्ञानयोग, भक्ति योग की बहुत सुन्दर ढंग से चर्चा हुई है।",
              style: TextStyle(
                fontSize: 26,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ChaptersScreen.routeName);
            },
            color: Colors.amber[600],
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "अध्यायों की सूची",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
