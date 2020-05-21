import 'package:englishnote/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'English Note',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: BannerClipper(),
            child: Container(
              padding: EdgeInsets.only(top: 10, right: 20),
              height: size.height * 0.45,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xFFbdc3c7), Color(0XFF2c3e50)]),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset("assets/icons/menu.svg")),
                  Center(
                    child: RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                            style: TextStyle(
                                fontFamily: 'Hazard',
                                fontFamilyFallback: <String>['Hazard']),
                            children: [
                              TextSpan(
                                  text: "English For",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 65,
                                      color: Color(0xFFbdc3c7),
                                      fontFamily: 'Hazard')),
                              TextSpan(
                                text: "\nFUN",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 70,
                                    color: Color(0xFF2c3e50),
                                    fontFamily: 'Hazard'),
                              )
                            ])),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.95,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: <Widget>[
                          HomeCard(),
                          HomeCard(),
                          HomeCard(),
                          HomeCard(),HomeCard(),HomeCard()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(2, 5),
            blurRadius: 5,
            spreadRadius: -2,
            color: kShadowColor)
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          SvgPicture.asset("assets/icons/vocabulary.svg"),
          Spacer(),
          Text(
            "Vocabulary",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0XFF2c3e50)),
          ),
          Spacer()
        ],
      ),
    );
  }
}

class BannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = new Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
