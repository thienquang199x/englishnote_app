import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:englishnote/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

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

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        value: 0.0,
        duration: Duration(seconds: 25),
        upperBound: 1,
        lowerBound: -1,
        vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          color: Color(0XFFbdc3c7),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.blueAccent,
          height: 60,
          index: 1,
          items: <Widget>[
            Icon(
              Icons.verified_user,
              size: 30,
              color: Colors.black,
            ),
            Icon(
              Icons.add,
              size: 30,
              color: Colors.black,
            ),
            Icon(
              Icons.list,
              size: 30,
              color: Colors.black,
            )
          ]),
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget child) {
                return ClipPath(
                  clipper: BannerClipper(_animationController.value),
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
                );
              }),
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
                        childAspectRatio: 1,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                        children: <Widget>[
                          HomeCard(
                            title: "Vocabulary",
                            logoSvg: "assets/icons/vocabulary.svg",
                            press: () {},
                          ),
                          HomeCard(
                            title: "Grammar",
                            logoSvg: "assets/icons/vocabulary.svg",
                            press: () {},
                          ),
                          HomeCard(
                            title: "Note",
                            logoSvg: "assets/icons/vocabulary.svg",
                            press: () {},
                          ),
                          HomeCard(
                            title: "Dictionary",
                            logoSvg: "assets/icons/vocabulary.svg",
                            press: () {},
                          ),
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

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomNavCliper(),
      child: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0XFFbdc3c7), Color(0XFF2c3e50)])),
        height: 60,
        child: CustomPaint(
          painter: BorderNavigation(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[Text("A"), Text("B")],
          ),
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String title;
  final String logoSvg;
  final Function press;
  const HomeCard({Key key, this.title, this.logoSvg, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: Offset(5, 5),
              blurRadius: 5,
              spreadRadius: -2,
              color: kShadowColor)
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                SvgPicture.asset(logoSvg),
                Spacer(),
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0XFF2c3e50)),
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BannerClipper extends CustomClipper<Path> {
  double move = 0;
  BannerClipper(this.move);
  @override
  Path getClip(Size size) {
    final path = new Path();
    path.lineTo(0, size.height - 80);
    double xCenter = size.width / 2 + (size.width * 0.6) * sin(move * pi);
    double yCenter = size.height + cos(move * pi);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BottomNavCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = new Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2 + 40, 0);
    path.addArc(
        Rect.fromCenter(
            center: Offset(size.width / 2, 0), height: 80, width: 80),
        pi * 2,
        pi);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BorderNavigation extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.color = Color(0XFFA9A9A9);

    final path = new Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2 + 40, 0);
    path.addArc(
        Rect.fromCenter(
            center: Offset(size.width / 2, 0), height: 80, width: 80),
        pi * 2,
        pi);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
